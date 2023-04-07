import 'package:flutter/material.dart';
import 'package:store_app/features/feature_home/presentation/widgets/profile_list_tiles.dart';
import '../utils/profile_list_model.dart';

class ProfileScreen extends StatelessWidget {
 ProfileScreen({super.key});

  List<ProfileListModel> listProfiles = [
    ProfileListModel(iconData: Icons.person, title: "حساب کاربری شخصی", onTap: (){print("item1");}),
    ProfileListModel(iconData: Icons.shopping_bag_outlined, title: "حساب کاربری فروشگاهی", onTap: (){print("item2");}),
    ProfileListModel(iconData: Icons.archive_rounded, title: "سفارشات", onTap: (){print("item3");}),
    ProfileListModel(iconData: Icons.home_work, title: "آدرس من", onTap: (){print("item4");}),
    ProfileListModel(iconData: Icons.support_agent, title: "پشتیبانی", onTap: (){print("item5");}),
    ProfileListModel(iconData: Icons.exit_to_app, title: "خروج از حساب", onTap: (){print("item6");}),
  ];


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemCount: listProfiles.length,
          itemBuilder: (BuildContext context, int index) {
            return ProfileListTile(
              title: listProfiles[index].title,
              onTap: listProfiles[index].onTap,
              isLast: (index == listProfiles.length - 1) ? true : false);
          },
        ),
      ],
    );
  }
}