import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:latihan/beranda/total.dart';

class grafik extends StatefulWidget {
  const grafik({
    Key? key,
     required int pengeluaran,
  }) : super(key: key);

  @override
  _grafikState createState() => _grafikState();
}

class _grafikState extends State<grafik> {
  List<charts.Series<dynamic, String>> _seriesList = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:9000/data1'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        setState(() {
          _seriesList = _createCategoryData(jsonData);
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  List<charts.Series<dynamic, String>> _createCategoryData(List<dynamic> data) {
  return [
    charts.Series<dynamic, String>(
      id: 'pengeluaran',
      domainFn: (dynamic d, _) => d['nama_transaksi'],
      measureFn: (dynamic d, _) => int.tryParse(d['pengeluaran'].toString()) ?? 0,
      data: data,
    )
  ];
}


  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Grafik Transaksi',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.outline,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: charts.BarChart(
                  _seriesList,
                  animate: true,
                  animationDuration: Duration(milliseconds: 500),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        SizedBox(
          height: 120,
          child: Total(),
        ),
      ],
    );
  }
}