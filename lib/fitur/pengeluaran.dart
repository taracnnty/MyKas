import 'package:flutter/material.dart';
import 'package:latihan/fitur/profile.dart';
import 'package:latihan/fitur/tambah.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Transaksi {
  final String namaTransaksi;
  final double pengeluaran;

  Transaksi(this.namaTransaksi, this.pengeluaran);
}

class PengeluaranPage extends StatefulWidget {
  const PengeluaranPage({Key? key}) : super(key: key);

  @override
  _PengeluaranPageState createState() => _PengeluaranPageState();
}

class _PengeluaranPageState extends State<PengeluaranPage> {
  int _selectedIndex = 1;
  double saldo = 0;
  List<Transaksi> riwayatTransaksi = [];
  TextEditingController _namaTransaksiController = TextEditingController();
  TextEditingController _pengeluaranController = TextEditingController();

  void tambahTransaksi(String namaTransaksi, double pengeluaran) async {
  Transaksi transaksi = Transaksi(namaTransaksi, pengeluaran);
  setState(() {
    saldo -= pengeluaran;
    riwayatTransaksi.add(transaksi);
  });

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
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth <= 600;

    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Transaksi'),
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
                  child: const Text('Pengeluaran'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/tambah');
                  },
                  style: ElevatedButton.styleFrom(
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
                String namaTransaksi = _namaTransaksiController.text;
                double pengeluaran = double.parse(_pengeluaranController.text);

                tambahTransaksi(namaTransaksi, pengeluaran);

                // Reset form input
                _namaTransaksiController.clear();
                _pengeluaranController.clear();
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
                      'Jumlah: ${riwayatTransaksi[index].pengeluaran}',
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
                      Navigator.pushNamed(context, '/');
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
      initialRoute: '/pengeluaran',
      routes: {
        '/tambah': (context) => TambahTransaksiPage(),
        '/pengeluaran': (context) => PengeluaranPage(),
        '/profile': (context) => ProfilePage(),
      },
    );
  }
}

void main() {
  runApp(MyApp());
}
