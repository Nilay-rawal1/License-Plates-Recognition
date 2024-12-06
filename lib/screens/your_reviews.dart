import 'package:flutter/material.dart';
import '../const/constants.dart';
import '../models/review_model.dart';

class YourReviews extends StatelessWidget {
  const YourReviews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          'Your Reviews',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: kDark,
          ),
        ),
      ),
      body: reviewListBuilder(context, reviews),
    );
  }

  ListView reviewListBuilder(
      BuildContext context, List<ReviewModel> reviewList) {
    return ListView.builder(
      padding: const EdgeInsets.all(20.0),
      shrinkWrap: true,
      itemCount: reviewList.length,
      itemBuilder: (context, index) {
        ReviewModel reviewData = reviewList[index];
        return reviewCard(reviewData);
      },
    );
  }

  Card reviewCard(ReviewModel reviewData) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  reviewData.plateNumber,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: kDark,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                Text(
                  reviewData.reviewDate,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Color(0xFF10142D).withOpacity(0.9),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    reviewData.review,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Color(0xFF10142D).withOpacity(0.9),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
