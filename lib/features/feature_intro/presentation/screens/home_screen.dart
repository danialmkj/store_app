import 'package:flutter/material.dart';
import 'package:store_app/common/widgets/bottom_nav.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  static const routeName = '/home_screen';

  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home'),),
    
    
    //bottomNavigationBar: BottomNav(controller: pageController),
    );
  }
}