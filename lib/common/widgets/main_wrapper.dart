import 'package:flutter/material.dart';
import 'package:store_app/common/widgets/bottom_nav.dart';

class MainWrapper extends StatelessWidget {
   MainWrapper({super.key});

   static const routeName = '/main_wrapper'; 

    PageController pageController = PageController();

    List<Widget> topLevelScreen =[
      Container(color: Colors.red,),
      Container(color: Colors.blue,),
      Container(color: Colors.amber,),
      Container(color: Colors.purple,),
    ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: BottomNav(controller: pageController),
    

      body: PageView(
        controller: pageController,
        children: topLevelScreen,
      ),  
    
    );
  }
}