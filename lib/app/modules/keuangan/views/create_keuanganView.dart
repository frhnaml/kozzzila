import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/keuangan_controller.dart';

class CreateKeuanganview extends StatelessWidget {
  final bool isEdit;
  final String? documentId;
  final String? tanggal;
  final String? kosan;
  final String? kategori;
  final String? keterangan;
  final String? jumlahPengeluaran;

  CreateKeuanganview({
    super.key,
    required this.isEdit,
    this.documentId = '',
    this.tanggal = '',
    this.kosan = '',
    this.kategori = '',
    this.keterangan = '',
    this.jumlahPengeluaran = '',
  });

  final KeuanganController controller = Get.put(KeuanganController());

  @override
  Widget build(BuildContext context) {
    controller.initForm(
      isEdit: isEdit,
      tanggal: tanggal,
      kosan: kosan,
      kategori: kategori,
      keterangan: keterangan,
      jumlahPengeluaran: jumlahPengeluaran,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Keuangan' : 'Create New Keuangan'),
        backgroundColor: Colors.blue[200], // You can adjust the color as needed
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildWidgetFormPrimary(context),
                    const SizedBox(height: 16.0),
                    _buildWidgetFormSecondary(context),
                    const SizedBox(height: 16.0),
                    Obx(() => controller.isLoading.value
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : _buildWidgetButtonCreateTask()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWidgetFormPrimary(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 16.0),
          TextField(
            controller: controller.controllertanggal,
            decoration: InputDecoration(
                labelText: 'Date',
                hintText: '01-11-2111',
                suffixIcon: const Icon(Icons.event),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
            style: const TextStyle(fontSize: 18.0),
            readOnly: true,
            onTap: () => controller.selecDate(context),
          ),
        ],
      ),
    );
  }

  Widget _buildWidgetFormSecondary(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        children: <Widget>[
          TextField(
            controller: controller.controllerkosan,
            decoration: InputDecoration(
                labelText: 'Kosan',
                suffixIcon: const Icon(Icons.description),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
            style: const TextStyle(fontSize: 18.0),
          ),
          const SizedBox(height: 16.0),
          TextField(
            controller: controller.controllerkategori,
            decoration: InputDecoration(
                labelText: 'Kategori',
                suffixIcon: const Icon(Icons.category),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
            style: const TextStyle(fontSize: 18.0),
          ),
          const SizedBox(height: 16.0),
          TextField(
            controller: controller.controllerketerangan,
            decoration: InputDecoration(
                labelText: 'Keterangan',
                suffixIcon: const Icon(Icons.description_rounded),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
            style: const TextStyle(fontSize: 18.0),
          ),
          const SizedBox(height: 16.0),
          TextField(
            controller: controller.controllerjumlahPengeluaran,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                labelText: 'Jumlah pengeluaran',
                suffixIcon: const Icon(Icons.money_rounded),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
            style: const TextStyle(fontSize: 18.0),
          ),
        ],
      ),
    );
  }

  Widget _buildWidgetButtonCreateTask() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue[200],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          isEdit ? 'UPDATE TASK' : 'Simpan',
          style: TextStyle(
            color: Colors.grey[100],
          ),
        ),
        onPressed: () => controller.saveTask(isEdit, documentId),
      ),
    );
  }
}
