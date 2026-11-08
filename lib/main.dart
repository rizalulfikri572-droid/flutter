import 'package:flutter/material.dart';
void main() {
  runApp(MyApp());
}


class Menu {
  final String nama;
  final String harga;
  final String deskripsi;

  Menu({required this.nama, required this.harga, required this.deskripsi});
}

final List<Menu> daftarMenu = [
  Menu(
    nama: 'Espresso',
    harga: 'Rp 15.000',
    deskripsi: 'Kopi hitam pekat dengan rasa kuat, cocok untuk pencinta '
        'kopi sejati.',
  ),
  Menu(
    nama: 'Kopi Susu Gula Aren',
    harga: 'Rp 18.000',
    deskripsi: 'Perpaduan espresso, susu segar, dan gula aren yang manis '
        'legit. Menu paling favorit.',
  ),
  Menu(
    nama: 'Americano',
    harga: 'Rp 17.000',
    deskripsi: 'Espresso dengan tambahan air panas, rasa ringan dan segar.',
  ),
  Menu(
    nama: 'Caffe Latte',
    harga: 'Rp 22.000',
    deskripsi: 'Espresso dengan susu steamed yang lembut dan creamy.',
  ),
];


Widget gambarKopi({required double lebar, required double tinggi}) {
  return Image.asset(
    "assets/image/logo.png",
    width: lebar,
    height: tinggi,
    fit: BoxFit.contain,
    errorBuilder: (context, error, stackTrace) {
      return Container(
        width: lebar,
        height: tinggi,
        color: Colors.brown.shade100,
        child: Icon(Icons.coffee, size: 40, color: Colors.brown),
      );
    },
  );
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kopi Kekalahan',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFFFF8F0),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.brown,
          foregroundColor: Colors.white,
        ),
      ),
      home: HomePage(),
    );
  }
}

// ============================================================
// HALAMAN 1: BERANDA
// ============================================================
class HomePage extends StatelessWidget {
  // Tombol menu yang dipakai berulang
  Widget tombolMenu(
      BuildContext context, IconData ikon, String label, Widget tujuan) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 6),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.brown,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 14),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => tujuan),
          );
        },
        icon: Icon(ikon),
        label: Text(label, style: TextStyle(fontSize: 16)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Bar abu-abu penuh di bagian atas
            Container(
              width: double.infinity,
              height: 90,
              color: Colors.grey.shade300,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.coffee, size: 40, color: Colors.brown),
                  SizedBox(width: 10),
                  Text(
                    'SELAMAT DATANG DI KOPI KEKALAHAN',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            // Gambar
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: gambarKopi(lebar: 220, tinggi: 220),
            ),
            SizedBox(height: 16),

            Text(
              'Ngopi dulu, kalah belakangan.',
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: Colors.brown.shade700,
              ),
            ),
            SizedBox(height: 24),

            // Tombol pindah halaman
            tombolMenu(context, Icons.menu_book, 'Lihat Menu', DaftarMenuPage()),
            tombolMenu(context, Icons.info, 'Tentang Kami', TentangPage()),
            tombolMenu(context, Icons.phone, 'Kontak & Lokasi', KontakPage()),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// HALAMAN 2: DAFTAR MENU
// ============================================================
class DaftarMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Daftar Menu')),
      body: ListView.builder(
        padding: EdgeInsets.all(12),
        itemCount: daftarMenu.length,
        itemBuilder: (context, index) {
          final menu = daftarMenu[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailMenuPage(menu: menu),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 12),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 6),
                ],
              ),
              // ROW: gambar | tulisan | panah
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: gambarKopi(lebar: 80, tinggi: 80),
                  ),
                  SizedBox(width: 14),
                  // COLUMN: nama di atas, harga di bawah
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          menu.nama,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          menu.harga,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.brown,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class DetailMenuPage extends StatelessWidget {
  final Menu menu;

  DetailMenuPage({required this.menu});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(menu.nama)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            gambarKopi(lebar: double.infinity, tinggi: 260),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    menu.nama,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.sell, color: Colors.orange),
                      SizedBox(width: 8),
                      Text(
                        menu.harga,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Deskripsi',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 6),
                  Text(
                    menu.deskripsi,
                    style: TextStyle(fontSize: 15, height: 1.5),
                  ),
                  SizedBox(height: 24),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back),
                      label: Text('Kembali'),
                    ),
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

class TentangPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tentang Kami')),
      body: Container(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            ClipOval(child: gambarKopi(lebar: 140, tinggi: 140)),
            SizedBox(height: 16),
            Text(
              'Kopi Kekalahan',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
            ),
            SizedBox(height: 12),
            Text(
              'Kedai kopi sederhana untuk kamu yang sedang kalah, '
              'lelah, atau sekadar butuh teman ngobrol. Kami menyajikan '
              'kopi dengan harga bersahabat dan suasana hangat.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, height: 1.5),
            ),
            SizedBox(height: 24),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.brown.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.access_time, color: Colors.brown),
                  SizedBox(width: 10),
                  Text(
                    'Buka setiap hari 09.00 - 22.00',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Kembali'),
            ),
          ],
        ),
      ),
    );
  }
}


class KontakPage extends StatelessWidget {
  Widget baris(IconData ikon, Color warna, String judul, String isi) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: warna),
      ),
      child: Row(
        children: [
          Icon(ikon, color: warna, size: 30),
          SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                judul,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              SizedBox(height: 2),
              Text(isi, style: TextStyle(color: Colors.black54)),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Kontak & Lokasi')),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hubungi Kami',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
            ),
            SizedBox(height: 16),
            baris(Icons.location_on, Colors.red, 'Alamat',
                'Jl. Contoh No. 1, Semarang'),
            baris(Icons.phone, Colors.green, 'Telepon', '0812-0000-0000'),
            baris(Icons.camera_alt, Colors.purple, 'Instagram',
                '@kopikekalahan'),
            Spacer(),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Kembali ke Beranda'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}