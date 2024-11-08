import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class KeuanganController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final TextEditingController controllertanggal = TextEditingController();
  final TextEditingController controllerkosan = TextEditingController();
  final TextEditingController controllerkategori = TextEditingController();
  final TextEditingController controllerketerangan = TextEditingController();
  final TextEditingController controllerjumlahPengeluaran =
      TextEditingController();

  var isLoading = false.obs;
  var date = DateTime.now().obs;
  var keuanganList = <Map<String, dynamic>>[].obs; // Define the keuanganList

  void fetchKeuangan() {
    firestore.collection('keuangan').snapshots().listen((snapshot) {
      keuanganList.value = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    });
  }

  Future<void> deleteKeuangan(String documentId) async {
    try {
      await firestore.collection('keuangan').doc(documentId).delete();
    } catch (e) {
      _showSnackBarMessage('Failed to delete item');
    }
  }

  void initForm({
    bool isEdit = false,
    String? tanggal,
    String? kosan,
    String? kategori,
    String? keterangan,
    String? jumlahPengeluaran,
  }) {
    if (isEdit) {
      date.value = DateFormat('dd MMMM yyyy').parse(tanggal ?? '');
      controllertanggal.text = tanggal ?? '';
      controllerkosan.text = kosan ?? '';
      controllerkategori.text = kategori ?? '';
      controllerketerangan.text = keterangan ?? '';
      controllerjumlahPengeluaran.text = jumlahPengeluaran ?? '';
    } else {
      controllertanggal.clear();
      controllerkosan.clear();
      controllerkategori.clear();
      controllerketerangan.clear();
      controllerjumlahPengeluaran.clear();
    }
  }

  void selecDate(BuildContext context) async {
    DateTime today = DateTime.now();
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: date.value,
      firstDate: today,
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      date.value = pickedDate;
      controllertanggal.text = DateFormat('dd MMMM yyyy').format(date.value);
    }
  }

Future<void> saveTask(bool isEdit, String? documentId) async {
  String tanggal = controllertanggal.text.trim();
  String kosan = controllerkosan.text.trim();
  String kategori = controllerkategori.text.trim();
  String keterangan = controllerketerangan.text.trim();
  String jumlahPengeluaran = controllerjumlahPengeluaran.text.trim();

  // Check if all fields are filled
  if (tanggal.isEmpty ||
      kosan.isEmpty ||
      kategori.isEmpty ||
      keterangan.isEmpty ||
      jumlahPengeluaran.isEmpty) {
    _showSnackBarMessage('All fields are required');
    return;
  }

  isLoading.value = true;

  try {
    if (isEdit) {
      // Editing an existing document
      if (documentId == null) {
        _showSnackBarMessage('Document ID cannot be null during edit');
        return;
      }

      DocumentReference documentTask = firestore.doc('keuangan/$documentId');
      await documentTask.update({
        'tanggal': tanggal,
        'kosan': kosan,
        'keterangan': keterangan,
        'kategori': kategori,
        'jumlah_pengeluaran': jumlahPengeluaran,
      });

      _showSnackBarMessage('Task updated successfully');
    } else {
      // Creating a new document
      await firestore.collection('keuangan').add({
        'tanggal': tanggal,
        'kosan': kosan,
        'keterangan': keterangan,
        'kategori': kategori,
        'jumlah_pengeluaran': jumlahPengeluaran,
      });

      // Reset form after adding a new task
      resetForm();
      _showSnackBarMessage('Task created successfully');
    }

    // Close the form page and signal that an update has been made
    Get.back(result: true);
  } catch (e) {
    _showSnackBarMessage('Error saving task: $e');
  } finally {
    isLoading.value = false;
  }
}




  void resetForm() {
    controllertanggal.clear();
    controllerkosan.clear();
    controllerkategori.clear();
    controllerketerangan.clear();
    controllerjumlahPengeluaran.clear();
    date.value = DateTime.now(); // Reset the date to the current date
  }

  void _showSnackBarMessage(String message) {
    Get.snackbar("Error", message,
        snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
  }
}
