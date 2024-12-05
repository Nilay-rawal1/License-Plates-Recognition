import 'package:driver_review_capstone/custom_widgets/custom_text_field.dart';
import 'package:driver_review_capstone/screens/authentication/login_page.dart';
import 'package:flutter/material.dart';
import '../../const/constants.dart';
import '../home_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController licenseController = TextEditingController();
  final TextEditingController numberPlateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'Sign up',
          style: TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.bold,
            color: kDark,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'First name',
                          style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.w600,
                            color: kDark,
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        CustomTextField(
                          hintText: 'First name',
                          controller: firstNameController,
                          autoFocus: true,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Last name',
                          style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.w600,
                            color: kDark,
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        CustomTextField(
                          hintText: 'Last Name',
                          controller: lastNameController,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Center(
                    child: Hero(
                      tag: 'appLogo',
                      child: SizedBox(
                        height: 200,
                        child: Image.asset('assets/driver_review_logo.png'),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'Email address',
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.w600,
                  color: kDark,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              CustomTextField(
                hintText: 'Email address',
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Driver's license no.",
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.w600,
                  color: kDark,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              CustomTextField(
                hintText: 'License Number',
                controller: licenseController,
              ),
              SizedBox(
                height: 10.0,
              ),
              RichText(
                text: TextSpan(
                  text: "Vehicle number plate",
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.w600,
                    color: kDark,
                  ),
                  children: [
                    TextSpan(
                      text: "  (primary vehicle)",
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: kGrey,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              CustomTextField(
                hintText: 'Number plate',
                controller: numberPlateController,
                keyboardType: TextInputType.emailAddress,
                isLast: true,
              ),
              SizedBox(
                height: 20.0,
              ),
              SizedBox(
                width: double.infinity,
                height: 60.0,
                child: TextButton(
                  onPressed: () async {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        );
                      },
                    );
                    await Future.delayed(const Duration(seconds: 2));
                    Navigator.pop(context);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                  ),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              GestureDetector(
                onTap: () async {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    (Route<dynamic> route) => false,
                  );
                },
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal,
                        color: kDark, // Use your default text color
                      ),
                      children: [
                        TextSpan(
                          text: "Login",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
