import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:whatsapp_ui/common/widgets/custom_button.dart';
import 'package:whatsapp_ui/features/auth/screens/login_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Text(
              'Welcome to myChat !',
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 33,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 60),
            Lottie.network(
                'https://assets2.lottiefiles.com/private_files/lf30_TBKozE.json',
                height: 350),
            const SizedBox(height: 10),
            Center(
              child: Text(
                'Read our Privacy Policy.Tap "Agree and Continue" to accept the Terms of Service.',
                style: GoogleFonts.poppins(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.75,
              child: CustomButton(
                text: 'AGREE AND CONTINUE',
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.routeName);
                },
                color: Colors.purpleAccent[200],
              ),
            )
          ],
        ),
      ),
    );
  }
}
