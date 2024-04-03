import 'package:emetms/utlis/const.dart';
import 'package:emetms/widgets/text_widget.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    getTrees();
    super.initState();
  }

  bool hasLoaded = false;

  List<Marker> markers = [];

  getTrees() {
    for (int i = 0; i < gisokgisok.length; i++) {
      markers.add(
        Marker(
            point: LatLng(gisokgisok[i].latitude, gisokgisok[i].longitude),
            width: 35,
            height: 35,
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return SizedBox(
                      height: 500,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Image.asset(
                                gisokgisok[i].image,
                                height: 225,
                                width: 225,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextWidget(
                              text: 'Name: ${gisokgisok[i].name}',
                              fontSize: 18,
                              fontFamily: 'Bold',
                            ),
                            const Divider(
                              color: Colors.grey,
                            ),
                            TextWidget(
                              text: 'Family: ${gisokgisok[i].family}',
                              fontSize: 14,
                              fontFamily: 'Medium',
                            ),
                            TextWidget(
                              text:
                                  'Scientific Name: ${gisokgisok[i].scientificName}',
                              fontSize: 14,
                              fontFamily: 'Medium',
                            ),
                            TextWidget(
                              text: 'Description: ${gisokgisok[i].description}',
                              fontSize: 14,
                              fontFamily: 'Medium',
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: TextWidget(
                    text: gisokgisok[i].name[0],
                    fontSize: 18,
                    fontFamily: 'Bold',
                    color: Colors.white,
                  ),
                ),
              ),
            )),
      );
    }

    for (int i = 0; i < guijo.length; i++) {
      markers.add(
        Marker(
            point: LatLng(guijo[i].latitude, guijo[i].longitude),
            width: 35,
            height: 35,
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return SizedBox(
                      height: 500,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Image.asset(
                                'assets/images/Guijo/${guijo[i].image}',
                                height: 225,
                                width: 225,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextWidget(
                              text: 'Name: ${guijo[i].name}',
                              fontSize: 18,
                              fontFamily: 'Bold',
                            ),
                            const Divider(
                              color: Colors.grey,
                            ),
                            TextWidget(
                              text: 'Family: ${guijo[i].family}',
                              fontSize: 14,
                              fontFamily: 'Medium',
                            ),
                            TextWidget(
                              text:
                                  'Scientific Name: ${guijo[i].scientificName}',
                              fontSize: 14,
                              fontFamily: 'Medium',
                            ),
                            TextWidget(
                              text: 'Description: ${guijo[i].description}',
                              fontSize: 14,
                              fontFamily: 'Medium',
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: TextWidget(
                    text: guijo[i].name[0],
                    fontSize: 18,
                    fontFamily: 'Bold',
                    color: Colors.white,
                  ),
                ),
              ),
            )),
      );
    }
    for (int i = 0; i < panau.length; i++) {
      markers.add(
        Marker(
            point: LatLng(panau[i].latitude, panau[i].longitude),
            width: 35,
            height: 35,
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return SizedBox(
                      height: 500,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Image.asset(
                                'assets/images/Hasselt_s Panau/${panau[i].image}',
                                height: 225,
                                width: 225,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextWidget(
                              text: 'Name: ${panau[i].name}',
                              fontSize: 18,
                              fontFamily: 'Bold',
                            ),
                            const Divider(
                              color: Colors.grey,
                            ),
                            TextWidget(
                              text: 'Family: ${panau[i].family}',
                              fontSize: 14,
                              fontFamily: 'Medium',
                            ),
                            TextWidget(
                              text:
                                  'Scientific Name: ${panau[i].scientificName}',
                              fontSize: 14,
                              fontFamily: 'Medium',
                            ),
                            TextWidget(
                              text: 'Description: ${panau[i].description}',
                              fontSize: 14,
                              fontFamily: 'Medium',
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.brown,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: TextWidget(
                    text: panau[i].name[0],
                    fontSize: 18,
                    fontFamily: 'Bold',
                    color: Colors.white,
                  ),
                ),
              ),
            )),
      );
    }

    for (int i = 0; i < mayapis.length; i++) {
      markers.add(
        Marker(
            point: LatLng(mayapis[i].latitude, mayapis[i].longitude),
            width: 35,
            height: 35,
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return SizedBox(
                      height: 500,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Image.asset(
                                'assets/images/Mayapis/${mayapis[i].image}',
                                height: 225,
                                width: 225,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextWidget(
                              text: 'Name: ${mayapis[i].name}',
                              fontSize: 18,
                              fontFamily: 'Bold',
                            ),
                            const Divider(
                              color: Colors.grey,
                            ),
                            TextWidget(
                              text: 'Family: ${mayapis[i].family}',
                              fontSize: 14,
                              fontFamily: 'Medium',
                            ),
                            TextWidget(
                              text:
                                  'Scientific Name: ${mayapis[i].scientificName}',
                              fontSize: 14,
                              fontFamily: 'Medium',
                            ),
                            TextWidget(
                              text: 'Description: ${mayapis[i].description}',
                              fontSize: 14,
                              fontFamily: 'Medium',
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.amber,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: TextWidget(
                    text: mayapis[i].name[0],
                    fontSize: 18,
                    fontFamily: 'Bold',
                    color: Colors.white,
                  ),
                ),
              ),
            )),
      );
    }

    for (int i = 0; i < narig.length; i++) {
      markers.add(
        Marker(
            point: LatLng(narig[i].latitude, narig[i].longitude),
            width: 35,
            height: 35,
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return SizedBox(
                      height: 500,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Image.asset(
                                'assets/images/Narig/${narig[i].image}',
                                height: 225,
                                width: 225,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextWidget(
                              text: 'Name: ${narig[i].name}',
                              fontSize: 18,
                              fontFamily: 'Bold',
                            ),
                            const Divider(
                              color: Colors.grey,
                            ),
                            TextWidget(
                              text: 'Family: ${narig[i].family}',
                              fontSize: 14,
                              fontFamily: 'Medium',
                            ),
                            TextWidget(
                              text:
                                  'Scientific Name: ${narig[i].scientificName}',
                              fontSize: 14,
                              fontFamily: 'Medium',
                            ),
                            TextWidget(
                              text: 'Description: ${narig[i].description}',
                              fontSize: 14,
                              fontFamily: 'Medium',
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: TextWidget(
                    text: narig[i].name[0],
                    fontSize: 18,
                    fontFamily: 'Bold',
                    color: Colors.white,
                  ),
                ),
              ),
            )),
      );
    }

    for (int i = 0; i < yakal.length; i++) {
      markers.add(
        Marker(
            point: LatLng(yakal[i].latitude, yakal[i].longitude),
            width: 35,
            height: 35,
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return SizedBox(
                      height: 500,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Image.asset(
                                'assets/images/Yakal Saplungan/${yakal[i].image}',
                                height: 225,
                                width: 225,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextWidget(
                              text: 'Name: ${yakal[i].name}',
                              fontSize: 18,
                              fontFamily: 'Bold',
                            ),
                            const Divider(
                              color: Colors.grey,
                            ),
                            TextWidget(
                              text: 'Family: ${yakal[i].family}',
                              fontSize: 14,
                              fontFamily: 'Medium',
                            ),
                            TextWidget(
                              text:
                                  'Scientific Name: ${yakal[i].scientificName}',
                              fontSize: 14,
                              fontFamily: 'Medium',
                            ),
                            TextWidget(
                              text: 'Description: ${yakal[i].description}',
                              fontSize: 14,
                              fontFamily: 'Medium',
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.purple,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: TextWidget(
                    text: yakal[i].name[0],
                    fontSize: 18,
                    fontFamily: 'Bold',
                    color: Colors.white,
                  ),
                ),
              ),
            )),
      );
    }

    for (int i = 0; i < guisok.length; i++) {
      markers.add(
        Marker(
            point: LatLng(guisok[i].latitude, guisok[i].longitude),
            width: 35,
            height: 35,
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return SizedBox(
                      height: 500,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Image.asset(
                                'assets/images/Quisumbing Guisok/${guisok[i].image}',
                                height: 225,
                                width: 225,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextWidget(
                              text: 'Name: ${guisok[i].name}',
                              fontSize: 18,
                              fontFamily: 'Bold',
                            ),
                            const Divider(
                              color: Colors.grey,
                            ),
                            TextWidget(
                              text: 'Family: ${guisok[i].family}',
                              fontSize: 14,
                              fontFamily: 'Medium',
                            ),
                            TextWidget(
                              text:
                                  'Scientific Name: ${guisok[i].scientificName}',
                              fontSize: 14,
                              fontFamily: 'Medium',
                            ),
                            TextWidget(
                              text: 'Description: ${guisok[i].description}',
                              fontSize: 14,
                              fontFamily: 'Medium',
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.teal,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: TextWidget(
                    text: guisok[i].name[0],
                    fontSize: 18,
                    fontFamily: 'Bold',
                    color: Colors.white,
                  ),
                ),
              ),
            )),
      );
    }

    setState(() {
      hasLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.camera_alt_outlined,
        ),
        onPressed: () {},
      ),
      body: hasLoaded
          ? FlutterMap(
              options: const MapOptions(
                initialCenter: LatLng(9.715106, 124.106846),
                initialZoom: 15,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
                MarkerLayer(
                  markers: markers,
                ),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
