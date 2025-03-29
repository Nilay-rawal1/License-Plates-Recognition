import 'package:driver_review_capstone/const/constants.dart';
import 'package:driver_review_capstone/screens/authentication/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/data_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? userId;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('userId');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ReviewDataProvider>(
      builder: (context, reviewDataProvider, child) {
        final userData = userId != null ? reviewDataProvider.getUserData(userId!) : null;
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: kPrimaryColor,
            title: const Text(
              'Driver Review',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () async {
                  reviewDataProvider.removeValueFromCache();
                  if (!context.mounted) return;
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (Route<dynamic> route) => false,
                  );
                },
                icon: const Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          body: userId == null
              ? const Center(child: CircularProgressIndicator())
              : userData == null
                  ? const Center(child: Text("No user data found", style: TextStyle(color: kDark)))
                  : Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            userInfoCard(userData),
                            const SizedBox(height: 20.0),
                            yourReviewCard(userData),
                            const SizedBox(height: 20.0),
                            reviewAboutYouCard(userData),
                          ],
                        ),
                      ),
                    ),
        );
      },
    );
  }

  Container userInfoCard(Map<String, dynamic> userData) {
    Widget ratingEmoji(double rating) {
      if (rating >= 3.5) {
        return const Icon(
          Icons.sentiment_very_satisfied_rounded,
          color: Colors.green,
          size: 70.0,
        );
      } else if (rating >= 2.5 && rating < 3.5) {
        return const Icon(
          Icons.sentiment_satisfied_rounded,
          color: Colors.yellow,
          size: 70.0,
        );
      } else {
        return const Icon(
          Icons.sentiment_very_dissatisfied_rounded,
          color: Colors.red,
          size: 70.0,
        );
      }
    }

    return Container(
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
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userData['userName'],
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: kDark,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  userData['driverLicenseNumber'],
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: kGrey,
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  'Current Rating - ${userData['currentRating']}',
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.normal,
                    color: kDark,
                  ),
                ),
                RatingBar.builder(
                  ignoreGestures: true,
                  initialRating: userData['currentRating'].toDouble(),
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
              ],
            ),
            const Spacer(),
            ratingEmoji(userData['currentRating'].toDouble()),
          ],
        ),
      ),
    );
  }

  Container yourReviewCard(Map<String, dynamic> userData) {
    List<dynamic> yourReviews = userData['yourReviews'];

    var latestReview = yourReviews.isNotEmpty
        ? yourReviews.reduce((a, b) =>
            DateTime.parse(a['reviewDate']).isAfter(DateTime.parse(b['reviewDate'])) ? a : b)
        : null;

    return Container(
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
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Your Reviews',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: kDark,
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    'Total reviews - ${yourReviews.length},   Last review - ${latestReview != null ? DateFormat('dd MMM, yyyy').format(DateTime.parse(latestReview['reviewDate'])) : 'N/A'}',
                    style: const TextStyle(
                        fontSize: 12.0, fontWeight: FontWeight.normal, color: kGrey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4.0),
            Divider(
              thickness: 2.0,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 4.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: latestReview == null
                  ? Center(
                      child: Text(
                        'No reviews yet!',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF10142D).withValues(alpha: 0.7),
                        ),
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: latestReview['review'],
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF10142D).withValues(alpha: 0.7),
                              fontStyle: FontStyle.italic,
                            ),
                            children: const [
                              TextSpan(
                                text: " See more",
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            RatingBar.builder(
                              ignoreGestures: true,
                              initialRating: latestReview['rating'].toDouble(),
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
                              '(${latestReview['rating']})',
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
          ],
        ),
      ),
    );
  }

  Container reviewAboutYouCard(Map<String, dynamic> userData) {
    List<dynamic> reviewsAboutYou = userData['reviewsAboutYou'];
    var latestReview = reviewsAboutYou.isNotEmpty
        ? reviewsAboutYou.reduce((a, b) =>
            DateTime.parse(a['reviewDate']).isAfter(DateTime.parse(b['reviewDate'])) ? a : b)
        : null;

    return Container(
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
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Reviews About You',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: kDark,
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    'Total reviews - ${reviewsAboutYou.length},   Last review - ${latestReview != null ? DateFormat('dd MMM, yyyy').format(DateTime.parse(latestReview['reviewDate'])) : 'N/A'}',
                    style: const TextStyle(
                        fontSize: 12.0, fontWeight: FontWeight.normal, color: kGrey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4.0),
            Divider(
              thickness: 2.0,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 4.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: latestReview == null
                  ? Center(
                      child: Text(
                        'No reviews yet!',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF10142D).withValues(alpha: 0.7),
                        ),
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: latestReview['review'],
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF10142D).withValues(alpha: 0.7),
                              fontStyle: FontStyle.italic,
                            ),
                            children: const [
                              TextSpan(
                                text: " See more",
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            RatingBar.builder(
                              ignoreGestures: true,
                              initialRating: latestReview['rating'].toDouble(),
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
                              '(${latestReview['rating']})',
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
          ],
        ),
      ),
    );
  }
}
