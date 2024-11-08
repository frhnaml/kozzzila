import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:kozzzila/app/modules/keuangan/views/create_keuanganView.dart';

import '../controllers/keuangan_controller.dart';

class KeuanganView extends GetView<KeuanganController> {
  KeuanganView({super.key});
  final KeuanganController controller = Get.put(KeuanganController());

  @override
  Widget build(BuildContext context) {
    controller.fetchKeuangan(); // Start listening for changes

    return Scaffold(
      appBar: AppBar(
        title: const Text('KeuanganView', textAlign: TextAlign.start),
        backgroundColor: Colors.lightBlue[200],
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.download, color: Colors.black, weight: 2),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            return SlidableAutoCloseBehavior(
              child: ListView.builder(
                itemCount: controller.keuanganList.length,
                itemBuilder: (context, index) {
                  var item = controller.keuanganList[index];
                  return Slidable(
                    key: ValueKey(item['tanggal']),
                    endActionPane: ActionPane(
                      motion: const DrawerMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            // Navigate to the edit view with the current item data
                            Get.to(() => CreateKeuanganview(
                                  isEdit: true,
                                  documentId: item['id'] ?? '',
                                  tanggal: item['tanggal'] ?? '',
                                  kosan: item['kosan'] ?? '',
                                  kategori: item['kategori'] ?? '',
                                  keterangan: item['keterangan'] ?? '',
                                  jumlahPengeluaran:
                                      item['jumlah pengeluaran'] ?? '',
                                ));
                          },
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          icon: Icons.edit,
                          label: 'Edit',
                        ),
                        SlidableAction(
                          onPressed: (context) {
                            controller.deleteKeuangan(item['id']);
                            showDeleteConfirmationDialog(context, item['id']);
                          },
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                      ],
                    ),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item['kategori'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              Text(item['kosan'],
                                  style: const TextStyle(color: Colors.grey)),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('Rp. ${item['jumlah pengeluaran']}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              Text('Date: ${item['tanggal']}',
                                  style: const TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ClipOval(
                child: Material(
                  color: Colors.cyanAccent[100],
                  child: InkWell(
                    splashColor: Colors.orange,
                    onTap: () {
                      // Navigate to create new task view
                      Get.to(() => CreateKeuanganview(isEdit: false));
                    },
                    child: const SizedBox(
                        width: 60, height: 60, child: Icon(Icons.add)),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showDeleteConfirmationDialog(BuildContext context, String documentId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirm Delete'),
        content: const Text('Are you sure you want to delete this item?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              controller.deleteKeuangan(documentId);
              Get.back(); // Close the dialog
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      );
    },
  );
}

}
