import 'package:flutter/material.dart';
import 'package:latihan/akun/login.dart';
import 'package:latihan/akun/register.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 2;
  String nama = '';
  String email = '';
  String noTelp = '';

  Future<void> fetchData() async {
    final url = Uri.parse('http://localhost:9000/data');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          nama = data['nama'] ?? '';
          email = data['email'] ?? '';
          noTelp = data['no_telp'] ?? '';
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
        title: const Text('Profil'),
        titleTextStyle: TextStyle(
          color: Theme.of(context).colorScheme.onSecondary,
          fontSize: 22,
        ),
        automaticallyImplyLeading: !isSmallScreen,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 250,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.background,
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).colorScheme.outline,
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        const CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage('assets/foto.png'),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          nama,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          email,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.surfaceTint,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Informasi Akun',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('Nama Lengkap'),
                    subtitle: Text(nama),
                  ),
                  ListTile(
                    leading: const Icon(Icons.email),
                    title: const Text('Email'),
                    subtitle: Text(email),
                  ),
                  ListTile(
                    leading: const Icon(Icons.phone),
                    title: const Text('No Telepon'),
                    subtitle: Text(noTelp),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Pengaturan',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SwitchListTile(
                    title: const Text('Notifikasi'),
                    value: true,
                    onChanged: (value) {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Keluar'),
                    onTap: () {
                      Navigator.pushNamed(context, '/login');
                    },
                  ),
                ],
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
                    title: Text('Beranda'),
                    onTap: () {
                      Navigator.pushNamed(context, '/beranda');
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.receipt),
                    title: Text('Tambah Transaksi'),
                    onTap: () {
                      Navigator.pushNamed(context, '/pengeluaran');
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Profil'),
                    onTap: () {
                      Navigator.pushNamed(context, '/');
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
      initialRoute: '/',
      routes: {
        '/profile': (context) => ProfilePage(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
      },
    );
  }
}

void main() {
  runApp(MyApp());
}
