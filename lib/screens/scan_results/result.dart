import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScannedResult extends StatefulWidget {
  final String text;
  final List<String> scannedText;
  final Text safeOrNot;

  final String harmfulIngredientsScanned;
  final List<String> harmfulIngredientList;

  const ScannedResult(this.text, this.scannedText, this.safeOrNot,
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
            left: size.width * 0.1,
            right: size.width * 0.1,
            child: Center(
              child: Column(
                children: [
                  widget.safeOrNot,
                  Text(
                    widget.harmfulIngredientsScanned,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),

                  //This is how we'll do the rest of the listview
                  Column(
                    children: widget.harmfulIngredientList.map((ingredients){
                      return Text(ingredients);
                    }).toList(),
                  )
                ],
              ),
            ),
          )

          // Positioned(child: child)
        ],
      ),
    );
  }
}
