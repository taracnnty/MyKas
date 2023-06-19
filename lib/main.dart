import 'package:flutter/material.dart';
import 'package:latihan/akun/login.dart';
import 'package:latihan/akun/register.dart';
import 'package:latihan/beranda/grafik.dart';
import 'package:latihan/fitur/tambah.dart';
import 'package:latihan/fitur/pengeluaran.dart';
import 'color_schemes.g.dart';
import 'fitur/profile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  String nama = '';
  int pengeluaran = 0;

  Future<void> fetchData() async {
    final url = Uri.parse('http://localhost:9000/data');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          nama = data['nama'] ?? '';
        });
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Terjadi kesalahan: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }
  
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth <= 600;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage("assets/foto.png"),
            ),
            const SizedBox(width: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hi, ",
                  style: TextStyle(fontSize: 18,
                  color: Theme.of(context).colorScheme.onSecondary),
                ),
                Text(
                nama,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                  fontSize: 18,
                ),
              ),
              ],
            ),
          ],
        ),
      ),
      body: grafik (pengeluaran: pengeluaran),
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
                if (index == 2) {
                  Navigator.pushNamed(context, '/profile').then((value) {
                    setState(() {
                      _selectedIndex = 0;
                    });
                  });
                } else if (index == 1) {
                  Navigator.pushNamed(context, '/pengeluaran').then((value) {
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
                    iconColor: Colors.white,
                    title: Text('Beranda'),
                    textColor: Colors.white,
                    onTap: () {
                      setState(() {
                        _selectedIndex = 0;
                      });
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.receipt),
                    iconColor: Colors.white,
                    title: Text('Tambah Transaksi'),
                    textColor: Colors.white,
                    onTap: () {
                      setState(() {
                        _selectedIndex = 1;
                      });
                      Navigator.pushNamed(context, '/pengeluaran').then((value) {
                        setState(() {
                          _selectedIndex = 0;
                        });
                      });
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.person),
                    iconColor: Colors.white,
                    title: Text('Profil'),
                    textColor: Colors.white,
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