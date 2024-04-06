import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future addTree(
    img, name, family, scientificName, description, lat, long) async {
  final docUser = FirebaseFirestore.instance.collection('Tree').doc();

  final json = {
    'img': img,
    'name': name,
    'family': family,
    'scientificName': scientificName,
    'description': description,
    'lat': lat,
    'long': long,
    'dateTime': DateTime.now(),
    'docUser': docUser.id
  };

  await docUser.set(json);
}
