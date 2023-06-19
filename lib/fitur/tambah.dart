import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:latihan/fitur/pengeluaran.dart';
import 'package:latihan/fitur/profile.dart';

class Transaksi {
  final String namaTransaksi;
  final double pemasukan;

  Transaksi(this.namaTransaksi, this.pemasukan);
}

class TambahTransaksiPage extends StatefulWidget {
  const TambahTransaksiPage({Key? key}) : super(key: key);

  @override
  _TambahTransaksiPageState createState() => _TambahTransaksiPageState();
}

class _TambahTransaksiPageState extends State<TambahTransaksiPage> {
  int _selectedIndex = 1;
  double saldo = 0;
  List<Transaksi> riwayatTransaksi = [];
  final TextEditingController _namaTransaksiController = TextEditingController();
  final TextEditingController _pemasukanController = TextEditingController();

  void tambahTransaksi(String namaTransaksi, double pemasukan) async {
  Transaksi transaksi = Transaksi(namaTransaksi, pemasukan);
  setState(() {
    saldo += pemasukan;
    riwayatTransaksi.add(transaksi);
  });

  final url = Uri.parse('http://localhost:9000/data4');
  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nama_transaksi': namaTransaksi,
        'pemasukan': pemasukan.toString(),
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
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth <= 600;

    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Transaksi'),
        titleTextStyle: TextStyle(
          color: Theme.of(context).colorScheme.onSecondary,
          fontSize: 22,
        ),
        automaticallyImplyLeading: !isSmallScreen,
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
                    Navigator.pushReplacementNamed(context, '/pengeluaran');
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).colorScheme.onSecondary,
                    onPrimary: Theme.of(context).colorScheme.outline,
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.onSecondary,
                      width: 1.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text('Pengeluaran'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
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
                  child: const Text('Pemasukan'),
                ),
              ],
            ),
            Text(
              'Total: $saldo',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _namaTransaksiController,
              decoration: InputDecoration(
                labelText: 'Nama Transaksi',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _pemasukanController,
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
                String namaTransaksi = _namaTransaksiController.text;
                double pemasukan = double.parse(_pemasukanController.text);

                tambahTransaksi(namaTransaksi, pemasukan);

                // Reset form input
                _namaTransaksiController.clear();
                _pemasukanController.clear();
              },
            ),
            SizedBox(height: 20),
            Text(
              'Riwayat Transaksi',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: riwayatTransaksi.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      riwayatTransaksi[index].namaTransaksi,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Jumlah: ${riwayatTransaksi[index].pemasukan}',
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: isSmallScreen
          ? BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Beranda',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.receipt),
                  label: 'Tambah Transaksi',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profil',
                ),
              ],
              currentIndex: _selectedIndex,
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
                if (index == 0) {
                  Navigator.pushNamed(context, '/beranda').then((value) {
                    setState(() {
                      _selectedIndex = 0;
                    });
                  });
                } else if (index == 2) {
                  Navigator.pushNamed(context, '/profile').then((value) {
                    setState(() {
                      _selectedIndex = 0;
                    });
                  });
                }
              },
              selectedItemColor: Colors.blue,
            )
          : null,
      drawer: !isSmallScreen
          ? Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text('Beranda'),
                    onTap: () {
                      Navigator.pushNamed(context, '/beranda');
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.receipt),
                    title: Text('Tambah Transaksi'),
                    onTap: () {
                      Navigator.pushNamed(context, '/tambah');
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Profil'),
                    onTap: () {
                      Navigator.pushNamed(context, '/profile');
                    },
                  ),
                ],
              ),
            )
          : null,
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      initialRoute: '/tambah',
      routes: {
        '/pengeluaran': (context) => PengeluaranPage(),
        '/tambah': (context) => TambahTransaksiPage(),
        '/profile': (context) => ProfilePage(),
      },
    );
  }
}

void main() {
  runApp(MyApp());
}
