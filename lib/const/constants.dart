import 'dart:ui';
import 'package:driver_review_capstone/models/review_model.dart';

const Color primaryColor = Color(0xFF3870BE);

final List<ReviewModel> reviews = [
  ReviewModel(
    plateNumber: "MH12AB1234",
    review:
        "I saw this driver weaving through traffic without signaling. It was dangerous, and they almost caused an accident.",
    reviewDate: "01-09-2024",
  ),
  ReviewModel(
    plateNumber: "DL9CAF5678",
    review:
        "This driver was very patient, letting pedestrians cross and maintaining a safe distance from other cars. A responsible driver!",
    reviewDate: "02-09-2024",
  ),
  ReviewModel(
    plateNumber: "KA05MK4321",
    review:
        "Spotted this car speeding and tailgating. The driver was honking unnecessarily and being aggressive on the road.",
    reviewDate: "03-09-2024",
  ),
  ReviewModel(
    plateNumber: "TN07JK8765",
    review:
        "This driver was very courteous, allowing others to merge and driving at a steady, safe speed. A pleasure to drive alongside.",
    reviewDate: "04-09-2024",
  ),
  ReviewModel(
    plateNumber: "GJ01GH9876",
    review:
        "Driver was constantly cutting off other cars without using indicators. Very reckless and unsafe driving behavior.",
    reviewDate: "05-09-2024",
  ),
];
