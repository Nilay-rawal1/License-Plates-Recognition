import 'package:driver_review_capstone/const/constants.dart';
import 'package:driver_review_capstone/custom_widgets/custom_text_field.dart';
import 'package:driver_review_capstone/screens/authentication/signup_page.dart';
import 'package:driver_review_capstone/screens/navigation_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with WidgetsBindingObserver {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController emailController = TextEditingController(); //admin@email.com
  final TextEditingController passwordController = TextEditingController(); //admin
  bool _emailValidate = false;
  bool _passwordValidate = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    if (MediaQuery.of(context).viewInsets.bottom > 0) {
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 1500),
        curve: Curves.fastOutSlowIn,
      );
    });
  }

  Future<void> saveUserId(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          'Login',
          style: TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.bold,
            color: kDark,
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0, left: 20.0, right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 2.9,
                  child: Hero(
                    tag: 'appLogo',
                    child: Image.asset('assets/driver_review_logo.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              const Text(
                'Email',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: kDark,
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              CustomTextField(
                hintText: 'Email address',
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                autoFocus: true,
                validate: _emailValidate,
              ),
              const SizedBox(
                height: 12.0,
              ),
              const Text(
                'Password',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: kDark,
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              CustomTextField(
                hintText: 'Password',
                controller: passwordController,
                isObscure: true,
                isLast: true,
                validate: _passwordValidate,
              ),
              Row(
                children: [
                  const Spacer(),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text(
                      'Forgot password?',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              SizedBox(
                width: double.infinity,
                height: 60.0,
                child: TextButton(
                  onPressed: () async {
                    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
                      if ((emailController.text == "udit@email.com" &&
                              passwordController.text == "udit") ||
                          (emailController.text == 'nilay@email.com' &&
                              passwordController.text == 'nilay')) {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            );
                          },
                        );
                        if (passwordController.text == 'udit') {
                          await saveUserId('USR001');
                        } else {
                          await saveUserId('USR002');
                        }
                        await Future.delayed(const Duration(seconds: 2));
                        if (!context.mounted) return;
                        Navigator.pop(context);
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NavigationPage(),
                          ),
                          (Route<dynamic> route) => false,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text(
                              'Invalid email or password',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            backgroundColor: Colors.red[500],
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      }
                    } else {
                      setState(() {
                        _emailValidate = emailController.text.isEmpty;
                        _passwordValidate = passwordController.text.isEmpty;
                      });
                    }
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              GestureDetector(
                onTap: () async {
                  FocusScope.of(context).unfocus();
                  await Future.delayed(const Duration(milliseconds: 400));
                  if (!context.mounted) return;
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const SignupPage()),
                    (Route<dynamic> route) => false,
                  );
                },
                child: Center(
                  child: RichText(
                    text: const TextSpan(
                      text: "Don't have an account? ",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal,
                        color: kDark, // Use your default text color
                      ),
                      children: [
                        TextSpan(
                          text: "Sign up",
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
