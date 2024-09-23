import 'package:driver_review_capstone/const/constants.dart';
import 'package:driver_review_capstone/models/review_model.dart';
import 'package:driver_review_capstone/screens/add_review.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primaryColor,
        title: Text(
          'Driver Review',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddReview(),
            ),
          );
        },
        child: Icon(
          Icons.reviews_outlined,
          color: Colors.white,
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
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                Text(
                  reviewData.reviewDate,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black45,
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
                      color: Colors.black54,
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
