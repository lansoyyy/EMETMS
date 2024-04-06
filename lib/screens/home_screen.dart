import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emetms/widgets/button_widget.dart';
import 'package:emetms/widgets/text_widget.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  double lat;
  double long;

  HomeScreen({
    super.key,
    required this.lat,
    required this.long,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          centerTitle: true,
          title: TextWidget(
            text: 'Map',
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('Tree').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                print('error');
                return const Center(child: Text('Error'));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Center(
                      child: CircularProgressIndicator(
                    color: Colors.black,
                  )),
                );
              }

              final data = snapshot.requireData;
              return GoogleMap(
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                markers: {
                  for (int i = 0; i < data.docs.length; i++)
                    Marker(
                        infoWindow: InfoWindow(
                            onTap: () {
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Center(
                                              child: Image.network(
                                                data.docs[i]['img'],
                                                height: 210,
                                                width: 225,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            TextWidget(
                                              text:
                                                  'Name: ${data.docs[i]['name']}',
                                              fontSize: 18,
                                              fontFamily: 'Bold',
                                            ),
                                            const Divider(
                                              color: Colors.grey,
                                            ),
                                            TextWidget(
                                              text:
                                                  'Family: ${data.docs[i]['family']}',
                                              fontSize: 14,
                                              fontFamily: 'Medium',
                                            ),
                                            TextWidget(
                                              text:
                                                  'Scientific Name: ${data.docs[i]['scientificName']}',
                                              fontSize: 14,
                                              fontFamily: 'Medium',
                                            ),
                                            TextWidget(
                                              text:
                                                  'Description: ${data.docs[i]['description']}',
                                              fontSize: 14,
                                              fontFamily: 'Medium',
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Center(
                                              child: ButtonWidget(
                                                fontSize: 14,
                                                height: 40,
                                                width: 150,
                                                color: Colors.red,
                                                label: 'Close',
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            title: data.docs[i]['name'],
                            snippet: data.docs[i]['scientificName']),
                        markerId: MarkerId(data.docs[i].id),
                        position:
                            LatLng(data.docs[i]['lat'], data.docs[i]['long'])),
                },
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: LatLng(widget.lat, widget.long),
                  zoom: 16.4746,
                ),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              );
            }));
  }
}
