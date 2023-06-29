import 'package:flutter/material.dart';
import 'package:meal_game/screens/camera_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meal_game/screens/game_over.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      routes: {
        '/next': (context) => CameraScreen(),
        '/final': (context) => GameOverScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(66, 492, 65, 92),
        width: double.infinity,
        height: 640,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/next');
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
          ),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xFF3E8B3A),
              borderRadius: BorderRadius.circular(50),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x4C000000),
                  offset: Offset(0, 4),
                  blurRadius: 2,
                ),
              ],
            ),
            child: Center(
              child: Text(
                'Share your meal',
                style: GoogleFonts.andika(
                  textStyle: const TextStyle(
                    fontSize: 25, 
                    fontWeight: FontWeight.w400,
                    color: Colors.white, 
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
