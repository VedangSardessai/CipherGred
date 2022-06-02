import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScannedResult extends StatefulWidget {
  final String text;
  final List<String> scannedText;
  final Text safeOrNot;

  ScannedResult(this.text, this.scannedText, this.safeOrNot);

  @override
  State<ScannedResult> createState() => _ScannedResultState();
}

class _ScannedResultState extends State<ScannedResult> {
  String harmfulIngredientsFound = "";

  List<String> harmfulIngredientsList = [
    'largest',
    'cement',
    'phosphoric',
    'sugar',
    'book',
    'testing',
    'messages'
  ];

  int flagOfHarmfulIngredients = 0;

  String findHarmfulIngredients(List<String> scannedText) {
    for (int i = 0; i < scannedText.length; i++) {
      if ((harmfulIngredientsList.contains(scannedText[i]) ||
              scannedText[i] == ' ') &&
          !harmfulIngredientsFound.contains(scannedText[i])) {
        flagOfHarmfulIngredients = 1;
        harmfulIngredientsFound =
            harmfulIngredientsFound + ' ' + scannedText[i] + '\n';
        print(scannedText[i] + ' is Present');
      }
    }

    if (harmfulIngredientsFound.isNotEmpty) {
      setState(() {
        flagOfHarmfulIngredients = 1;
        print('Not Empty');
      });
    } else {
      setState(() {
        print('Empty');
        flagOfHarmfulIngredients = 0;
      });
    }

    print('-------- ' + flagOfHarmfulIngredients.toString());
    return harmfulIngredientsFound;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xff36353C),
      appBar: AppBar(
        backgroundColor: const Color(0xff222831),
        title: Text(
          'RESULT OF SCAN',
          style: GoogleFonts.poppins(
            letterSpacing: 4,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned(
            top: size.height * .045,
            left: 25,
            right: 25,
            child: Text(
              'Below are the ingredients scanned from picture you took',
              style: GoogleFonts.poppins(
                fontSize: size.width * 0.05,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.12,
            height: size.height * 0.15,
            left: 25,
            right: 25,
            child: Center(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Text(
                        widget.text,
                        style: GoogleFonts.poppins(
                          fontSize: size.width * 0.035,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            top: size.height * 0.3,
            left: size.width * 0.1,
            right: size.width * 0.1,
            child: Center(
              child: Column(
                children: [widget.safeOrNot],
              ),
            ),
          )

          // Positioned(child: child)
        ],
      ),
    );
  }
}
