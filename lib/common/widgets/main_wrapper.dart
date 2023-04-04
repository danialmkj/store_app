import 'package:flutter/material.dart';
import 'package:store_app/common/widgets/bottom_nav.dart';
import 'package:store_app/features/feature_product/presentation/screens/category_screen.dart';

import '../../features/feature_home/presentation/screens/home_screen.dart';
import '../../features/feature_product/presentation/widgets/searchbox_widget.dart';
import '../../features/feature_product/repository/all_product_repository.dart';
import '../../locator.dart';

class MainWrapper extends StatelessWidget {
  MainWrapper({super.key});

  static const routeName = '/main_wrapper';

  PageController pageController = PageController();
  TextEditingController searchController = TextEditingController();

  List<Widget> topLevelScreen = [
    HomeScreen(),
    CategoryScreen(),
    Container(
      color: Colors.amber,
    ),
    Container(
      color: Colors.purple,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNav(controller: pageController),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10,),

            /// search Box
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 2,
                        color: Colors.grey.shade400,
                        offset: const Offset(0, 3)
                    )
                  ]
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0,right: 10, bottom: 10),
                child: SearchTextField(controller: searchController, allProductsRepository: locator<AllProductsRepository>(),),
              ),
            ),
            const SizedBox(height: 10,),

          Expanded(
            child: PageView(
              controller: pageController,
              children: topLevelScreen,
            ),
          ),
        ],
      ),
    ));
  }
}
