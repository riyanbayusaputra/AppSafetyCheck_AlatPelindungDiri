import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

void main() {
  runApp(CameraAccessPage());
}

class CameraAccessPage extends StatefulWidget {
  @override
  _CameraAccessPageState createState() => _CameraAccessPageState();
}

class _CameraAccessPageState extends State<CameraAccessPage> {
  late List<CameraDescription> cameras;
  late CameraController controller;

  @override
  void initState() {
    super.initState();
    // Inisialisasi kamera dan controller
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    // Mendapatkan daftar kamera yang tersedia
    cameras = await availableCameras();
    // Membuat controller untuk kamera belakang (index 0)
    controller = CameraController(cameras[0], ResolutionPreset.medium);
    // Menginisialisasi controller
    await controller.initialize();
    // Set state untuk membangun tampilan
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    // Hentikan controller ketika widget dihancurkan
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera Access'),
      ),
      body: Center(
        child: controller != null && controller.value.isInitialized
            ? CameraPreview(controller)
            : CircularProgressIndicator(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            // Cek apakah controller sudah diinisialisasi
            if (controller != null && controller.value.isInitialized) {
              // Ambil foto
              final image = await controller.takePicture();
              // Tampilkan dialog dengan path foto
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Foto berhasil diambil!'),
                  content: Text('Lokasi penyimpanan: ${image.path}'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('OK'),
                    ),
                  ],
                ),
              );
            }
          } catch (e) {
            print('Error: $e');
          }
        },
        child: Icon(Icons.camera),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
