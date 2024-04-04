import 'dart:io';

import 'package:emetms/screens/home_screen.dart';
import 'package:emetms/screens/table_screen.dart';
import 'package:emetms/utlis/const.dart';
import 'package:emetms/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_v2/tflite_v2.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  late String output = '';

  late File pickedImage;

  bool isImageLoaded = false;

  late List result;

  late String accuracy = '';

  late String name = '';

  late String numbers = '';

  getImageCamera(String imgsrc) async {
    setState(() {
      hasLoaded = false;
    });
    var tempStore = await ImagePicker().pickImage(
      source: imgsrc == 'camera' ? ImageSource.camera : ImageSource.gallery,
    );

    setState(() {
      pickedImage = File(tempStore!.path);
      isImageLoaded = true;
      applyModel(File(tempStore.path));
      hasLoaded = true;
    });
  }

  List works = [];

  loadmodel() async {
    try {
      await Tflite.loadModel(
        model: "assets/models/model_unquant.tflite",
        labels: "assets/models/labels.txt",
      );
    } catch (e) {
      print('error $e');
    }

    // works = jsonDecode(await rootBundle.loadString('assets/data/main.json'));

    setState(() {
      hasLoaded = true;
    });
  }

  String str = '';

  applyModel(File file) async {
    var res = await Tflite.runModelOnImage(
        path: file.path, // required
        imageMean: 0.0, // defaults to 117.0
        imageStd: 255.0, // defaults to 1.0
        numResults: 2, // defaults to 5
        threshold: 0.2, // defaults to 0.1
        asynch: true);
    setState(() {
      result = res!;

      str = result[0]['label'].toString().split(' ')[1];
    });

    print(str);
    Navigator.pop(context);

    List tree = str == 'Gisok Gisok'
        ? gisokgisok
        : str == 'Guijo'
            ? guijo
            : str == 'Hasselt’s Panau'
                ? panau
                : str == 'Mayapis'
                    ? mayapis
                    : str == 'Narig'
                        ? narig
                        : str == 'Yakal Saplungan'
                            ? yakal
                            : guisok;

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 510,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    str == 'Gisok Gisok'
                        ? 'assets/images/Gisok-Gisok/${tree.first.image}'
                        : str == 'Guijo'
                            ? 'assets/images/Guijo/${tree.first.image}'
                            : str == 'Hasselt’s Panau'
                                ? 'assets/images/Hasselt_s Panau/${tree.first.image}'
                                : str == 'Mayapis'
                                    ? 'assets/images/Mayapis/${tree.first.image}'
                                    : str == 'Narig'
                                        ? 'assets/images/Narig/${tree.first.image}'
                                        : str == 'Yakal Saplungan'
                                            ? 'assets/images/Yakal Saplungan/${tree.first.image}'
                                            : 'assets/images/Gisok-Gisok/${tree.first.image}',
                    height: 210,
                    width: 225,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextWidget(
                  text: 'Name: ${tree.first.name}',
                  fontSize: 18,
                  fontFamily: 'Bold',
                ),
                const Divider(
                  color: Colors.grey,
                ),
                TextWidget(
                  text: 'Family: ${tree.first.family}',
                  fontSize: 14,
                  fontFamily: 'Medium',
                ),
                TextWidget(
                  text: 'Scientific Name: ${tree.first.scientificName}',
                  fontSize: 14,
                  fontFamily: 'Medium',
                ),
                TextWidget(
                  text: 'Description: ${tree.first.description}',
                  fontSize: 14,
                  fontFamily: 'Medium',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  bool hasLoaded = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadmodel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const HomeScreen()));
              },
              child: Container(
                height: 250,
                width: 275,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.map,
                      color: Colors.white,
                      size: 150,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextWidget(
                      text: 'Map',
                      fontSize: 32,
                      fontFamily: 'Bold',
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const TableScreen()));
                  },
                  child: Container(
                    height: 125,
                    width: 125,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.table_chart_outlined,
                          color: Colors.white,
                          size: 75,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextWidget(
                          text: 'Data',
                          fontSize: 24,
                          fontFamily: 'Bold',
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return SizedBox(
                          height: 150,
                          child: Column(
                            children: [
                              ListTile(
                                onTap: () {
                                  getImageCamera('camera');
                                },
                                leading: const Icon(
                                  Icons.camera,
                                ),
                                title: TextWidget(
                                  text: 'Camera',
                                  fontSize: 18,
                                  fontFamily: 'Bold',
                                ),
                              ),
                              const Divider(),
                              ListTile(
                                onTap: () {
                                  getImageCamera('gallery');
                                },
                                leading: const Icon(
                                  Icons.image,
                                ),
                                title: TextWidget(
                                  text: 'Gallery',
                                  fontSize: 18,
                                  fontFamily: 'Bold',
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    height: 125,
                    width: 125,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.white,
                          size: 75,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextWidget(
                          text: 'Scan',
                          fontSize: 24,
                          fontFamily: 'Bold',
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
