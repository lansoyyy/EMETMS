import 'dart:io';

import 'package:emetms/screens/home_screen.dart';
import 'package:emetms/screens/table_screen.dart';
import 'package:emetms/services/add_tree.dart';
import 'package:emetms/utlis/const.dart';
import 'package:emetms/widgets/button_widget.dart';
import 'package:emetms/widgets/text_widget.dart';
import 'package:emetms/widgets/toast_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_v2/tflite_v2.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  bool hasloaded = false;
  double lat = 0;
  double long = 0;

  @override
  void initState() {
    // TODO: implement initState
    determinePosition();

    Geolocator.getCurrentPosition().then((position) {
      setState(() {
        lat = position.latitude;
        long = position.longitude;
      });
    }).catchError((error) {
      print('Error getting location: $error');
    });

    loadmodel();
    setState(() {
      hasloaded = true;
    });
    super.initState();
  }

  late String output = '';

  late File pickedImage;

  bool isImageLoaded = false;

  late List result;

  late String accuracy = '';

  late String name = '';

  late String numbers = '';

  late String fileName = '';

  String selectedGender = '';
  late String imageURL = '';

  getImageCamera(String imgsrc) async {
    var tempStore = await ImagePicker().pickImage(
      source: imgsrc == 'camera' ? ImageSource.camera : ImageSource.gallery,
    );

    showToast('Loading...');

    fileName = path.basename(tempStore!.path);

    await firebase_storage.FirebaseStorage.instance
        .ref('Tree/${File(tempStore.path).path}')
        .putFile(File(tempStore.path));
    imageURL = await firebase_storage.FirebaseStorage.instance
        .ref('Tree/${File(tempStore.path).path}')
        .getDownloadURL();

    setState(() {
      pickedImage = File(tempStore.path);
      isImageLoaded = true;
      applyModel(File(tempStore.path));
      hasloaded = true;
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

    if (result[0]['confidence'] > 0.75) {
      showModalBottomSheet(
        enableDrag: true,
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: SizedBox(
              height: 500,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Image.file(
                        file,
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
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ButtonWidget(
                          fontSize: 14,
                          height: 40,
                          width: 150,
                          color: Colors.blue,
                          label: 'Save to map',
                          onPressed: () {
                            addTree(
                                imageURL,
                                tree.first.name,
                                tree.first.family,
                                tree.first.scientificName,
                                tree.first.description,
                                lat,
                                long);
                            Navigator.pop(context);
                            showToast('Tree added to map!');
                          },
                        ),
                        ButtonWidget(
                          fontSize: 14,
                          height: 40,
                          width: 150,
                          color: Colors.red,
                          label: 'Close',
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } else {
      showToast('Cannot recognize image!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: hasloaded
          ? Center(
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
                          getImageCamera('camera');
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
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
