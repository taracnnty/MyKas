import 'package:flutter/material.dart';
import 'package:latihan/akun/register.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        titleTextStyle: TextStyle(
          color: Theme.of(context).colorScheme.onSecondary,
          fontSize: 22,
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  'Welcome to MyKas',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Catat penggunaan keuanganmu, hanya di aplikasi MyKas',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Logic untuk melakukan login
                final email = _emailController.text;
                final password = _passwordController.text;

                DatabaseService().login(email, password);

                // Navigasi ke halaman beranda setelah login berhasil
                Navigator.pushReplacementNamed(context, '/beranda');
              },
              child: const Text(
                'Login',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Belum punya akun? ',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Navigasi ke halaman beranda setelah login berhasil
                    Navigator.pushReplacementNamed(context, '/register');
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
        '/register': (context) => RegisterPage(),
      },
    );
  }
}

class DatabaseService {
  // Ganti dengan URL server Node.js

  Future<void> login(String email, String password) async {
    final url = Uri.parse('http://localhost:9000/login?email=$email&password=$password');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        print('Login berhasil');
      } else {
        print(response.body);
      }
    } catch (error) {
      // Terjadi kesalahan saat melakukan request
      print('Terjadi kesalahan: $error');
    }
  }
}

void main() {
  runApp(MyApp());
}
