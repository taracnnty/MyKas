import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
            onPressed: () {
              // Logic untuk melakukan login
              
              // Navigasi ke halaman beranda setelah login berhasil
              Navigator.pushReplacementNamed(context, '/beranda');
            },
            child: const Text('Login'),
            ),
          const SizedBox(height: 16.0),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Belum punya akun? ',
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
                ElevatedButton(
              onPressed: () {
                // Logic untuk melakukan login

                // Navigasi ke halaman beranda setelah login berhasil
                Navigator.pushReplacementNamed(context, '/beranda');
              },
                  child: const Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
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
      initialRoute: '/login', // set halaman login sebagai halaman pertama
      routes: {
        '/login': (context) => LoginPage(),
        '/beranda': (context) => MyApp(),
      },
    );
  }
}

void main() {
  runApp(MyApp());
}