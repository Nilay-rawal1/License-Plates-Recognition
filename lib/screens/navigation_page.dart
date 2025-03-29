import 'dart:io';
import 'package:driver_review_capstone/const/constants.dart';
import 'package:driver_review_capstone/screens/add_review.dart';
import 'package:driver_review_capstone/screens/home_page.dart';
import 'package:driver_review_capstone/screens/reviews_about_you.dart';
import 'package:driver_review_capstone/screens/your_reviews.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomePage(),
    const YourReviews(),
    const AddReview(),
    const ReviewsAboutYou(),
  ];

  List<BottomNavigationBarItem> _navBarItems() {
    return [
      const BottomNavigationBarItem(
        icon: Icon(Icons.home_outlined),
        activeIcon: Icon(Icons.home),
        label: '',
      ),
      const BottomNavigationBarItem(
        activeIcon: Icon(Icons.reviews_rounded),
        icon: Icon(Icons.reviews_outlined),
        label: '',
      ),
      const BottomNavigationBarItem(
        activeIcon: Icon(Icons.add_comment),
        icon: Icon(Icons.add_comment_outlined),
        label: '',
      ),
      const BottomNavigationBarItem(
        activeIcon: Icon(Icons.rate_review),
        icon: Icon(Icons.rate_review_outlined),
        label: '',
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
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: kGrey, width: 0.3)),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          items: _navBarItems(),
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          backgroundColor: Colors.white,
          selectedItemColor: kPrimaryColor,
          unselectedItemColor: kPrimaryColor,
          iconSize: 36,
          type: BottomNavigationBarType.fixed,
          enableFeedback: true,
          selectedLabelStyle: const TextStyle(fontSize: 0.5),
          unselectedLabelStyle: const TextStyle(fontSize: 0.5),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 12.0, right: 5.0),
        child: FloatingActionButton(
          backgroundColor: kPrimaryColor,
          elevation: 6.0,
          onPressed: () async {
            File? image = await openCamera();
            if (image != null && context.mounted) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddReview(image: image),
                ),
              );
            }
          },
          child: const Icon(
            Icons.camera_alt_outlined,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }
}
