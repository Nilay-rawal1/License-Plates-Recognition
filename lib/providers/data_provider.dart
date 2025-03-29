import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/review_model.dart';

class ReviewDataProvider extends ChangeNotifier {
  Map<String, dynamic> _jsonData = {};
  static const String _dataKey = 'review_data';

  Map<String, dynamic> get jsonData => _jsonData;

  ReviewDataProvider() {
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final String? savedData = prefs.getString(_dataKey);

    if (savedData != null) {
      _jsonData = jsonDecode(savedData);
    } else {
      String jsonString = await rootBundle.loadString('assets/data/data.json');
      _jsonData = jsonDecode(jsonString);
      await _saveData();
    }
    notifyListeners();
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_dataKey, jsonEncode(_jsonData));
  }

  void addReview(
      String userId, String plateNumber, String review, double rating, String reviewDate) {
    final users = _jsonData['users'] as List<dynamic>;
    final currentUserIndex = users.indexWhere((user) => user['userId'] == userId);

    if (currentUserIndex != -1) {
      final yourReviews = users[currentUserIndex]['yourReviews'] as List<dynamic>;
      yourReviews.add({
        'plateNumber': plateNumber,
        'rating': rating,
        'review': review,
        'reviewDate': reviewDate,
      });
    }
    _saveData();
    notifyListeners();
  }

  Future<void> removeValueFromCache() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove('userId');
    await sharedPreferences.remove('review_data');

    _jsonData = {};
    await _loadData();
    notifyListeners();
  }

  List<ReviewModel> getYourReviews(String userId) {
    final users = _jsonData['users'] as List<dynamic>;
    final user = users.firstWhere((user) => user['userId'] == userId, orElse: () => null);
    if (user == null) return [];
    List<ReviewModel> reviews = (user['yourReviews'] as List<dynamic>)
        .map((review) => ReviewModel(
              userId: userId,
              plateNumber: review['plateNumber'],
              rating: review['rating'].toString(),
              review: review['review'],
              reviewDate: review['reviewDate'],
            ))
        .toList();
    reviews.sort((a, b) => b.reviewDate.compareTo(a.reviewDate));
    return reviews;
  }

  List<ReviewModel> getReviewsAboutYou(String userId) {
    final users = _jsonData['users'] as List<dynamic>;
    final user = users.firstWhere((user) => user['userId'] == userId, orElse: () => null);
    if (user == null) return [];
    List<ReviewModel> reviews = (user['reviewsAboutYou'] as List<dynamic>)
        .map((review) => ReviewModel(
              userId: userId,
              plateNumber: review['plateNumber'],
              rating: review['rating'].toString(),
              review: review['review'],
              reviewDate: review['reviewDate'],
            ))
        .toList();

    reviews.sort((a, b) => b.reviewDate.compareTo(a.reviewDate));
    return reviews;
  }

  Map<String, dynamic>? getUserData(String userId) {
    final users = _jsonData['users'] as List<dynamic>;
    return users.firstWhere((user) => user['userId'] == userId, orElse: () => null);
  }
}
