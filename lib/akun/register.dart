import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:latihan/akun/login.dart';
import 'dart:convert';

class RegisterPage extends StatelessWidget {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _no_telpController = TextEditingController();
  final TextEditingController _saldo = TextEditingController();

  RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
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
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _namaController,
              decoration: const InputDecoration(
                labelText: 'Nama',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _no_telpController,
              decoration: const InputDecoration(
                labelText: 'No Telepon',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Logic untuk melakukan registrasi
                final nama = _namaController.text;
                final email = _emailController.text;
                final password = _passwordController.text;
                final no_telp = _no_telpController.text;
                final saldo = _saldo.text;

                DatabaseService()
                    .register(nama, email, password, no_telp, saldo);

                // Navigasi ke halaman beranda setelah registrasi berhasil
                Navigator.pushReplacementNamed(context, '/beranda');
              },
              child: const Text(
                'Register',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Sudah punya akun? ',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: const Text(
                    'Login',
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
      initialRoute: '/register', // set halaman login sebagai halaman pertama
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

  Future<void> register(String nama, String email, String password,
      String no_telp, String saldo) async {
    final url = Uri.parse('http://localhost:9000/register');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'nama': nama,
          'email': email,
          'password': password,
          'no_telp': no_telp,
          'saldo': saldo,
        }),
      );

      if (response.statusCode == 200) {
        // Registrasi berhasil
        print('Registrasi berhasil');
      } else {
        // Registrasi gagal
        print(response.body);
      }
    } catch (error) {
      // Terjadi kesalahan saat melakukan request
      print('Terjadi kesalahan: $error');
    }
  }
}
