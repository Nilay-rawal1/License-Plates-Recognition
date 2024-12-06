import 'dart:io';
import 'package:driver_review_capstone/const/constants.dart';
import 'package:driver_review_capstone/screens/add_review.dart';
import 'package:driver_review_capstone/screens/home_page.dart';
import 'package:driver_review_capstone/screens/profile_page.dart';
import 'package:driver_review_capstone/screens/reviews_about_you.dart';
import 'package:driver_review_capstone/screens/your_reviews.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  List<Widget> _screens() {
    return [
      HomePage(),
      YourReviews(),
      AddReview(),
      ReviewsAboutYou(),
      ProfilePage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarItems() {
    return [
      PersistentBottomNavBarItem(
        iconSize: 32,
        icon: Icon(Icons.home),
        inactiveIcon: Icon(Icons.home_outlined),
        activeColorPrimary: kPrimaryColor,
        inactiveColorPrimary: kPrimaryColor,
      ),
      PersistentBottomNavBarItem(
        iconSize: 32,
        icon: Icon(Icons.reviews_rounded),
        inactiveIcon: Icon(Icons.reviews_outlined),
        activeColorPrimary: kPrimaryColor,
        inactiveColorPrimary: kPrimaryColor,
      ),
      PersistentBottomNavBarItem(
        iconSize: 34,
        icon: Icon(Icons.add_comment),
        inactiveIcon: Icon(Icons.add_comment_outlined),
        activeColorPrimary: kPrimaryColor,
        inactiveColorPrimary: kPrimaryColor,
      ),
      PersistentBottomNavBarItem(
        iconSize: 32,
        icon: Icon(Icons.rate_review),
        inactiveIcon: Icon(Icons.rate_review_outlined),
        activeColorPrimary: kPrimaryColor,
        inactiveColorPrimary: kPrimaryColor,
      ),
      PersistentBottomNavBarItem(
        iconSize: 32,
        icon: Icon(Icons.person_2),
        inactiveIcon: Icon(Icons.person_2_outlined),
        activeColorPrimary: kPrimaryColor,
        inactiveColorPrimary: kPrimaryColor,
      ),
    ];
  }

  Future<File?> openCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    if (photo == null) return null;
    return File(photo.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _screens(),
        items: _navBarItems(),
        decoration: NavBarDecoration(
          boxShadow: [
            BoxShadow(
              color: Color(0x9a9a9a).withOpacity(1),
              offset: Offset(1, -1.5),
              blurRadius: 2,
              spreadRadius: -2,
            ),
          ],
        ),
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: false,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 12.0, right: 5.0),
          child: FloatingActionButton(
            backgroundColor: kPrimaryColor,
            elevation: 6.0,
            onPressed: () async {
              File? image = await openCamera();
              if (image != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddReview(image: image),
                  ),
                );
              }
            },
            child: Icon(
              Icons.camera_alt_outlined,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
        animationSettings: const NavBarAnimationSettings(
          navBarItemAnimation: ItemAnimationSettings(
            // Navigation Bar's items animation properties.
            duration: Duration(milliseconds: 400),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: ScreenTransitionAnimationSettings(
            // Screen transition animation on change of selected tab.
            animateTabTransition: true,
            duration: Duration(milliseconds: 300),
            screenTransitionAnimationType: ScreenTransitionAnimationType.fadeIn,
          ),
        ),
        navBarStyle: NavBarStyle.style13,
      ),
    );
  }
}
