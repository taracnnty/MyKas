import 'package:flutter/material.dart';
import 'package:latihan/fitur/tambah.dart';

class PengeluaranPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Transaksi'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: MyHomePage(),
    );
  }
}

class Transaksi {
  final String nama;
  final double jumlah;

  Transaksi(this.nama, this.jumlah);
}

class MyHomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<MyHomePage> {
  double saldo = 0;
  List<Transaksi> riwayatTransaksi = [];
  TextEditingController namaController = TextEditingController();
  TextEditingController jumlahController = TextEditingController();

  void tambahTransaksi() {
    String nama = namaController.text;
    double jumlah = double.parse(jumlahController.text);

    Transaksi transaksi = Transaksi(nama, jumlah);
    setState(() {
      saldo -= jumlah;
      riwayatTransaksi.add(transaksi);
    });

    // Reset form input
    namaController.clear();
    jumlahController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/tambah');
                },style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).colorScheme.onSecondary,
                    onPrimary: Theme.of(context).colorScheme.onPrimaryContainer,
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
              ElevatedButton(
                onPressed: () {
                },style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).colorScheme.surface,
                    onPrimary: Theme.of(context).colorScheme.onPrimaryContainer,
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.outline,
                      width: 1.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text('Pengeluaran'),
                ),
            ],
          ),
          Text(
            'Total: $saldo',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          TextField(
            controller: namaController,
            decoration: InputDecoration(
              labelText: 'Nama Transaksi',
            ),
          ),
          SizedBox(height: 10),
          TextField(
            controller: jumlahController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Jumlah',
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            child: const Text('Tambah Transaksi',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
            onPressed: tambahTransaksi,
          ),
        ],
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      initialRoute: '/pengeluaran', // set halaman login sebagai halaman pertama
      routes: {
        '/tambah': (context) => TambahTransaksiPage(),
        '/pengeluaran': (context) => PengeluaranPage(),
      },
    );
  }
}

void main() {
  runApp(MyApp());
}