import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:kozzzila/app/routes/app_pages.dart';

class KeuanganController extends GetxController {
  // Controller for the date field
  TextEditingController tanggalController = TextEditingController();
  var selectedCategory = Rx<String?>(null);
  TextEditingController kosanController = TextEditingController();
  TextEditingController keteranganController = TextEditingController();
  TextEditingController pengeluaranController = TextEditingController();

  List<String> categories = [
    'Makanan',
    'Transportasi',
    'Belanja',
    'Hiburan',
  ];

  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Method to open the date picker and set the selected date
  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != DateTime.now()) {
      // Format the date as "dd-MM-yyyy"
      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
      tanggalController.text = formattedDate;
    }
  }

  void updateCategory(String? newCategory) {
    selectedCategory.value = newCategory;
  }

  // CRUD: Create data
  Future<void> addKeuangan() async {
    try {
      await _firestore.collection('keuangan').add({
        'tanggal': tanggalController.text,
        'kosan': kosanController.text,
        'kategori': selectedCategory.value,
        'keterangan': keteranganController.text,
        'pengeluaran': pengeluaranController.text,
      });
      // Optionally reset fields after adding
      tanggalController.clear();
      kosanController.clear();
      keteranganController.clear();
      pengeluaranController.clear();
      selectedCategory.value = null;
      Get.snackbar('Success', 'Data saved successfully!', backgroundColor: Colors.green);
      Get.toNamed(Routes.KEUANGAN);
    } catch (e) {
      Get.snackbar('Error', 'Failed to save data: $e', backgroundColor: Colors.red);
    }
  }

  // CRUD: Update data
  Future<void> updateKeuangan(String docId) async {
    try {
      await _firestore.collection('keuangan').doc(docId).update({
        'tanggal': tanggalController.text,
        'kosan': kosanController.text,
        'kategori': selectedCategory.value,
        'keterangan': keteranganController.text,
        'pengeluaran': pengeluaranController.text,
      });
      Get.snackbar('Success', 'Data updated successfully!');
      Get.toNamed(Routes.KEUANGAN);
    } catch (e) {
      Get.snackbar('Error', 'Failed to update data: $e');
    }
  }

  // CRUD: Delete data
  Future<void> deleteKeuangan(String docId) async {
    try {
      await _firestore.collection('keuangan').doc(docId).delete();
      Get.snackbar('Success', 'Data deleted successfully!');
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete data: $e');
    }
  }

// CRUD: Read data
  Stream<List<Map<String, dynamic>>> getKeuanganData() {
    return _firestore.collection('keuangan').snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return {
          'id': doc.id,
          'tanggal': doc['tanggal'],
          'kosan': doc['kosan'],
          'kategori': doc['kategori'],
          'keterangan': doc['keterangan'],
          'pengeluaran': doc['pengeluaran'],
        };
      }).toList();
    });
  }
}
