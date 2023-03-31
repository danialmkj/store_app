import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:store_app/features/feature_intro/presentation/screens/home_screen.dart';
import 'package:store_app/features/feature_intro/presentation/widgets/get_start_btn.dart';
import 'package:store_app/features/feature_intro/presentation/widgets/intro_page.dart';

import '../bloc/intro_cubit/intro_cubit.dart';

class IntroMainWrapper extends StatelessWidget {
  IntroMainWrapper({super.key});

  static const routeName = '/intro_main_wrapper';

  PageController pageController = PageController();

  final List<Widget> introPages = [
    const IntroPage(
      title: 'تخصص حرف اول رو میزنه!',
      description:
          'اپلیکیشن تخصصی خرید و فروش انواع قطعات یدکی خودروهای داخلی و خارجی با ضمانت اصالت کالا و نازلترین قیمت',
      image: "assets/images/benz.png",
    ),
    const IntroPage(
      title: 'آسان خرید و فروش کن!',
      description: 'خرید و فروش سریع و آسان همراه با تیم پشتیبانی قوی',
      image: "assets/images/bmw.png",
    ),
    const IntroPage(
      title: 'همه چی اینجا هست!',
      description: 'ثبت قطعات کمیاب و خرید و فروش عمده تنها با یک کلیک',
      image: "assets/images/tara.png",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    //var arg = ModalRoute.of(context)!.settings.arguments as String; //fetch arguments from last screen

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (context) => IntroCubit(),
      child: Builder(builder: (context) {
        return Scaffold(
          body: Stack(
            children: [
              //! set background
              Positioned(
                  top: 0,
                  child: Container(
                    width: width,
                    height: height * 0.6,
                    decoration: const BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(150))),
                    //child: Image.asset('assets/images/benz.png'),
                  )),

              //! set img & Tit & des
              Positioned(
                  bottom: height * 0.1,
                  child: SizedBox(
                      width: width,
                      height: height * 0.9,
                      child: PageView(
                        controller: pageController,
                        children: introPages,
                        onPageChanged: (index) {
                          if(index == 2 ){
                            BlocProvider.of<IntroCubit>(context).changeGetStart(true);
                          }else{
                            BlocProvider.of<IntroCubit>(context).changeGetStart(false);
                          }
                        },
                      ))),

              //! btn
              Positioned(
                  bottom: height * 0.07,
                  right: 30,
                  child: BlocBuilder<IntroCubit, IntroState>(
                    builder: (context, state) {
                      if (state.showGetStart) {
                        return DelayedWidget(
                            delayDuration: const Duration(
                                milliseconds: 200), // Not required
                            animationDuration:
                                const Duration(seconds: 1), // Not required
                            animation: DelayedAnimations
                                .SLIDE_FROM_RIGHT, // Not requiredchild:
                            child: GetStartBtn(
                                text: 'شروع کنید',
                                onTap: () {
                                  Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      HomeScreen.routeName,
                                      ModalRoute.withName('/home_screen'));
                                }));
                      } else {
                        return DelayedWidget(
                            delayDuration: const Duration(
                                milliseconds: 200), // Not required
                            animationDuration:
                                const Duration(seconds: 1), // Not required
                            animation: DelayedAnimations
                                .SLIDE_FROM_RIGHT, // Not requiredchild:
                            child: GetStartBtn(
                                text: 'ورق بزن',
                                onTap: () {
                                  if (pageController.page!.toInt() < 2) {
                                    //display new btn
                                    if (pageController.page!.toInt() == 2) {
                                      BlocProvider.of<IntroCubit>(context)
                                          .changeGetStart(true);
                                    } else {
                                      BlocProvider.of<IntroCubit>(context)
                                          .changeGetStart(false);
                                    }

                                    //navigate to other intro
                                    pageController.animateToPage(
                                        pageController.page!.toInt() + 1,
                                        duration: Duration(milliseconds: 400),
                                        curve: Curves.easeIn);
                                  }
                                }));
                      }
                    },
                  )),

              //! dot indicator
              Positioned(
                  bottom: height * 0.07,
                  left: 30,
                  child: DelayedWidget(
                      delayDuration:
                          const Duration(milliseconds: 200), // Not required
                      animationDuration:
                          const Duration(seconds: 1), // Not required
                      animation: DelayedAnimations
                          .SLIDE_FROM_RIGHT, // Not requiredchild:
                      child: SmoothPageIndicator(
                          controller: pageController, count: 3)))
            ],
          ),
        );
      }),
    );
  }
}
