import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kozzzila/app/modules/komplain/controllers/komplain_controller.dart';

class KomplainClientView extends StatefulWidget {
  @override
  _KomplainClientViewState createState() => _KomplainClientViewState();
}

class _KomplainClientViewState extends State<KomplainClientView> {
  final KomplainController komplainController = Get.put(KomplainController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Komplain'),
        backgroundColor: Colors.cyan,
      ),
      body: Obx(() {
        return komplainController.komplainData.isEmpty
            ? Center(child: Text("No complaints available"))
            : _buildKomplainList();
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context, // Now you can use context directly
            builder: (context) {
              return _buildAddKomplainDialog(context); // Pass context here
            },
          );
        },
        backgroundColor: Colors.cyan,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildKomplainList() {
    return ListView.builder(
      itemCount: komplainController.komplainData.length,
      itemBuilder: (context, index) {
        final item = komplainController.komplainData[index];
        return Card(
          margin: EdgeInsets.all(8),
          child: ListTile(
            title: Text(item['name']),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Tanggal: ${item['date']}'),
                Text('Deskripsi: ${item['description']}'),
                if (item['feedback'] != null)
                  Text('Feedback: ${item['feedback']}'),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: _getStatusColor(item['status']),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    item['status'],
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    komplainController.deleteKomplain(index);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAddKomplainDialog(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    return AlertDialog(
      title: Text("Tambah Komplain"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: "Nama"),
          ),
          SizedBox(height: 8),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(labelText: "Deskripsi"),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Batal"),
        ),
        ElevatedButton(
          onPressed: () {
            komplainController.addKomplain(
              nameController.text,
              descriptionController.text,
            );
            Navigator.pop(context);
          },
          child: Text("Simpan"),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Tunda':
        return Colors.grey;
      case 'Proses':
        return Colors.blue;
      case 'Selesai':
        return Colors.green;
      default:
        return Colors.black;
    }
  }
}
