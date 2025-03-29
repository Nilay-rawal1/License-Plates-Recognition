import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../const/constants.dart';
import '../providers/data_provider.dart';

class AddReview extends StatefulWidget {
  final File? image;

  const AddReview({super.key, this.image});

  @override
  State<AddReview> createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  bool isLoading = false;
  bool isImageUploaded = false;
  File? selectedImage;

  double ratingValue = 0.0;
  TextEditingController reviewController = TextEditingController();
  TextEditingController numberPlateController = TextEditingController(text: 'KA01 BM 9646');

  Future pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    // final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    if (image == null) return;
    setState(() {
      selectedImage = File(image.path);
      isImageUploaded = true;
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.image != null) {
      selectedImage = widget.image;
      isImageUploaded = true;
    }
  }

  Future<String?> _getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        title: const Text(
          'Add Review',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: isImageUploaded
          ? Padding(
              padding: const EdgeInsets.all(20.0),
              child: writeReview(),
            )
          : Center(
              child: addImageButton(context),
            ),
    );
  }

  TextButton addImageButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        pickImage();
      },
      style: TextButton.styleFrom(backgroundColor: kPrimaryColor),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 10.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 2.7,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.add_photo_alternate_outlined,
                color: Colors.white,
                size: 24.0,
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                'Add Image',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget writeReview() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.width / 2,
              width: MediaQuery.of(context).size.width / 1.5,
              child: Image.file(selectedImage!),
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                isImageUploaded = false;
              });
            },
            child: const Text(
              'Remove',
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.redAccent,
              ),
            ),
          ),
          const SizedBox(height: 15.0),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.numbers,
                size: 24.0,
                color: kDark,
              ),
              SizedBox(width: 10.0),
              Text(
                'License Plate Number',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: kDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          TextField(
            controller: numberPlateController,
            maxLines: null,
            enabled: false,
            decoration: InputDecoration(
              hintText: 'License number plate',
              hintStyle: const TextStyle(
                fontSize: 16.0,
                color: kDark,
              ),
              filled: true,
              fillColor: kGrey.withValues(alpha: 0.3),
              disabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black, width: 1.5),
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: kDark,
            ),
          ),
          const SizedBox(height: 12.0),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.star_rate_outlined,
                size: 24.0,
                color: kDark,
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                'Rating',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: kDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          RatingBar.builder(
            initialRating: ratingValue,
            minRating: 0.5,
            direction: Axis.horizontal,
            allowHalfRating: true,
            unratedColor: Colors.grey[400],
            itemCount: 5,
            itemSize: 36.0,
            itemPadding: const EdgeInsets.symmetric(horizontal: 0.5),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: kPrimaryColor,
            ),
            onRatingUpdate: (rating) {
              setState(() {
                ratingValue = rating;
              });
            },
          ),
          const SizedBox(height: 12.0),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.add_comment_outlined,
                size: 24.0,
                color: kDark,
              ),
              SizedBox(width: 10.0),
              Text(
                'Write Review',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: kDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          TextField(
            controller: reviewController,
            maxLines: null,
            decoration: InputDecoration(
              hintText: 'Write your review...',
              hintStyle: TextStyle(
                fontSize: 16.0,
                color: kGrey.withValues(alpha: 0.8),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black45, width: 1.3),
                borderRadius: BorderRadius.circular(12.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: kPrimaryColor, width: 2.0),
                borderRadius: BorderRadius.circular(12.0),
              ),
              suffixIcon: const Icon(
                Icons.mic,
                color: kPrimaryColor,
              ),
            ),
            style: const TextStyle(
              fontSize: 16.0,
              color: kDark,
            ),
          ),
          const SizedBox(height: 20.0),
          SizedBox(
            height: 60.0,
            width: double.infinity,
            child: TextButton(
              onPressed: () async {
                final userId = await _getUserId();

                setState(() => isLoading = true);

                if (userId == null || reviewController.text.isEmpty || ratingValue == 0.0) {
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill all fields')),
                  );
                  setState(() => isLoading = false);
                  return;
                }
                await Future.delayed(const Duration(seconds: 2));
                if (!mounted) return;
                final reviewDataProvider = Provider.of<ReviewDataProvider>(context, listen: false);
                reviewDataProvider.addReview(
                  userId,
                  numberPlateController.text,
                  reviewController.text,
                  ratingValue,
                  DateTime.now().toString().substring(0, 10).split('-').join('-'),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text(
                      'Review Posted!',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.green.withValues(alpha: 0.8),
                  ),
                );
                setState(() {
                  reviewController.clear();
                  ratingValue = 0.0;
                  isLoading = false;
                  isImageUploaded = false;
                });
              },
              style: TextButton.styleFrom(
                backgroundColor: kPrimaryColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'Post Review',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
