import 'package:flutter/material.dart';
import 'package:latihan/fitur/tambah.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PengeluaranPage extends StatelessWidget {
  final TextEditingController _nama_transaksiController = TextEditingController();
  final TextEditingController _pengeluaranController = TextEditingController();

  Future<void> tambahTransaksi(String namaTransaksi, double pengeluaran) async {
    final url = Uri.parse('http://localhost:9000/data3');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'nama_transaksi': namaTransaksi,
          'pengeluaran': pengeluaran.toString(),
        }),
      );

      if (response.statusCode == 200) {
        // Data berhasil ditambahkan ke database
        print('Data berhasil ditambahkan');
      } else {
        // Gagal menambahkan data ke database
        print(response.body);
      }
    } catch (error) {
      // Terjadi kesalahan saat melakukan request
      print('Terjadi kesalahan: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Transaksi'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                onPressed: () {
                },style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).colorScheme.background,
                    onPrimary: Theme.of(context).colorScheme.surface,
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.surface,
                      width: 1.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text('Pengeluaran'),
                ),
                ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/tambah');
                },style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).colorScheme.onSecondary,
                    onPrimary: Theme.of(context).colorScheme.outline,
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.outline,
                      width: 1.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text('Pemasukan'),
                ),
              ],
            ),
            SizedBox(height: 20),
            TextField(
            controller: _nama_transaksiController,
            decoration: InputDecoration(
              labelText: 'Nama Transaksi',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _pengeluaranController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Jumlah',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: const Text(
                'Tambah Transaksi',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                String namaTransaksi = _nama_transaksiController.text;
                double pengeluaran = double.parse(_pengeluaranController.text);

                tambahTransaksi(namaTransaksi, pengeluaran);

                // Reset form input
                _nama_transaksiController.clear();
                _pengeluaranController.clear();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      initialRoute: '/pengeluaran',
      routes: {
        '/tambah': (context) => TambahTransaksiPage(),
        '/pengeluaran': (context) => PengeluaranPage(),
      },
    );
  }
}

void main() {
  runApp(MyApp());
}
