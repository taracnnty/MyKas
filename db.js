const express = require('express'); //sambungan flutter dengan backend
const mysql = require('mysql');
const bodyParser = require('body-parser'); 
const cors = require('cors');

const app = express();
const port = 9000;

// Konfigurasi database
const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'db_keuangan',
});

// Membuat koneksi ke database
db.connect((err) => {
  if (err) {
    console.error('Koneksi database gagal: ' + err.stack);
    return;
  }
  console.log('Terhubung ke database');
});

// Menggunakan middleware bodyParser untuk mengurai body request
app.use(bodyParser.json());

app.use(cors());

app.post('/register', (req, res) => {
  // Mendapatkan data dari body request
  const {nama, email, password, no_telp} = req.body;

  // Memeriksa apakah data yang diperlukan ada
  if (nama && email && password && no_telp) {
    const data = {
      nama,
      email,
      password,
      no_telp,
    };

    // Melakukan operasi create di database menggunakan nilai data
    db.query('INSERT INTO tb_user SET ?', data, (error, results) => {
      if (error) {
        console.log(error);
        res.status(500).json({ message: 'Error creating data in database' });
      } else {
        res.status(200).json({ message: 'Data created successfully' });
      }
    });
  } else {
    res.status(400).json({ message: 'Invalid data format' });
  }
});

app.post('/data3', (req, res) => {
  // Mendapatkan data dari body request
  const { nama_transaksi, pengeluaran } = req.body;

  // Memeriksa apakah data yang diperlukan ada
  if (nama_transaksi && pengeluaran) {
    const data = {
      nama_transaksi,
      pengeluaran,
    };

    // Melakukan operasi create di database menggunakan nilai data
    db.query('INSERT INTO tb_riwayat SET ?', data, (error, results) => {
      if (error) {
        console.log(error);
        res.status(500).json({ message: 'Error creating data in database' });
      } else {
        res.status(200).json({ message: 'Data created successfully' });
      }
    });
  } else {
    res.status(400).json({ message: 'Invalid data format' });
  }
});

app.post('/data4', (req, res) => {
  // Mendapatkan data dari body request
  const { nama_transaksi, pemasukan } = req.body;

  // Memeriksa apakah data yang diperlukan ada
  if (nama_transaksi && pemasukan) {
    const data = {
      nama_transaksi,
      pemasukan,
    };

    // Melakukan operasi create di database menggunakan nilai data
    db.query('INSERT INTO tb_pemasukan SET ?', data, (error, results) => {
      if (error) {
        console.log(error);
        res.status(500).json({ message: 'Error creating data in database' });
      } else {
        res.status(200).json({ message: 'Data created successfully' });
      }
    });
  } else {
    res.status(400).json({ message: 'Invalid data format' });
  }
});

app.get('/login', (req, res) => {
  // Mendapatkan data dari query parameters
  const email = req.query.email;
  const password = req.query.password;

  // Lakukan proses autentikasi di sini (misalnya, memeriksa kecocokan email dan password dengan data yang ada di database)
  const query = 'SELECT * FROM tb_user WHERE email = ? AND password = ?';
  db.query(query, [email, password], (err, results) => {
    if (err) {
      console.error('Error executing query:', err);
      res.sendStatus(500);
      return;
    }

    // Memeriksa apakah ada hasil dari query
    if (results.length > 0) {
      // Autentikasi berhasil
      res.status(200).json({ message: 'Login successful' });
    } else {
      // Autentikasi gagal
      res.status(401).json({ message: 'Invalid credentials' });
    }
  });
});

// Mengambil data pengguna
app.get('/data', (req, res) => {
  const query = 'SELECT * FROM tb_user'; // Ubah query sesuai dengan struktur tabel dan kolom yang sesuai
  db.query(query, (err, results) => {
    if (err) {
      console.error('Error executing query:', err);
      res.sendStatus(500);
      return;
    }
    if (results.length > 0) {
      const user = results[0];
      const data = {
        nama: user.nama,
        email: user.email,
        no_telp: user.no_telp,
        saldo: user.saldo,
      };
      res.setHeader('Content-Type', 'application/json'); // Tambahkan pernyataan Content-Type
      res.json(data);
    } else {
      res.sendStatus(404);
    }
  });
});


app.get('/data1', (req, res) => {
  const query = 'SELECT SUM(jumlah) AS pengeluaran FROM tb_riwayat';
  db.query(query, (err, results) => {
    if (err) {
      console.error('Error executing query:', err);
      res.sendStatus(500);
      return;
    }
    if (results.length > 0) {
      const row = results[0];
      const data = {
        pengeluaran: row.pengeluaran,
      };
      res.json(data);
    } else {
      res.sendStatus(404);
    }
  });
});

app.get('/data2', (req, res) => {
  const query = 'SELECT SUM(jumlah) AS pemasukan FROM tb_pemasukan';
  db.query(query, (err, results) => {
    if (err) {
      console.error('Error executing query:', err);
      res.sendStatus(500);
      return;
    }
    if (results.length > 0) {
      const row = results[0];
      const data = {
        pemasukan: row.pemasukan,
      };
      res.json(data);
    } else {
      res.sendStatus(404);
    }
  });
});


// Menjalankan server
app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});