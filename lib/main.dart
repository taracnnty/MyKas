import 'package:flutter/material.dart';
import 'package:latihan/akun/login.dart';
import 'package:latihan/akun/register.dart';
import 'package:latihan/beranda/grafik.dart';
import 'package:latihan/fitur/pengeluaran.dart';
import 'package:latihan/fitur/riwayat.dart';
import 'package:latihan/fitur/tambah.dart';
import 'color_schemes.g.dart';
import 'fitur/profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyKas',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
      ),
      home: const MyHomePage(),
      routes: {
        '/profile': (context) => ProfilePage(),
        '/riwayat_transaksi': (context) => RiwayatPage(),
        '/tambah_transaksi': (context) => TambahTransaksiPage(),
        '/beranda': (context) => MyApp(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/pengeluaran': (context) => PengeluaranPage(),
        '/tambah': (context) => TambahTransaksiPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth <= 600;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage("assets/pic.jpg"),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hi, John Doe",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ],
        ),
      ),
      body: grafik(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/tambah_transaksi');
        },
        child: const Icon(Icons.add),
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
                  label: 'Riwayat Transaksi',
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
                if (index == 2) {
                  Navigator.pushNamed(context, '/profile').then((value) {
                    setState(() {
                      _selectedIndex = 0;
                    });
                  });
                } else if (index == 1) {
                  Navigator.pushNamed(context, '/riwayat_transaksi').then((value) {
                    setState(() {
                      _selectedIndex = 0;
                    });
                  });
                } 
              },
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
                      setState(() {
                        _selectedIndex = 0;
                      });
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.receipt),
                    title: Text('Riwayat Transaksi'),
                    onTap: () {
                      setState(() {
                        _selectedIndex = 1;
                      });
                      Navigator.pushNamed(context, '/riwayat_transaksi').then((value) {
                        setState(() {
                          _selectedIndex = 0;
                        });
                      });
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Profil'),
                    onTap: () {
                      setState(() {
                        _selectedIndex = 2;
                      });
                      Navigator.pushNamed(context, '/profile').then((value) {
                        setState(() {
                          _selectedIndex = 0;
                        });
                      });
                    },
                  ),
                ],
              ),
            )
          : null,
    );
  }
}