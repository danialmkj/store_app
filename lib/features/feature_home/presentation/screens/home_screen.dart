import 'dart:async';
import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:store_app/common/widgets/dot_loading_widget.dart';
import 'package:store_app/features/feature_home/data/models/home_model.dart';
import 'package:store_app/features/feature_home/presentation/bloc/home_cubit/home_cubit.dart';
import 'package:store_app/locator.dart';

import '../../../../config/responsive.dart';
import '../widgets/category_widget.dart';

class HomeScreen extends StatefulWidget {
   HomeScreen({super.key});

  static const routeName = '/home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController pageViewController = PageController();

  Timer?  _timer;
  int _currentPage = 0;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    if (_timer != null) {
      _timer!.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (context) => HomeCubit(locator()),
      child: Builder(builder: (context) {
        //call api
        BlocProvider.of<HomeCubit>(context).callHomeDataEvent();

        return BlocBuilder<HomeCubit, HomeState>(
          buildWhen: (previous, current) {
            if (previous.homeDataStatus == current.homeDataStatus) {
              return false;
            } else {
              return true;
            }
          },
          builder: (context, state) {
            //loading state
            if (state.homeDataStatus is HomeDataLoading) {
              return Center(
                  child: DotLoadingWidget(
                size: 30,
              ));

              //complete state
            }
            if (state.homeDataStatus is HomeDataCompleted) {
              HomeDataCompleted homeDataCompleted =
                  state.homeDataStatus as HomeDataCompleted;

              HomeModel homeModel = homeDataCompleted.homeModel;

              log('NEW PARAMETER is ' + homeModel.data.banners[0].image);


                    //add timer for showing banners with animation
                  _timer ??= Timer.periodic(const Duration(seconds: 3), (Timer timer) {
                      if (_currentPage < homeModel.data!.sliders!.length - 1) {
                        _currentPage++;
                      } else {
                        _currentPage = 0;
                      }

                      if(pageViewController.positions.isNotEmpty){
                        pageViewController.animateToPage(
                          _currentPage,
                          duration: const Duration(milliseconds: 350),
                          curve: Curves.easeIn,
                        );
                      }

                    });


              return SingleChildScrollView(
                child: SafeArea(
                  child: Column(
                    children: [
                      //header banner
                      (homeModel.data!.sliders!.isNotEmpty)
                          ? SizedBox(
                            height: Responsive.isMobile(context) ? 180 : 300,
                            child: PageView.builder(
                              onPageChanged: (page){
                                // _timer.
                              },
                              allowImplicitScrolling: true,
                              controller: pageViewController,
                              physics: const BouncingScrollPhysics(),
                              itemCount: homeModel.data!.sliders!.length,
                              itemBuilder: (context, index){
                                return Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 8.0,),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: CachedNetworkImage(
                                      imageUrl: homeModel.data!.sliders![index].img!,
                                      placeholder: (context, string){
                                        return const Center(
                                          child: DotLoadingWidget(size: 40,),
                                        );
                                      },
                                      fit: BoxFit.cover,
                                      useOldImageOnUrlChange: true,
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                              : Container(),
                
                          SizedBox(height: 10,),   
                
                           (homeModel.data!.sliders!.length > 1)
                              ? Center(
                            child: SmoothPageIndicator(
                              controller: pageViewController,  // PageController
                              count:  homeModel.data!.sliders!.length,
                              effect: ExpandingDotsEffect(dotWidth: width * 0.02,dotHeight: width * 0.02,spacing: 5,activeDotColor: Colors.redAccent),  // your preferred effect
                            ),
                          )
                              : Container(),
                
                          const SizedBox(height: 10),
                
                          /// category 8
                          SizedBox(
                            height: 220,
                            child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                crossAxisSpacing: 0.0,
                                mainAxisSpacing: 8.0,
                              ),
                              itemCount: homeModel.data!.categories!.length,
                              // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              //   crossAxisCount: 4,
                              //   crossAxisSpacing: 4.0,
                              //   mainAxisSpacing: 4.0,
                              // ),
                              itemBuilder: (BuildContext context, int index){
                                final image = homeModel.data!.categories![index].img;
                                final categoryName = homeModel.data!.categories![index].title;
                
                                return GestureDetector(
                                  // onTap: (){
                                  //   Navigator.pushNamed(
                                  //     context,
                                  //     AllProductsScreen.routeName,
                                  //     arguments: ProductsArguments(categoryId: homeModel.data!.categories![index].id!),);
                                  // },
                                  child: CategoryWidget(image: image.toString(), title: categoryName.toString()),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: height * 0.01,), 
                    ],
                  ),
                ),
              );

              //error state
            }
            if (state.homeDataStatus is HomeDataError) {
              final HomeDataError homeDataError =
                  state.homeDataStatus as HomeDataError;

              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      homeDataError.errorMessage,
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.amber.shade800),
                      onPressed: () {
                        /// call all data again
                        BlocProvider.of<HomeCubit>(context).callHomeDataEvent();
                      },
                      child: const Text("تلاش دوباره"),
                    )
                  ],
                ),
              );
            }

            return Container();
          },
        );
      }),
    );
  }
}
