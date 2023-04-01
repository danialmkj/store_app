import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:store_app/common/utils/custom_snackbar.dart';
import 'package:store_app/common/utils/prefs_operator.dart';
import 'package:store_app/features/feature_intro/presentation/bloc/splash_cubit/splash_cubit.dart';
import 'package:store_app/features/feature_intro/presentation/screens/home_screen.dart';
import 'package:store_app/features/feature_intro/presentation/screens/intro_main_wrapper.dart';
import 'package:store_app/locator.dart';

class SplashScreen extends StatefulWidget {

  static const routeName = '/';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //goToHome();

    BlocProvider.of<SplashCubit>(context)
        .checkConnectionEvent(); // call our method from this bloc
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
      color: Colors.white,
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: DelayedWidget(
                  delayDuration:
                      const Duration(milliseconds: 200), // Not required
                  animationDuration: const Duration(seconds: 1), // Not required
                  animation:
                      DelayedAnimations.SLIDE_FROM_TOP, // Not requiredchild:
                  child: Image.asset(
                    'assets/images/google_shopping_icon.png',
                    width: width * 0.5,
                  ))),
          
          
          BlocConsumer<SplashCubit, SplashState>(
            builder: (context, state) {
            
              //! user is online
              if (state.connectionStatus is ConnectionInitial || state.connectionStatus is ConnectionOn) {
                return Directionality(
                  textDirection: TextDirection.ltr,
                  child: LoadingAnimationWidget.prograssiveDots(color: Colors.red, size: 50));
              }

               //! user is offline 
              else if(state.connectionStatus is ConnectionOff){
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  const Text('شما به اینترنت متصل نیستید!' , style: TextStyle(color: Colors.red),),
                  IconButton(
                    onPressed: (){
                      //check we are online or not
                    BlocProvider.of<SplashCubit>(context).checkConnectionEvent();
                  }, 
                  icon: const Icon(Icons.autorenew_rounded))],);
              }


              //! default value 
              return Container();
            
            },
            listener: (context, state) {
              if (state.connectionStatus is ConnectionOn) {
                goToHome();
              }
            },
          ),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    ));
  }

  Future<void> goToHome() async {
    
    PrefsOperator prefsOperator = locator<PrefsOperator>();
      var shouldShowIntro  = await prefsOperator.getIntroState();

    
    return Future.delayed(const Duration(seconds: 3), () {
      //CustomSnackBar.showsnack(context, 'وارد شدید', Colors.green);
      //Navigator.of(context).pushNamed('intro_main_wrapper');
      //Navigator.of(context).pushNamed(IntroMainWrapper.routeName , arguments: 'DanialMJK'); //send argument
      
      if (shouldShowIntro) {
      
      Navigator.pushNamedAndRemoveUntil(context, IntroMainWrapper.routeName,ModalRoute.withName('intro_main_wrapper'));
        
      } else {

      Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName , ModalRoute.withName('home_screen'));

      }
    
    });
  }
}
