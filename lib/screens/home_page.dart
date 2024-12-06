import 'package:driver_review_capstone/const/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          'Driver Review',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: kDark,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 3.0,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'John Doe',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: kDark,
                            ),
                          ),
                          SizedBox(
                            height: 4.0,
                          ),
                          Text(
                            'DL-0420110149XXXX',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: kGrey,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'Current Rating - 4.2',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.normal,
                              color: kDark,
                            ),
                          ),
                          RatingBar.builder(
                            ignoreGestures: true,
                            initialRating: 4.5,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 18.0,
                            itemPadding: EdgeInsets.symmetric(horizontal: 0.5),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: kPrimaryColor,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                        ],
                      ),
                      Spacer(),
                      Icon(
                        Icons.sentiment_very_satisfied_rounded,
                        color: Colors.green,
                        size: 70.0,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              yourReviewCard(),
              SizedBox(
                height: 10.0,
              ),
              reviewAboutYouCard(),
            ],
          ),
        ),
      ),
    );
  }

  Card yourReviewCard() {
    return Card(
      elevation: 3.0,
      color: Colors.white,
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
                  Text(
                    'Your Reviews',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: kDark,
                    ),
                  ),
                  SizedBox(
                    height: 2.0,
                  ),
                  Text(
                    'Total reviews - 4,   Last review - 2/12/24',
                    style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.normal,
                        color: kGrey),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 4.0,
            ),
            Divider(
              thickness: 2.0,
              color: Colors.grey[300],
            ),
            SizedBox(
              height: 4.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text:
                          "This driver was reckless and impatient, cutting lanes without signaling and speeding in a crowded area. Such behavior puts everyone on the road at risk.",
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF10142D).withOpacity(0.7),
                        fontStyle: FontStyle.italic,
                      ),
                      children: [
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
                  SizedBox(
                    height: 4.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RatingBar.builder(
                        ignoreGestures: true,
                        initialRating: 3.0,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 18.0,
                        itemPadding: EdgeInsets.symmetric(horizontal: 0.5),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: kPrimaryColor,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                      Text(
                        '(3)',
                        style: TextStyle(
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

  Card reviewAboutYouCard() {
    return Card(
      elevation: 3.0,
      color: Colors.white,
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
                  Text(
                    'Reviews About You',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: kDark,
                    ),
                  ),
                  SizedBox(
                    height: 2.0,
                  ),
                  Text(
                    'Total reviews - 2,   Last review - 27/11/24',
                    style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.normal,
                        color: kGrey),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 4.0,
            ),
            Divider(
              thickness: 2.0,
              color: Colors.grey[300],
            ),
            SizedBox(
              height: 4.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text:
                          "The driver of this car was very courteous and followed all traffic rules. They gave way to pedestrians and maintained a safe distance from other vehicles. A perfect example of responsible driving!",
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF10142D).withOpacity(0.7),
                        fontStyle: FontStyle.italic,
                      ),
                      children: [
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
                  SizedBox(
                    height: 4.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RatingBar.builder(
                        ignoreGestures: true,
                        initialRating: 4.5,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 18.0,
                        itemPadding: EdgeInsets.symmetric(horizontal: 0.5),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: kPrimaryColor,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                      Text(
                        '(4.5)',
                        style: TextStyle(
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
