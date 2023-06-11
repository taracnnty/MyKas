import 'package:flutter/material.dart';
import 'package:latihan/akun/login.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth <= 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        automaticallyImplyLeading: isSmallScreen,
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
                          backgroundImage: AssetImage('assets/pic.jpg'),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'John Doe',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'john.doe@gmail.com',
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
                    subtitle: const Text('John Doe'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.email),
                    title: const Text('Email'),
                    subtitle: const Text('john.doe@gmail.com'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.phone),
                    title: const Text('Nomor Telepon'),
                    subtitle: const Text('081234567890'),
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
      },
    );
  }
}

void main() {
  runApp(MyApp());
}