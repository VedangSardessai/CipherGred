import 'dart:io';

import 'package:cipher_gred/screens/scan_results/result.dart';
import 'package:cipher_gred/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _authService = AuthService();
  File? image;
  bool textScanning = false;

  String scannedText = "";

  List<String> scannedTextArr = [''];
  List<String> harmfulIngred = [
    'msg',
    'phosphoric acid',
    'monosodium glutamate',
    'aspartame',
    'hfcs',
    'tbhq',
    'bha',
    'bht',
    'sodium nitrate',
    'sodium nitrite',
    'vegetable oil',
    'potassium bromate',
    'bovine growth hormone',
    'agave nectar',
    'artificial food coloring',
    'artificial food coloring',
    'synthetic trans fat',
    'synthetic trans fats',
    'corn syrup',
    'brominated vegetable oil',
    'high fructose corn syrup',
    'phosphoric',
    'formaldehyde',
    'nitrites',
    'methylene',
    'ditrityl',
    'diethylexyl',
    'isobutyl',
    'isopropyl',
    'parabens',
    'polyfluoroalkyl',
    'pfas',
    'phenylendiamine',
  ];

  List<String>? constructorArr;
  int flagOfIngredientsFound = 0;
  String harmfulIngredientsFound = "";

  Future uploadImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);

      if (image == null) {
        textScanning = false;
        return;
      }

      final imageTemporary = File(image.path);
      setState(() {
        textScanning = true;
        this.image = imageTemporary;
        setState(() {
          flagOfIngredientsFound = 0;
          recogniseText(this.image!);
        });
      });
    } on PlatformException catch (e) {
      textScanning = false;
      return e.stacktrace;
    }
  }

  Text harmful = Text(
    'Your Product is unsafe to use!',
    style: GoogleFonts.poppins(color: Colors.white, fontSize: 20),
  );
  Text safe = Text(
    'Your Product is safe to use!',
    style: GoogleFonts.poppins(color: Colors.white, fontSize: 20),
  );

  void recogniseText(File image) async {
    setState(() {
      flagOfIngredientsFound = 0;
      harmfulIngredientsFound = "";
    });
    final inputImage = InputImage.fromFilePath(image.path);
    final textDetector = GoogleMlKit.vision.textRecognizer();

    RecognizedText recognizedText = await textDetector.processImage(inputImage);
    await textDetector.close();
    scannedText = "";
    scannedTextArr = [''];

    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        // for (TextElement elements in line.elements) {
        //   scannedText = scannedText + elements.text + ' ';
        //   scannedTextArr.add(
        //     elements.text.toLowerCase().replaceAll(RegExp(r'[^\w\s]+'), ' '),
        //     // elements.text,
        //   );
        // }

        scannedText += line.text.replaceAll(RegExp(r'[^\w\s]+'), ' ') + ' ';
        scannedTextArr
            .add(line.text.toLowerCase().replaceAll(RegExp(r'[^\w\s]+'), ' '));
      }
    }

    // print(scannedTextArr);
    print(scannedText);
    // for (int i = 0; i < scannedTextArr.length; i++) {
    //   if (harmfulIngred.contains(scannedTextArr[i])) {
    //     setState(() {
    //       flagOfIngredientsFound = 1;
    //     });
    //
    //     harmfulIngredientsFound =
    //         harmfulIngredientsFound + scannedTextArr[i] + " ";
    //
    //   }
    // }

    for(int i = 0 ; i < harmfulIngred.length ; i++){
      if(scannedText.contains(harmfulIngred[i])){
        setState(() {
                flagOfIngredientsFound = 1;
              });

              harmfulIngredientsFound =
                  harmfulIngredientsFound + harmfulIngred[i] + ",";
      }
    }

    print(harmfulIngredientsFound);

    textScanning = false;
    setState(() {
      harmfulIngredientsFound = harmfulIngredientsFound.toUpperCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xff36353C),
      appBar: AppBar(
        title: Text(
          'Home Page',
          style: GoogleFonts.poppins(
            fontSize: size.width * 0.05,
            letterSpacing: size.width * 0.002,
          ),
        ),
        backgroundColor: const Color(0xff222831),
        actions: [
          TextButton.icon(
            onPressed: () async {
              _authService.signOut();
            },
            icon: const Icon(Icons.person),
            label: Text(
              'Log Out',
              style: GoogleFonts.poppins(
                  fontSize: size.width * 0.042,
                  letterSpacing: size.width * 0.002),
            ),
            style: TextButton.styleFrom(
              primary: Colors.white,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            top: 30,
            height: 500,
            // width: 300,
            left: 50,
            right: 50,
            child: Center(
              child: image != null
                  ? Column(
                      children: [
                        // ElevatedButton(
                        //   onPressed: () => image = null,
                        //   child: Text('Remove Image'),
                        // ),
                        Container(
                          decoration: const BoxDecoration(
                              // border: Border.all(
                              //   color: Colors.white,
                              // ),
                              ),
                          child: Image.file(
                            image!,
                            height: 300,
                            width: size.width * 0.95,
                          ),
                        ),
                        const Spacer(),
                        // Expanded(
                        //   child: SingleChildScrollView(
                        //     scrollDirection: Axis.vertical,
                        //     child: Text(
                        //       scannedText,
                        //       style: GoogleFonts.poppins(
                        //         fontSize: size.width * 0.035,
                        //         color: Colors.white,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // Spacer(),
                        Container(
                          height: size.height * 0.16,
                          width: size.height * 0.16,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0xff25252a),
                                offset: Offset(4.0, 4.0),
                                blurRadius: 5,
                                spreadRadius: 0.0,
                              ),
                              BoxShadow(
                                color: Color(0xff25252a),
                                offset: Offset(-4.0, -4.0),
                                blurRadius: 5,
                                spreadRadius: 0.0,
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: ElevatedButton.icon(
                              icon: const FaIcon(
                                FontAwesomeIcons.check,
                                size: 40,
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: const Color(0xff25252a),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return flagOfIngredientsFound == 1
                                        ? ScannedResult(
                                            scannedText,
                                            scannedTextArr,
                                            harmful,
                                            harmfulIngredientsFound)
                                        : ScannedResult(scannedText,
                                            scannedTextArr, safe, '');
                                  }),
                                );
                              },
                              label: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  'Get Result',
                                  style: GoogleFonts.poppins(
                                    fontSize: size.width * 0.04,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(
                      height: 500,
                      width: 500,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                      child: const Image(
                        image: AssetImage('assets/noimgselected.png'),
                      ),
                    ),
            ),
          ),
          Positioned(
            left: size.width * 0.1,
            top: size.height * 0.70,
            height: size.height * 0.16,
            width: size.height * 0.16,
            child: Center(
              child: Container(
                height: 210,
                width: 210,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xff25252a),
                      offset: Offset(4.0, 4.0),
                      blurRadius: 5,
                      spreadRadius: 0.0,
                    ),
                    BoxShadow(
                      color: Color(0xff25252a),
                      offset: Offset(-4.0, -4.0),
                      blurRadius: 5,
                      spreadRadius: 0.0,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ElevatedButton.icon(
                    icon: const FaIcon(
                      FontAwesomeIcons.camera,
                      size: 40,
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xff25252a),
                    ),
                    onPressed: () => uploadImage(ImageSource.camera),
                    label: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        'Capture Image',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: size.width * 0.033,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: size.width * 0.1,
            top: size.height * 0.7,
            height: size.height * 0.16,
            width: size.height * 0.16,
            child: Center(
              child: Container(
                height: 210,
                width: 210,
                decoration: BoxDecoration(
                  color: const Color(0xff36353C),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xff25252a),
                      offset: Offset(5.0, 5.0),
                      blurRadius: 5,
                      spreadRadius: 0.0,
                    ),
                    BoxShadow(
                      color: Color(0xff25252a),
                      offset: Offset(-5.0, -5.0),
                      blurRadius: 5,
                      spreadRadius: 0.0,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: ElevatedButton.icon(
                    icon: const FaIcon(
                      FontAwesomeIcons.upload,
                      size: 40,
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xff25252a),
                    ),
                    onPressed: () => uploadImage(ImageSource.gallery),
                    label: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Upload Image',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: size.width * 0.033,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
