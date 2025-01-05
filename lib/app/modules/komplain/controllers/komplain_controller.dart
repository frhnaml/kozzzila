import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class KomplainController extends GetxController {
  final GetStorage box = GetStorage();

  // Observable list to hold complaint data
  var komplainData = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Load the complaints data from storage when the controller is initialized
    _loadComplaints();
  }

  // Add new complaint and save to GetStorage
  void addKomplain(String name, String description) {
    var newComplaint = {
      "name": name,
      "date": DateTime.now().toString().split(' ')[0],
      "description": description,
      "status": "Tunda"
    };
    komplainData.add(newComplaint);
    _saveComplaints(); // Save to GetStorage after adding
  }

  // Update complaint status
  void updateStatus(int index, String status) {
    komplainData[index]['status'] = status;
    komplainData.refresh(); // Refresh the list after update
    _saveComplaints(); // Save to GetStorage after updating
  }

  // Delete a complaint
  void deleteKomplain(int index) {
    komplainData.removeAt(index);
    _saveComplaints(); // Save to GetStorage after deleting
  }

  // Save the complaints list to GetStorage
  void _saveComplaints() {
    box.write('komplainData', komplainData);
  }

  // Load complaints list from GetStorage
  void _loadComplaints() {
    if (box.read('komplainData') != null) {
      komplainData.assignAll(List<Map<String, dynamic>>.from(box.read('komplainData')));
    }
  }
}
