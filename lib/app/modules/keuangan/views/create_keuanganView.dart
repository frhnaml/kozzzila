import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kozzzila/app/modules/keuangan/controllers/keuangan_controller.dart';
import 'package:flutter/services.dart'; // Import this for input formatters

class CreateKeuanganview extends StatelessWidget {
  CreateKeuanganview({super.key, this.docId, this.existingData});
  final KeuanganController keuanganController = Get.find<KeuanganController>();
  final String? docId; // for the document ID
  final Map<String, dynamic>? existingData;

  @override
  Widget build(BuildContext context) {
    if (existingData != null) {
      keuanganController.tanggalController.text = existingData!['tanggal'];
      keuanganController.kosanController.text = existingData!['kosan'];
      keuanganController.selectedCategory.value = existingData!['kategori'];
      keuanganController.keteranganController.text =
          existingData!['keterangan'];
      keuanganController.pengeluaranController.text =
          existingData!['pengeluaran'];
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          existingData == null ? 'Tambah Pengeluaran' : 'Edit Pengeluaran',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.lightBlue[200],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              const SizedBox(height: 15),
              const Text('Tanggal'),
              const SizedBox(height: 7),
              TextField(
                controller: keuanganController.tanggalController,
                readOnly: true,
                decoration: InputDecoration(
                    hintText: '01-11-2111',
                    fillColor: Colors.grey[500],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20),
                    suffixIcon: IconButton(
                        onPressed: () => keuanganController.selectDate(context),
                        icon: const Icon(Icons.calendar_today_rounded))),
              ),
              const SizedBox(height: 15),
              const Text('Kosan'),
              const SizedBox(height: 7),
              TextField(
                controller: keuanganController.kosanController,
                decoration: InputDecoration(
                  hintText: 'Kosan 1',
                  fillColor: Colors.grey[500],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                ),
              ),
              const SizedBox(height: 15),
              const Text('Kategori'),
              const SizedBox(height: 7),
              Obx(() {
                return DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    hintText: '-- Pilih Kategori --',
                    fillColor: Colors.grey[500],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20),
                  ),
                  value: keuanganController.selectedCategory.value,
                  items: keuanganController.categories
                      .map((category) => DropdownMenuItem<String>(
                            value: category,
                            child: Text(category),
                          ))
                      .toList(),
                  onChanged: (value) {
                    keuanganController.updateCategory(value);
                  },
                );
              }),
              const SizedBox(height: 15),
              const Text('Keterangan'),
              const SizedBox(height: 7),
              TextField(
                controller: keuanganController.keteranganController,
                decoration: InputDecoration(
                  hintText: 'Deskripsi pengeluaran',
                  fillColor: Colors.grey[500],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 45, horizontal: 20),
                ),
              ),
              const SizedBox(height: 15),
              const Text('Pengeluaran'),
              const SizedBox(height: 7),
              TextField(
                controller: keuanganController.pengeluaranController,
                keyboardType: TextInputType.numberWithOptions(
                    decimal: true), // Allows decimal input
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(
                      r'^\d*\.?\d{0,2}')) // Restrict to numbers or decimals with up to 2 decimal places
                ],
                decoration: InputDecoration(
                  hintText: 'Jumlah pengeluaran',
                  fillColor: Colors.grey[500],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  if (docId != null) {
                    // If docId is not null, update data
                    keuanganController.updateKeuangan(docId!);
                  } else {
                    // If docId is null, add new data
                    keuanganController.addKeuangan();
                  }
                },
                icon: const Icon(
                  Icons.save_as_sharp,
                  color: Colors.black,
                ),
                label: const Text(
                  'Simpan',
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[400],
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 10),
                    elevation: 5),
              )
            ],
          ),
        ),
      ),
    );
  }
}
