import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emetms/utlis/const.dart';
import 'package:emetms/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class TableScreen extends StatefulWidget {
  const TableScreen({super.key});

  @override
  State<TableScreen> createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  List<String> speciesList = [
    'Gisok Gisok',
    'Guijo',
    'Hasselt’s Panau',
    'Mayapis',
    'Narig',
    'Yakal Saplungan',
    'Quisumbing Guisok'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: TextWidget(
          text: 'Data',
          fontSize: 18,
          color: Colors.white,
        ),
      ),
      body: DataTable(columns: [
        DataColumn(
          label: TextWidget(
            align: TextAlign.start,
            maxLines: 2,
            text: 'Endangered\nTree',
            fontFamily: 'Bold',
            fontSize: 14,
          ),
        ),
        DataColumn(
          label: TextWidget(
            align: TextAlign.start,
            maxLines: 2,
            text: 'No. of\nTrees',
            fontFamily: 'Bold',
            fontSize: 14,
          ),
        ),
        DataColumn(
          label: TextWidget(
            text: 'Percentage',
            fontSize: 14,
            fontFamily: 'Bold',
          ),
        ),
      ], rows: [
        for (int i = 0; i < speciesList.length; i++)
          DataRow(cells: [
            DataCell(
              TextWidget(
                text: speciesList[i],
                fontSize: 12,
              ),
            ),
            DataCell(
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Tree')
                      .where('name', isEqualTo: speciesList[i])
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      print(snapshot.error);
                      return const Center(child: Text('Error'));
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.black,
                          ),
                        ),
                      );
                    }

                    final data = snapshot.requireData;
                    return TextWidget(
                      text: '${data.docs.length}',
                      fontSize: 12,
                    );
                  }),
            ),
            DataCell(
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Tree')
                      .where('name', isEqualTo: speciesList[i])
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      print(snapshot.error);
                      return const Center(child: Text('Error'));
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.black,
                          ),
                        ),
                      );
                    }

                    final data = snapshot.requireData;
                    return TextWidget(
                      text:
                          '${((((data.docs.length)) / 30) * 100).toStringAsFixed(2)}%',
                      fontSize: 12,
                    );
                  }),
            ),
          ])
      ]),
    );
  }
}
