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
    // Load data from storage
    paketList.value = List<Map<String, String>>.from(
      storage.read('paketList') ?? [],
    );
    barangList.value = List<Map<String, String>>.from(
      storage.read('barangList') ?? [],
    );
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
