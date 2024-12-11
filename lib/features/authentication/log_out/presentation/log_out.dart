import 'package:flutter/material.dart';
import '../../../../core/app_colors.dart';
import '../domain/usecases/log_out_usecase.dart';


class OpeningPage extends StatelessWidget {
  const OpeningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity, // Ensures the container takes full width
        height: double.infinity, // Ensures the container takes full height
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.navyBlue,
              AppColors.brightBlue
            ], // Use defined colors
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hedieaty',
              style: TextStyle(
                fontFamily: "Pacifico",
                fontSize: 60,
                color: AppColors.gold, // Use the defined gold color
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'The perfect gift for any occasion',
              style: TextStyle(
                fontFamily: "Pacifico",
                fontSize: 20,
                color: AppColors.gold, // Use defined accent color
              ),
            ),
            SizedBox(height: 30),
            Image.asset('assets/R.png', height: 200, width: 200),
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                minimumSize: Size(200, 50),
              ),
              onPressed: () {
                performLogout();
                Navigator.pushNamed(context, '/');
              },
              child: Text(
                'Log Out?',
                style: TextStyle(
                  fontFamily: "Pacifico",
                  fontSize: 25,
                  color: AppColors.navyBlue,
                ),
              ),
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: AppColors.gold,
        padding: EdgeInsets.symmetric(vertical: 10),
        child: GestureDetector(
          onTap: () {
            // Navigate to the pledged gifts page
            Navigator.pushNamed(context, '/screen_wrapper');
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Return back to your account',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: AppColors.navyBlue,
                  fontFamily: "Pacifico",
                ),
              ),
              Icon(
                Icons.question_mark_sharp,
                color: AppColors.navyBlue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
