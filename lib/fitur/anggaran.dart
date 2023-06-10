import 'package:flutter/material.dart';

class AnggaranPage extends StatelessWidget {
  const AnggaranPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anggaran'),
      ),
      body: Center(
        child: const Text('Halaman Anggaran'),
      ),
    );
  }
}
