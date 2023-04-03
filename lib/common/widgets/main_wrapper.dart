import 'package:flutter/material.dart';
import 'package:store_app/common/widgets/bottom_nav.dart';

import '../../features/feature_home/presentation/screens/home_screen.dart';

class MainWrapper extends StatelessWidget {
   MainWrapper({super.key});

   static const routeName = '/main_wrapper'; 

    PageController pageController = PageController();

    List<Widget> topLevelScreen =[
      HomeScreen(),
      Container(color: Colors.blue,),
      Container(color: Colors.amber,),
      Container(color: Colors.purple,),
    ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: BottomNav(controller: pageController),
    

      body: Column(
        children: [

          //search bar


          SizedBox(height: 10,),
            
          Expanded(
            child: PageView(
              controller: pageController,
              children: topLevelScreen,
            ),
          ),
        ],
      ),  
    
    );
  }
}