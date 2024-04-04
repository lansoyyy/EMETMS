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
              TextWidget(
                text:
                    '${speciesList[i] == 'Gisok Gisok' ? 10 : speciesList[i] == 'Guijo' ? 10 : speciesList[i] == 'Hasselt’s Panau' ? 3 : speciesList[i] == 'Mayapis' ? 10 : speciesList[i] == 'Narig' ? 10 : speciesList[i] == 'Yakal Saplungan' ? 8 : 10}',
                fontSize: 12,
              ),
            ),
            DataCell(
              TextWidget(
                text:
                    '${((((speciesList[i] == 'Gisok Gisok' ? 10 : speciesList[i] == 'Guijo' ? 10 : speciesList[i] == 'Hasselt’s Panau' ? 3 : speciesList[i] == 'Mayapis' ? 10 : speciesList[i] == 'Narig' ? 10 : speciesList[i] == 'Yakal Saplungan' ? 8 : 10)) / 30) * 100).toStringAsFixed(2)}%',
                fontSize: 12,
              ),
            ),
          ])
      ]),
    );
  }
}
