import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  final storage = GetStorage();

  // Observable lists for data
  var paketList = <Map<String, String>>[].obs;
  var barangList = <Map<String, String>>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Load data from storage and ensure correct types
    final storedPaketList = storage.read('paketList');
    final storedBarangList = storage.read('barangList');

    // Safely cast data to List<Map<String, String>> and handle null or incorrect types
    if (storedPaketList != null) {
      // Ensure it's a List<Map<String, String>>
      paketList.value = List<Map<String, String>>.from(storedPaketList.map((item) {
        return Map<String, String>.from(item as Map); // Cast each item to Map<String, String>
      }));
    } else {
      paketList.value = [];
    }

    if (storedBarangList != null) {
      // Ensure it's a List<Map<String, String>>
      barangList.value = List<Map<String, String>>.from(storedBarangList.map((item) {
        return Map<String, String>.from(item as Map); // Cast each item to Map<String, String>
      }));
    } else {
      barangList.value = [];
    }
  }

  // Save data to storage
  void saveData() {
    storage.write('paketList', paketList);
    storage.write('barangList', barangList);
  }

  // CRUD methods for Paket
  void addPaket(Map<String, String> paket) {
    paketList.add(paket);
    saveData();
  }

  void updatePaket(int index, Map<String, String> paket) {
    paketList[index] = paket;
    saveData();
  }

  void deletePaket(int index) {
    paketList.removeAt(index);
    saveData();
  }

  // CRUD methods for Barang Hilang
  void addBarang(Map<String, String> barang) {
    barangList.add(barang);
    saveData();
  }

  void updateBarang(int index, Map<String, String> barang) {
    barangList[index] = barang;
    saveData();
  }

  void deleteBarang(int index) {
    barangList.removeAt(index);
    saveData();
  }
}
