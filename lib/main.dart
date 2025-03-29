import 'package:driver_review_capstone/providers/data_provider.dart';
import 'package:driver_review_capstone/screens/authentication/login_page.dart';
import 'package:driver_review_capstone/screens/navigation_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (_) => ReviewDataProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: getUserId(),
      builder: (context, snapshot) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Driver Review',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF3870BE),
            ),
            useMaterial3: true,
          ),
          home: snapshot.data == null ? const LoginPage() : const NavigationPage(),
        );
      },
    );
  }
}
