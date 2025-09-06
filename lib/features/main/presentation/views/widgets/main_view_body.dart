import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:med_tech_admin/core/widgets/responsive.dart';
import 'package:med_tech_admin/features/main/presentation/views/widgets/Header.dart';
import 'package:med_tech_admin/features/main/presentation/views/widgets/sideBar/sidebar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../auth/data/models/user_model.dart';
import '../../../../auth/domain/entities/user_entity.dart';
import '../../../data/pages.dart';

class MainViewBody extends StatefulWidget {
  const MainViewBody({super.key});

  @override
  State<MainViewBody> createState() => _MainViewBodyState();
}

class _MainViewBodyState extends State<MainViewBody> {
  int selectedIndex = 0;

  void onItemSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  UserEntity? user;
  @override
  void initState() {
    getToken();

    super.initState();
  }

  getToken() async {
    final prfs = await SharedPreferences.getInstance();
    user = UserModel.fromJson(jsonDecode(prfs.getString("user")!)).toEntity();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Responsive.isDesktop(context)
        ? Row(
          children: [
            Sidebar(
              selectedIndex: selectedIndex,
              onItemSelected: onItemSelected,
            ),
            Expanded(
              child: ListView(
                children: [
                  Header(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                    child: getPages(user!.role)[selectedIndex],
                  ),
                ],
              ),
            ),
          ],
        )
        : ListView(
          scrollDirection: Axis.horizontal,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Sidebar(
                selectedIndex: selectedIndex,
                onItemSelected: onItemSelected,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                children: [
                  Header(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                    child: getPages(user!.role)[selectedIndex],
                  ),
                ],
              ),
            ),
          ],
        );
  }
}
