import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../const/constants.dart';

class AddReview extends StatefulWidget {
  const AddReview({super.key});

  @override
  State<AddReview> createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  bool isImageUploaded = false;
  File? selectedImage;

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text(
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
          child: Row(
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
            child: Text(
              'Remove',
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.redAccent,
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.rate_review_outlined,
                size: 24.0,
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                'Write Review',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          TextField(
            maxLines: null,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black45, width: 1.3),
                borderRadius: BorderRadius.circular(20.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: kPrimaryColor, width: 2.0),
                borderRadius: BorderRadius.circular(20.0),
              ),
              suffixIcon: const Icon(
                Icons.mic,
                color: kPrimaryColor,
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(backgroundColor: kPrimaryColor),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Post Review',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
