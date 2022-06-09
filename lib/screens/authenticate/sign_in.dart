import 'dart:ui';

import 'package:cipher_gred/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authService = AuthService();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xff36353C),
      appBar: AppBar(
        backgroundColor: const Color(0xff222831),
        title: Text(
          'CIPHERGRED',
          style: GoogleFonts.poppins(
            fontSize: 28,
            letterSpacing: 10,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Stack(
          children: [
            Positioned(
              top: 30,
              left: 25,
              right: 25,
              child: Text(
                'Welcome to CipherGred !\nTo scan your first product please sign in anonymously to continue.You simply need to click on the button to continue',
                style: GoogleFonts.poppins(
                    color: Colors.white, fontSize: size.width * 0.048),
              ),
            ),
            Positioned(
              top: size.height * 0.231,
              left: -10,
              child: Container(
                height: size.height * 0.15,
                width: size.width * 0.35,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Color(0xffFA58B6),
                      Color(0xffE23399),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: size.height * 0.51,
              right: -22,
              child: Container(
                height: size.height * 0.12,
                width: size.width * 0.35,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xffC84B31),
                ),
              ),
            ),
            Positioned(
              top: size.height * 0.54,
              left: 50,
              child: Container(
                height: size.height * 0.1,
                width: size.width * 0.175,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xff7A0BC0),
                ),
              ),
            ),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                  child: Container(
                    height: size.height * 0.3,
                    width: size.width * 0.85,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white.withOpacity(0.08),
                      ),
                      borderRadius: BorderRadius.circular(25),
                      gradient: LinearGradient(
                        colors: [
                          Colors.white.withOpacity(0.2),
                          Colors.white.withOpacity(0.1)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: size.height * 0.5,
              left: size.width * 0.1,
              right: size.width * 0.1,
              child: Center(
                child: Container(
                  height: size.height * 0.065,
                  width: size.width * 0.85,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withOpacity(0.15),
                        Colors.white.withOpacity(0.25),
                      ],
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ElevatedButton.icon(
                      icon: isLoading
                          ? Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: Text(
                                'Loading',
                                style: GoogleFonts.poppins(
                                  fontSize: size.width * 0.04,
                                ),
                              ),
                            )
                          : const Icon(Icons.person),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white.withOpacity(0.3),
                      ),
                      onPressed: () async {
                        if (isLoading) return;
                        setState(() => isLoading = true);
                        await _authService.signInAnonymously();
                      },
                      label: isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 5,
                            )
                          : Text(
                              'Anonymous Sign In',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: size.width * 0.035,
                              ),
                            ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              child: Center(
                child: Text(
                  'Sign in anonymously to continue',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: size.width * 0.045,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
