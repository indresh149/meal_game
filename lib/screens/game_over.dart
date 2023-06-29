import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GameOverScreen extends StatelessWidget {
  const GameOverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double fem =
        MediaQuery.of(context).size.height / 640; // Calculate the height factor
    double ffem =
        MediaQuery.of(context).size.width / 360; // Calculate the width factor

    return Container(
      width: double.infinity,
      height: 640 * fem,
      decoration: const BoxDecoration(
        color: Color(0xffffffff),
      ),
      child: Center(
        child: Text(
          'GOOD JOB',
          textAlign: TextAlign.center,
          style: GoogleFonts.andika(
            fontSize: 60 * ffem,
            fontWeight: FontWeight.w400,
            height: 1.1425 * ffem / fem,
            letterSpacing: 4.8 * fem,
            color: const Color(0xff3e8b3a),
          ),
        ),
      ),
    );
  }
}
