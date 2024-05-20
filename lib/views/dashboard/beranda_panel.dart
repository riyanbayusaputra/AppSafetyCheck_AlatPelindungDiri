import 'package:cp6_apd/data/localsources/auth_local_storage.dart';
import 'package:cp6_apd/views/dashboard/berita_panel.dart';
import 'package:cp6_apd/views/dashboard/deteksi.dart';


import 'package:cp6_apd/views/dashboard/login_page.dart';


import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

class BerandaPanel extends StatelessWidget {
  const BerandaPanel({Key? key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const _BackgroundDashboard(),
        const _InformasiPengguna(),
        Card(
          margin: const EdgeInsets.fromLTRB(0, 190, 0, 0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          child: Container(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10), // Adjusted SizedBox height
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Berita',
                        style: TextStyle(fontSize: 19),
                      ),
                    ],
                  ),
                  _ListBerita(),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, top: 8),
                    child: Text(
                      'Check your safety now!', // Deskripsi untuk list berita
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Wrap(
                    children: [
                      // _TombolMenu(
                      //   gambar: 'assets/icon1.png',
                      //   onTap: () {
                      //     // Navigator.push(
                      //     //   context,
                      //     //   MaterialPageRoute(builder: (c) => const BerandaPanel()),
                      //     // );
                      //   },
                      // ),
                      // _TombolMenu(
                      //   gambar: 'assets/news-reporter.png',
                      //   onTap: () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (c) => const ArtikelKeselamatanKerja()),
                      //     );
                      //   },
                      // ),
                      _TombolMenu(
                        gambar: 'assets/camera.png',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (c) => const YoloVideo()),
                          );
                        },
                      ),
                      // _TombolMenu(
                      //   gambar: 'assets/management.png',
                      //   onTap: () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(builder: (c) => const Test1()),
                      //     );
                      //   },
                      // ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      "Penjual APD",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: _ListPenjualAPD(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _TombolMenu extends StatelessWidget {
  final String gambar;
  final VoidCallback onTap;

  const _TombolMenu({Key? key, required this.gambar, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(13),
        margin: const EdgeInsets.all(8),
        child: Image.asset(
          gambar,
          width: 40,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xdadadaff),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(125, 112, 158, 158),
              blurRadius: 2,
              spreadRadius: 2,
              offset: Offset(2, 2),
            )
          ],
        ),
      ),
    );
  }
}

class _ListBerita extends StatelessWidget {
  const _ListBerita({Key? key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> daftarBerita = [
      {
        'assetgambar': 'assets/b.jpg',
        'judul': 'Kecelakaan Kerja di Pabrik Menyebabkan Cedera Serius',
        'deskripsi':
            'Sebuah kecelakaan kerja di sebuah pabrik mengakibatkan beberapa pekerja mengalami cedera serius. Insiden ini terjadi akibat kelalaian dalam penggunaan peralatan mesin di lantai produksi. Para pekerja yang terluka saat ini sedang mendapatkan perawatan medis yang intensif.'
      },
      {
        'assetgambar': 'assets/c.jpg',
        'judul':
            'Insiden Kecelakaan Kerja di Konstruksi Menimbulkan Kontroversi',
        'deskripsi':
            'Insiden tragis terjadi di lokasi konstruksi yang mengakibatkan beberapa pekerja terluka dan satu di antaranya tewas. Penyelidikan awal menunjukkan bahwa kecelakaan terjadi karena kelalaian dalam penerapan standar keselamatan kerja. Hal ini memicu kontroversi dan menyoroti perlunya peningkatan keamanan di industri konstruksi.'
      },
      {
        'assetgambar': 'assets/d.jpg',
        'judul':
            'Kecelakaan Kerja di Pertambangan: Ancaman Bagi Keselamatan Pekerja',
        'deskripsi':
            'Sebuah kecelakaan mengerikan terjadi di sebuah tambang yang mengakibatkan beberapa pekerja terperangkap di dalam tambang. Tim penyelamat saat ini berjuang keras untuk menyelamatkan mereka. Insiden ini mengingatkan akan risiko tinggi yang dihadapi oleh para pekerja di industri pertambangan.'
      },
      {
        'assetgambar': 'assets/e.jpg',
        'judul': 'Peningkatan Kecelakaan Kerja: Perlunya Tindakan Preventif',
        'deskripsi':
            'Data baru menunjukkan peningkatan jumlah kecelakaan kerja dalam beberapa tahun terakhir. Faktor-faktor seperti kurangnya pelatihan, pengawasan yang lemah, dan ketidakpatuhan terhadap prosedur keselamatan menjadi penyebab utama. Para ahli menekankan pentingnya tindakan preventif yang lebih proaktif untuk mengurangi risiko kecelakaan kerja.'
      },
    ];

    return SizedBox(
      width: double.infinity,
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: daftarBerita.length,
        itemBuilder: (context, index) {
          return _ItemBerita(
            assetgambar: daftarBerita[index]['assetgambar']!,
            judulBerita: daftarBerita[index]['judul']!,
            deskripsiBerita: daftarBerita[index]['deskripsi']!,
          );
        },
      ),
    );
  }
}

class _ItemBerita extends StatelessWidget {
  final String assetgambar;
  final String judulBerita;
  final String deskripsiBerita;

  const _ItemBerita(
      {Key? key,
      this.assetgambar = '',
      this.judulBerita = '',
      this.deskripsiBerita = ''});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailBeritaPage(
                assetgambar: assetgambar,
                judulBerita: judulBerita,
                deskripsiBerita: deskripsiBerita,
              ),
            ),
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            assetgambar,
            width: 250,
            height: 130,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class _InformasiPengguna extends StatelessWidget {
  const _InformasiPengguna({Key? key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 60, 22, 10),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(
              'assets/potoprofil.jpg',
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Text(
                //   'hi, Riyan',
                //   style: TextStyle(color: Colors.white, fontSize: 19),
                // ),
                Text(
                  'Hai, Selamat Datang di SafetyCheck: Sistem Deteksi Alat Pelindung Diri (APD) ',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {
        // Proses logout jika pengguna menekan "Ya"
        await AuthLocalStorage().removeToken();
        
        // Arahkan ke halaman login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      },
      child: Image.asset(
        'assets/sign-out.png',
        width: 30,
            ),
          )
        ],
      ),
    );
  }
}

class _BackgroundDashboard extends StatelessWidget {
  const _BackgroundDashboard({Key? key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/b1.jpg',
      height: 300,
      width: double.infinity,
      fit: BoxFit.cover,
    );
  }
}

class DetailBeritaPage extends StatelessWidget {
  final String assetgambar;
  final String judulBerita;
  final String deskripsiBerita;

  const DetailBeritaPage({
    Key? key,
    required this.assetgambar,
    required this.judulBerita,
    required this.deskripsiBerita,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Berita Terkini'),
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromRGBO(255, 140, 0, 1),
              ], // Mengubah warna oranye ke warna baru
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: 'berita_$assetgambar',
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                elevation: 4,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.asset(
                    assetgambar,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                judulBerita,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                deskripsiBerita,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ListPenjualAPD extends StatelessWidget {
  const _ListPenjualAPD({Key? key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          _buildPenjualAPD(
            nameShop: "Toko APD Damarwulan safety",
            imagePath: 'assets/apd1.jpg',
            rating: "4.8",
            jamBuka: "08.00 - 20.00",
            googleMapsUrl:
                "https://www.google.com/maps/place/APD.DAMARWULAN.safety/@-7.6890758,109.0266336,17z/data=!3m1!4b1!4m6!3m5!1s0x2e656d36bacf6437:0x96a22c213950c344!8m2!3d-7.6890758!4d109.0266336!16s%2Fg%2F11hbn5x2s0?entry=ttu",
          ),
          _buildPenjualAPD(
            nameShop: "APD Andara",
            imagePath: 'assets/uj.jpg',
            rating: "4.7",
            jamBuka: "09.00 - 21.00",
            googleMapsUrl:
                "https://www.google.com/maps/place/sinar+andhara+alat+pelindung+diri+apd/@-7.2047783,106.5627743,7z/data=!4m10!1m2!2m1!1smaps+apd!3m6!1s0x2e6fb75f31aae211:0xe7d889f49603bbba!8m2!3d-6.8569896!4d109.1321384!15sCghtYXBzIGFwZJIBHm9jY3VwYXRpb25hbF9zYWZldHlfYW5kX2hlYWx0aOABAA!16s%2Fg%2F11vd346btg?entry=ttu",
          ),
          _buildPenjualAPD(
            nameShop: "APD faceshield",
            imagePath: 'assets/wulan.jpg',
            rating: "4.5",
            jamBuka: "08.30 - 20.30",
            googleMapsUrl:
                "https://www.google.com/maps/place/APD+FaceSHIELD+EVA+anak%26dewasa/@-7.7372729,110.4545105,17z/data=!3m1!4b1!4m6!3m5!1s0x2e7a5bcbd6e57ff1:0x4f6d7eaa27d340f9!8m2!3d-7.7372729!4d110.4545105!16s%2Fg%2F11jgt5nt27?entry=ttu",
          ),
          _buildPenjualAPD(
            nameShop: "Toko APD Sentosa",
            imagePath: 'assets/bandung.jpg',
            rating: "4.4",
            jamBuka: "08.00 - 18.00",
            googleMapsUrl:
                "https://www.google.com/maps/place/Toko+Alat+Alat+Safety+Apd+Bandung/@-6.9128296,102.9750276,7z/data=!4m10!1m2!2m1!1smaps+apd!3m6!1s0x2e68e7b91d7ff4f9:0x58d73e84a119a951!8m2!3d-6.9128296!4d107.5892854!15sCghtYXBzIGFwZFoFIgNhcGSSAQp0b29sX3N0b3Jl4AEA!16s%2Fg%2F11mqx9ts84?entry=ttu",
          ),
          // Tambahkan penjual APD lainnya sesuai kebutuhan
        ],
      ),
    );
  }

  Widget _buildPenjualAPD(
      {required String nameShop,
      required String rating,
      required String jamBuka,
      required String googleMapsUrl,
      required String imagePath}) {
    return PenjualAPD(
      nameShop: nameShop,
      rating: rating,
      jamBuka: jamBuka,
      googleMapsUrl: googleMapsUrl,
      imagePath: imagePath,
    );
  }
}

class PenjualAPD extends StatelessWidget {
  final String nameShop;
  final String rating;
  final String jamBuka;
  final String googleMapsUrl;
  final String imagePath; // Tambahkan parameter imagePath

  const PenjualAPD({
    Key? key,
    required this.nameShop,
    required this.rating,
    required this.jamBuka,
    required this.googleMapsUrl,
    required this.imagePath, // Tambahkan imagePath ke dalam constructor
  }) : super(key: key);

  void _openGoogleMaps(BuildContext context) async {
    try {
      if (await canLaunch(googleMapsUrl)) {
        await launch(googleMapsUrl);
      } else {
        debugPrint('Could not launch $googleMapsUrl');
      }
    } catch (e) {
      debugPrint('Error opening Google Maps: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: InkWell(
        onTap: () => _openGoogleMaps(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              imagePath, // Gunakan imagePath yang diterima dari parameter
              width: double.infinity,
              height: 150,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nameShop,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber),
                      SizedBox(width: 4),
                      Text(rating),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text("Jam Buka: $jamBuka"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
