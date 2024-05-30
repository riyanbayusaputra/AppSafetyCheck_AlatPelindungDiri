import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ArtikelKeselamatanKerja extends StatefulWidget {
  const ArtikelKeselamatanKerja({Key? key}) : super(key: key);

  @override
  _ArtikelKeselamatanKerjaState createState() =>
      _ArtikelKeselamatanKerjaState();
}

class _ArtikelKeselamatanKerjaState extends State<ArtikelKeselamatanKerja> {
  final List<Map<String, String>> artikelList = [
    {
      'title': 'Pentingnya Keselamatan Kerja di Tempat Kerja',
      'videoId': '4eEY6QI82GM', // YouTube video ID
    },
    {
      'title': 'Langkah-langkah Mencegah Kecelakaan Kerja',
      'videoId': 'r28RWd9lXbw', // YouTube video ID
    },
    {
      'title': 'Mengenali Bahaya di Tempat Kerja',
      'videoId': 'N5I_Eyv6-wM', // YouTube video ID
    },
    //  {
    //   'title': 'Pentingnya Peralatan Pelindung Diri',
    //   'videoId': 'L5b5Uy6klEg', // YouTube video ID
    // },
    // {
    //   'title': 'Keselamatan Listrik di Tempat Kerja',
    //   'videoId': 'Z9PkhusXj7Q', // YouTube video ID
    // },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Artikel Keselamatan Kerja",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 190, 122, 12),
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: artikelList.map((artikel) {
              final thumbnailUrl =
                  'https://img.youtube.com/vi/${artikel['videoId']}/0.jpg';
              return Column(
                children: [
                  const SizedBox(height: 16),
                  _buildArtikelCard(
                    context,
                    artikel['title']!,
                    thumbnailUrl,
                    'https://youtu.be/${artikel['videoId']}',
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildArtikelCard(BuildContext context, String title, String imageUrl, String youtubeURL) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        splashColor: const Color.fromARGB(255, 243, 79, 33).withAlpha(40),
        onTap: () {
          _launchYouTubeURL(youtubeURL);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: Image.network(
                imageUrl,
                width: 150,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.blue,
                      ),
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
      // ignore: deprecated_member_use
      if (await canLaunch(url)) {
        // ignore: deprecated_member_use
        await launch(url);
      } else {
        debugPrint('Could not launch $url');
      }
    } catch (e) {
      debugPrint('Error launching YouTube URL: $e');
    }
  }
}
