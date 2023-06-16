const express = require('express'); //sambungan flutter dengan backend
const mysql = require('mysql');
const bodyParser = require('body-parser'); 
const cors = require('cors');

const app = express();
const port = 3000;

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


// Mengambil data dari tabel tb_user
app.get('/data', (req, res) => {
  const query = 'SELECT * FROM tb_user';
  db.query(query, (err, results) => {
    if (err) {
      console.error('Error executing query:', err);
      res.sendStatus(500);
      return;
    }
    res.json(results);
  });
});


// Menjalankan server
app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});