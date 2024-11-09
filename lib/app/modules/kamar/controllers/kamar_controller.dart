import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class KamarController extends GetxController {
  var selectedImagePath = ''.obs;
  var dateController = TextEditingController();
  var nameController = TextEditingController(); // Nama
  var phoneController = TextEditingController(); // No. HP
  var nikController = TextEditingController(); // NIK
  var roomTypeController = TextEditingController(); // Jenis Kamar
  var payments = [].obs; // List of payment dates
  var roomList = <String>[].obs; // Daftar kamar
  var currentRoom = ''.obs; // Kamar yang sedang dipilih

  // Fungsi untuk memilih kamar dan memuat data kamar tersebut
  void selectRoom(String roomName) {
    currentRoom.value = roomName; // Set kamar yang dipilih
    loadDataForRoom(roomName); // Muat data untuk kamar yang dipilih
  }

  void resetController() {
    // Reset data controller atau set default untuk setiap kamar baru
    nameController.text = '';
    phoneController.text = '';
    nikController.text = '';
    roomTypeController.text = '';
    payments.clear();
    selectedImagePath.value = '';
  }

  // Fungsi untuk menyimpan data ke GetStorage untuk kamar tertentu
  Future<void> saveData(String roomKey) async {
    final box = GetStorage();

    // Menyimpan data seperti nama, no HP, NIK, dll untuk kamar tertentu
    await box.write('${roomKey}_selectedImagePath', selectedImagePath.value);
    await box.write('${roomKey}_date', dateController.text);
    await box.write('${roomKey}_name', nameController.text); // Simpan Nama
    await box.write('${roomKey}_phone', phoneController.text); // Simpan No. HP
    await box.write('${roomKey}_nik', nikController.text); // Simpan NIK
    await box.write('${roomKey}_roomType', roomTypeController.text); // Simpan Jenis Kamar
    await box.write('${roomKey}_payments', payments.map((payment) => payment['date'].toString()).toList());
    await box.write('roomList', roomList); // Simpan daftar kamar
  }

  // Fungsi untuk menghapus data dari GetStorage untuk kamar tertentu
  Future<void> clearData(String roomKey) async {
    final box = GetStorage();

    await box.remove('${roomKey}_selectedImagePath');
    await box.remove('${roomKey}_date');
    await box.remove('${roomKey}_name');
    await box.remove('${roomKey}_phone');
    await box.remove('${roomKey}_nik');
    await box.remove('${roomKey}_roomType');
    await box.remove('${roomKey}_payments');

    resetController();
  }


  // Fungsi untuk menghapus kamar dan data terkait
  void deleteRoom(String roomName) async {
  final box = GetStorage();
  
  // Menghapus data terkait kamar yang dipilih
  await box.remove('${roomName}_selectedImagePath');
  await box.remove('${roomName}_date');
  await box.remove('${roomName}_name');
  await box.remove('${roomName}_phone');
  await box.remove('${roomName}_nik');
  await box.remove('${roomName}_roomType');
  await box.remove('${roomName}_payments');
  
  // Menghapus nama kamar dari daftar kamar
  roomList.remove(roomName);
}


  // Fungsi untuk menambah pembayaran
  void addPayment() {
    payments.add({'date': DateTime.now().toString()});
  }

  // Fungsi untuk menghapus pembayaran
  void removePayment(int index) {
    payments.removeAt(index);
  }

  // Fungsi untuk menambah kamar
  void addRoom(String roomName) {
    roomList.add(roomName);
  }

  @override
  void onInit() async {
    super.onInit();
    // Pastikan GetStorage sudah diinisialisasi
    await GetStorage.init();
    // Memuat data yang tersimpan saat aplikasi dimulai
    loadDataForRoom(currentRoom.value);
  }

  // Fungsi untuk memuat data dari GetStorage untuk kamar tertentu
  Future<void> loadDataForRoom(String roomKey) async {
    final box = GetStorage();

    // Memuat data dari storage, jika tidak ada maka set default
    selectedImagePath.value = box.read('${roomKey}_selectedImagePath') ?? '';
    dateController.text = box.read('${roomKey}_date') ?? '';
    nameController.text = box.read('${roomKey}_name') ?? ''; // Memuat Nama
    phoneController.text = box.read('${roomKey}_phone') ?? ''; // Memuat No. HP
    nikController.text = box.read('${roomKey}_nik') ?? ''; // Memuat NIK
    roomTypeController.text = box.read('${roomKey}_roomType') ?? ''; // Memuat Jenis Kamar

    List<String> paymentDates = box.read('${roomKey}_payments') ?? [];
    payments.value = paymentDates.map((date) => {'date': date}).toList();

    // Memuat daftar kamar
    List<String> savedRoomList = box.read('roomList') ?? [];
    roomList.value = savedRoomList;
  }
}
