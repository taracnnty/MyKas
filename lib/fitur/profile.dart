import 'package:flutter/material.dart';
import 'package:latihan/akun/login.dart';
import 'package:latihan/akun/register.dart';
import 'package:latihan/fitur/riwayat.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth <= 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        automaticallyImplyLeading: !isSmallScreen, // Tampilkan tombol kembali hanya pada layar kecil
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
                          'Sekar Ayu',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Sekarayu123@gmail.com',
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
                    subtitle: const Text('Sekar Ayu'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.email),
                    title: const Text('Email'),
                    subtitle: const Text('Sekarayu123@gmail.com'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.phone),
                    title: const Text('Nomor Telepon'),
                    subtitle: const Text('081234567891'),
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
                if (index == 0) {
                  Navigator.pushNamed(context, '/beranda').then((value) {
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
                      Navigator.pushNamed(context, '/beranda');
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.receipt),
                    title: Text('Riwayat Transaksi'),
                    onTap: () {
                      Navigator.pushNamed(context, '/riwayat_transaksi');
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
        '/': (context) => ProfilePage(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/riwayat_transaksi': (context) => RiwayatPage(),
      },
    );
  }
}

void main() {
  runApp(MyApp());
}
