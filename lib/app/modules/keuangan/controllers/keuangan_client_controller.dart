import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class KeuanganClientController extends GetxController {
  final GetStorage _box = GetStorage();
  var transaksiList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadTransaksi();
  }

  // Load transaksi data from GetStorage
  void _loadTransaksi() {
    final List storedTransaksi = _box.read('transaksiList') ?? [];
    transaksiList.value = List<Map<String, dynamic>>.from(storedTransaksi);
  }

  // Add a new transaksi
  void addTransaksi(Map<String, dynamic> transaksi) {
    transaksiList.add(transaksi);
    _saveTransaksi();
  }

  // Update an existing transaksi
  void updateTransaksi(int index, Map<String, dynamic> transaksi) {
    transaksiList[index] = transaksi;
    _saveTransaksi();
  }

  // Delete a transaksi
  void deleteTransaksi(int index) {
    transaksiList.removeAt(index);
    _saveTransaksi();
  }

  // Save transaksi list to GetStorage
  void _saveTransaksi() {
    _box.write('transaksiList', transaksiList);
  }
}
