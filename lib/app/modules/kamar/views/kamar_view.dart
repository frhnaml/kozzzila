import 'package:flutter/material.dart';  
import 'package:get/get.dart';  
import 'package:kozzzila/app/modules/kamar/views/kelola_view.dart';  
import '../controllers/kamar_controller.dart';  

class KamarView extends GetView<KamarController> {  
  const KamarView({super.key});  

  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      appBar: AppBar(  
        title: const Text('Daftar Kamar'),  
        centerTitle: true,  
        backgroundColor: Colors.cyan,  
        actions: [  
          IconButton(  
            icon: const Icon(Icons.filter_list),  
            onPressed: () {  
              // Tambahkan logika filter di sini  
            },  
          ),  
        ],  
      ),  
      body: Obx(() {  
        return ListView(  
          padding: const EdgeInsets.all(8.0),  
          children: controller.roomList.map((roomName) {  
            return _buildRoomItem(roomName);  
          }).toList(),  
        );  
      }),  
      floatingActionButton: FloatingActionButton(  
        onPressed: () {  
          _showAddRoomDialog(context);  
        },  
        backgroundColor: Colors.cyan,  
        child: const Icon(Icons.add),  
      ),  
    );  
  }  

  Widget _buildRoomItem(String roomName) {  
    return Card(  
      child: ListTile(  
        leading: const Icon(Icons.meeting_room),  
        title: Text(roomName),  
        trailing: Row(  
          mainAxisSize: MainAxisSize.min,  
          children: [  
            IconButton(  
              icon: const Icon(Icons.person),  
              onPressed: () {  
                Get.to(() => KelolaView(roomName: roomName));  
              },  
            ),  
            IconButton(  
              icon: const Icon(Icons.delete),  
              onPressed: () {  
                // Hapus kamar dan data terkait
                controller.deleteRoom(roomName);  
              },  
            ),  
          ],  
        ),  
      ),  
    );  
  }  

  void _showAddRoomDialog(BuildContext context) {  
    final TextEditingController roomNameController = TextEditingController();  

    showDialog(  
      context: context,  
      builder: (context) {  
        return AlertDialog(  
          title: const Text('Masukkan Nama Kamar'),  
          content: TextField(  
            controller: roomNameController,  
            decoration: const InputDecoration(hintText: "Nama Kamar"),  
          ),  
          actions: [  
            TextButton(  
              onPressed: () {  
                Get.back(); // Tutup dialog  
              },  
              child: const Text('Batal'),  
            ),  
            TextButton(  
              onPressed: () {  
                if (roomNameController.text.isNotEmpty) {  
                  // Tambahkan nama kamar ke daftar  
                  controller.addRoom(roomNameController.text);  
                  Get.back(); // Tutup dialog  
                }  
              },  
              child: const Text('OK'),  
            ),  
          ],  
        );  
      },  
    );  
  }  
}
