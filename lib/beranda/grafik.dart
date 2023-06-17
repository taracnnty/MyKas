import 'package:flutter/material.dart';
import 'package:latihan/beranda/total.dart';

class grafik extends StatelessWidget {

  const grafik({
    Key? key, required double pengeluaran,
  }) : super(key: key);

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
                // Tambahkan kode untuk menampilkan grafik di sini
                child: Center(
                  child: Text('Grafik Transaksi'),
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
