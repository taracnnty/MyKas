import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Total extends StatefulWidget {
  const Total({Key? key}) : super(key: key);

  @override
  _TotalState createState() => _TotalState();
}

class _TotalState extends State<Total> {
  double pengeluaran = 0;
  double pemasukan = 0;

  @override
  void initState() {
    super.initState();
    fetchPengeluaran();
    fetchPemasukan();
  }

  Future<void> fetchPengeluaran() async {
    final url = Uri.parse('http://localhost:9000/data1');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final Pengeluaran = data['pengeluaran'] ?? 0;
        setState(() {
          pengeluaran = Pengeluaran.toDouble();
        });
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Terjadi kesalahan: $error');
    }
  }

  Future<void> fetchPemasukan() async {
    final url = Uri.parse('http://localhost:9000/data2');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final Pemasukan = data['pemasukan'] ?? 0;
        setState(() {
          pemasukan = Pemasukan.toDouble();
        });
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Terjadi kesalahan: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total Pengeluaran',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Rp ${pengeluaran.toStringAsFixed(2)}',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total Pemasukan',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Rp ${pemasukan.toStringAsFixed(2)}',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
