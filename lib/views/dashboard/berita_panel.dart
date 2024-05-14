import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class ArtikelKeselamatanKerja extends StatelessWidget {
  const ArtikelKeselamatanKerja({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/b1.jpg', // Ganti dengan path gambar yang sesuai
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Text(
                    "Artikel Keselamatan Kerja",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.lightBlue[900],
                    ),
                  ),
                  SizedBox(height: 16),
                  _buildArtikelCard(
                    context,
                    'Pentingnya Keselamatan Kerja di Tempat Kerja',
                    'Keselamatan kerja di tempat kerja merupakan aspek yang sangat penting untuk diperhatikan oleh semua pihak, baik pekerja maupun pengusaha. Artikel ini membahas mengapa keselamatan kerja perlu diutamakan dan bagaimana menerapkannya secara efektif.',
                    'assets/APD.jpg',
                    'https://youtu.be/4eEY6QI82GM?si=jwQwLaJxgmkSX6yd', // Ganti dengan tautan YouTube yang sesuai
                  ),
                  SizedBox(height: 16),
                  _buildArtikelCard(
                    context,
                    'Langkah-langkah Mencegah Kecelakaan Kerja',
                    'Kecelakaan kerja dapat mengakibatkan dampak yang serius bagi pekerja dan perusahaan. Artikel ini menjelaskan langkah-langkah yang dapat diambil untuk mencegah kecelakaan kerja di tempat kerja.',
                    'assets/APD.jpg',
                    'https://youtu.be/r28RWd9lXbw?si=EsLvpXY6Vbz_pLvW', // Ganti dengan tautan YouTube yang sesuai
                  ),
                  SizedBox(height: 16),
                  _buildArtikelCard(
                    context,
                    'Mengenali Bahaya di Tempat Kerja',
                    'Penting untuk mengenali berbagai bahaya potensial di tempat kerja untuk dapat mengambil tindakan pencegahan yang tepat. Artikel ini memberikan panduan untuk mengidentifikasi dan mengatasi bahaya di lingkungan kerja.',
                    'assets/APD.jpg',
                    'https://youtu.be/N5I_Eyv6-wM?si=Y3KPGtQ-qjs9JOx3', // Ganti dengan tautan YouTube yang sesuai
                  ),
                  // Tambahkan artikel lainnya sesuai kebutuhan
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArtikelCard(BuildContext context, String title, String description, String imagePath, String youtubeURL) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        splashColor: Colors.blue.withAlpha(40),
        onTap: () {
          _launchYouTubeURL(youtubeURL);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
              child: Image.asset(
                imagePath,
                width: 150,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _launchYouTubeURL(String url) async {
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        debugPrint('Could not launch $url');
      }
    } catch (e) {
      debugPrint('Error launching YouTube URL: $e');
    }
  }
}