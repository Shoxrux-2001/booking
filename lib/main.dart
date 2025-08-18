import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/features/home/repo/food_rpo.dart';
import 'package:restaurant/features/home/viewmodel/food_viewmodel.dart';
import 'package:restaurant/features/presentation/routes/app_router.dart';
import 'package:restaurant/firebase_options.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(body: Center(child: CircularProgressIndicator())),
          );
        }
        if (snapshot.hasError) {
          log("Firebase initialization error: ${snapshot.error}");
          return const MaterialApp(
            home: Scaffold(body: Center(child: Text('Error initializing app'))),
          );
        }
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => FoodViewModel(FoodRepository()),
            ),
          ],
          child: MaterialApp.router(
            title: 'Restaurant Booking',
            theme: ThemeData(primarySwatch: Colors.green),
            routerConfig: appRouter,
            debugShowCheckedModeBanner: false,
          ),
        );
      },
    );
  }

  Future<void> _initializeApp() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      log("Firebase initialized successfully");
    } catch (e) {
      log("Error initializing Firebase: $e");
      throw Exception("Failed to initialize Firebase: $e");
    }
  }
}
