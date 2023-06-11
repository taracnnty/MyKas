import 'package:flutter/material.dart';

class TambahTransaksiPage extends StatelessWidget {
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
      saldo += jumlah;
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
          Text(
            'Saldo: $saldo',
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
            child: Text('Tambah Transaksi'),
            onPressed: tambahTransaksi,
          ),
          SizedBox(height: 20),
          Text(
            'Riwayat Transaksi',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: riwayatTransaksi.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    riwayatTransaksi[index].nama,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Jumlah: ${riwayatTransaksi[index].jumlah}',
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
