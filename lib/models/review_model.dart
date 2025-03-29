class ReviewModel {
  String userId;
  String plateNumber;
  String review;
  String rating;
  String reviewDate;

  ReviewModel({
    required this.userId,
    required this.plateNumber,
    required this.review,
    required this.rating,
    required this.reviewDate,
  });

  /// Factory constructor to create a `ReviewModel` from JSON
  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      userId: json['userId'],
      plateNumber: json['plateNumber'],
      review: json['review'],
      rating: json['rating'],
      reviewDate: json['reviewDate'],
    );
  }

  /// Converts a `ReviewModel` to a JSON format
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'plateNumber': plateNumber,
      'review': review,
      'rating': rating,
      'reviewDate': reviewDate,
    };
  }
}
