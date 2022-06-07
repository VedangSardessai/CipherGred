import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScannedResult extends StatefulWidget {
  final String text;
  final List<String> scannedText;
  final Text safeOrNot;

  final String harmfulIngredientsScanned;
  final List<String> harmfulIngredientList;

  ScannedResult(this.text, this.scannedText, this.safeOrNot,
      this.harmfulIngredientsScanned, this.harmfulIngredientList,
      {Key? key})
      : super(key: key);

  @override
  State<ScannedResult> createState() => _ScannedResultState();
}

class _ScannedResultState extends State<ScannedResult> {
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
              'The text scanned from the image provided by you is shown below :',
              style: GoogleFonts.poppins(
                fontSize: size.width * 0.04,
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
            left: 25,
            right: 25,
            child: Center(
              child: Column(
                children: [
                  widget.safeOrNot,
                  widget.safeOrNot !=
                          Text(
                            'Your Product is safe to use!',
                            style: GoogleFonts.poppins(
                                color: Colors.white, fontSize: 20),
                          )
                      ? Card(
                          color: Colors.grey[900],
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            height: 400,
                            child: ListView(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              children: widget.harmfulIngredientList
                                  .map((ingredients) {
                                return SizedBox(
                                  height: 45,
                                  width: size.width,
                                  child: Card(
                                    margin: const EdgeInsets.all(5),
                                    color: Colors.grey[850],
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 4.0),
                                      child: Text(
                                        ingredients.toUpperCase(),
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        )
                      : const Text(''),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
