import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:date_format/date_format.dart';
import '../controllers/kamar_controller.dart';

class KelolaView extends StatelessWidget {
  final String roomName; // Menyimpan nama kamar yang diterima

  // Konstruktor menerima parameter roomName
  KelolaView({Key? key, required this.roomName}) : super(key: key);

  final KamarController controller = Get.put(KamarController()); //Get.find<KamarController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kelola Kamar: $roomName'),  // Menampilkan nama kamar pada judul
        centerTitle: true,
        backgroundColor: Colors.cyan,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back(); // Navigasi kembali ke halaman sebelumnya
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // Tambahkan logika filter di sini
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bagian profil gambar
            Center(
              child: Obx(() {
                return CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: controller.selectedImagePath.value.isEmpty
                      ? null
                      : FileImage(File(controller.selectedImagePath.value)),
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      if (controller.selectedImagePath.value.isEmpty)
                        const Icon(Icons.person, size: 50),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: IconButton(
                          icon: const Icon(
                            Icons.camera_alt,
                            size: 20,
                            color: Colors.black,
                          ),
                          onPressed: () async {
                            final ImagePicker picker = ImagePicker();
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return SafeArea(
                                  child: Wrap(
                                    children: [
                                      ListTile(
                                        leading: const Icon(Icons.photo_library),
                                        title: const Text('Galeri'),
                                        onTap: () async {
                                          final XFile? image = await picker.pickImage(
                                            source: ImageSource.gallery,
                                            imageQuality: 50,
                                          );
                                          if (image != null) {
                                            controller.selectedImagePath.value = image.path;
                                          }
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      ListTile(
                                        leading: const Icon(Icons.camera_alt),
                                        title: const Text('Kamera'),
                                        onTap: () async {
                                          final XFile? image = await picker.pickImage(
                                            source: ImageSource.camera,
                                            imageQuality: 50,
                                          );
                                          if (image != null) {
                                            controller.selectedImagePath.value = image.path;
                                          }
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
            const SizedBox(height: 16),
            // Formulir nama, no HP, dan NIK
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: controller.nameController,
                      decoration: InputDecoration(
                        labelText: 'Nama',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: controller.phoneController,
                      decoration: InputDecoration(
                        labelText: 'No. HP',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: controller.nikController,
                      decoration: InputDecoration(
                        labelText: 'NIK',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Informasi tanggal masuk dan jenis kamar
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: controller.dateController,
                      decoration: InputDecoration(
                        labelText: 'Tanggal Masuk',
                        border: OutlineInputBorder(),
                      ),
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );

                        if (pickedDate != null) {
                          String formattedDate = formatDate(pickedDate, [dd, '-', mm, '-', yyyy]);
                          controller.dateController.text = formattedDate;
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: controller.roomTypeController,
                      decoration: InputDecoration(
                        labelText: 'Jenis Kamar',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // List pembayaran
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'List Pembayaran',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Divider(),
                    Obx(() {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.payments.length,
                        itemBuilder: (context, index) {
                          final payment = controller.payments[index];
                          return ListTile(
                            leading: const Icon(Icons.payment),
                            title: Text('Sudah membayar tanggal: ${payment['date']}'),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                controller.removePayment(index); // Menghapus pembayaran
                              },
                            ),
                          );
                        },
                      );
                    }),
                    ElevatedButton(
                      onPressed: () {
                        controller.addPayment(); // Menambah pembayaran baru
                      },
                      child: const Text('Tambah Pembayaran'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Tombol Simpan Data
            ElevatedButton(
              onPressed: () async {
                // Pastikan kita mendapatkan roomKey dari controller
                String roomKey = controller.currentRoom.value; // Ambil room yang sedang dipilih
                await controller.saveData(roomKey); // Simpan data berdasarkan roomKey
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Data berhasil disimpan!')),
                );
              },
              child: Text('Simpan Data'),
            ),

            const SizedBox(height: 16),
            // Tombol Hapus Data
            ElevatedButton(
            onPressed: () async {
              // Ambil roomKey dari controller (kamar yang sedang dipilih)
              String roomKey = controller.currentRoom.value; // Mengambil nama kamar yang aktif
              await controller.clearData(roomKey); // Hapus data berdasarkan roomKey
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Data berhasil dihapus!')),
              );
            },
            child: const Text('Hapus Data'),
          )

          ],
        ),
      ),
    );
  }
}
