import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/common/utils/custom_snackbar.dart';
import 'package:store_app/common/widgets/dot_loading_widget.dart';
import 'package:store_app/features/feature_home/data/models/home_model.dart';
import 'package:store_app/features/feature_home/presentation/bloc/home_cubit/home_cubit.dart';
import 'package:store_app/locator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routeName = '/home_screen';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) => HomeCubit(locator()),
      child: Builder(
        builder: (context) {

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
                return Center(child: DotLoadingWidget(size: 30,));


              //complete state  
              } if(state.homeDataStatus is HomeDataCompleted){
                 
                 HomeDataCompleted homeDataCompleted = state.homeDataStatus as HomeDataCompleted;

                  HomeModel homeModel = homeDataCompleted.homeModel;

                  log('NEW PARAMETER is ' + homeModel.data!.suggestionProducts![0].items![0].category!);


                  return Center(child: Text(homeModel.data!.banners![0].image! ?? "null complete" ,style: TextStyle(color: Colors.black) ,),);


              
              //error state  
              } if(state.homeDataStatus is HomeDataError){
                  final HomeDataError homeDataError = state.homeDataStatus as HomeDataError;

                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  [
                        Text(homeDataError.errorMessage,style: const TextStyle(color: Colors.white),),
                        const SizedBox(height: 10,),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: Colors.amber.shade800),
                          onPressed: (){
                            /// call all data again
                            BlocProvider.of<HomeCubit>(context).callHomeDataEvent();
                          },
                          child: const Text("تلاش دوباره"),)
                      ],
                    ),
                  );
                }

                return Container();
            },
          );
        }
      ),
    );
  }
}
