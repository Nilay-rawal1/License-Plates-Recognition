import 'package:driver_review_capstone/const/constants.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.construction,
                color: kPrimaryColor,
                size: 48.0,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'Under Construction',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: kDark,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
