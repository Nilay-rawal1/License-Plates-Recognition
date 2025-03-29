import 'package:driver_review_capstone/providers/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../const/constants.dart';
import '../models/review_model.dart';

class YourReviews extends StatefulWidget {
  const YourReviews({super.key});

  @override
  State<YourReviews> createState() => _YourReviewsState();
}

class _YourReviewsState extends State<YourReviews> {
  String? userId;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedUserId = prefs.getString('userId');
    setState(() => userId = storedUserId);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ReviewDataProvider>(
      builder: (context, reviewDataProvider, child) {
        final List<ReviewModel> reviews =
            userId != null ? reviewDataProvider.getYourReviews(userId!) : [];
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: kPrimaryColor,
            title: const Text(
              'Your Reviews',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          body: userId == null
              ? const Center(child: CircularProgressIndicator())
              : reviews.isEmpty
                  ? const Center(child: Text("No reviews found", style: TextStyle(color: kDark)))
                  : reviewListBuilder(reviews),
        );
      },
    );
  }

  ListView reviewListBuilder(List<ReviewModel> reviews) {
    return ListView.builder(
      padding: const EdgeInsets.all(20.0),
      shrinkWrap: true,
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        return reviewCard(reviews[index]);
      },
    );
  }

  Container reviewCard(ReviewModel reviewData) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.5),
            blurRadius: 3,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  reviewData.plateNumber,
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: kDark,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Text(
                  DateFormat('dd-MM-yyyy').format(DateTime.parse(reviewData.reviewDate)),
                  style: TextStyle(
                    fontSize: 14.0,
                    color: const Color(0xFF10142D).withValues(alpha: 0.9),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              children: [
                Expanded(
                  child: Text(
                    reviewData.review,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: const Color(0xFF10142D).withValues(alpha: 0.9),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                RatingBar.builder(
                  ignoreGestures: true,
                  initialRating: double.parse(reviewData.rating),
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 18.0,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 0.5),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: kPrimaryColor,
                  ),
                  onRatingUpdate: (rating) {},
                ),
                Text(
                  '(${double.parse(reviewData.rating)})',
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: kGrey,
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
