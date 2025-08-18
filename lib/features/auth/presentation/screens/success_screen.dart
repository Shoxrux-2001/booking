import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:restaurant/gen/assets.gen.dart';
import 'package:restaurant/features/auth/presentation/widgets/draggable_auth_sheet.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Assets.svgs.succes,
              height: 200,
              width: 200,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 30),
            const Text(
              'Welcome',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Before Enjoying Foodmedia Services\nPlease Register First',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                showDraggableAuthSheet(context, initialPage: 1);
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(250, 50),
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Create Account',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            const SizedBox(height: 15),
            OutlinedButton(
              onPressed: () {
                showDraggableAuthSheet(context, initialPage: 0);
              },
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(250, 50),
                side: BorderSide(color: Colors.green[100]!),
                backgroundColor: Colors.green[50],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Login',
                style: TextStyle(fontSize: 18, color: Colors.green),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: Text(
                'By Logging In Or Registering, You Have Agreed To The Terms And Conditions And Privacy Policy.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.green),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
