import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:kozzzila/app/modules/keuangan/views/create_keuanganView.dart';

import '../controllers/keuangan_controller.dart';

class KeuanganView extends GetView<KeuanganController> {
  const KeuanganView({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Financial Summary Container
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pemasukan',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 15),
                        Text(
                          '-',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Pengeluaran',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 15),
                        Text(
                          '-Rp. 51.00.000.00',
                          style: TextStyle(fontSize: 14, color: Colors.red),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Title for Transactions
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Transaksi'),
                  SizedBox(width: 140),
                  Row(
                    children: [
                      Text('30 Hari terakhir'),
                      SizedBox(width: 10),
                      Icon(
                        Icons.check_circle,
                        size: 19,
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(height: 20),

              // StreamBuilder to listen for updates from Firestore
              Expanded(
                child: StreamBuilder<List<Map<String, dynamic>>>(
                  stream: controller.getKeuanganData(), // Get the data stream
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No data available'));
                    }

                    var keuanganData = snapshot.data!;

                    return ListView.builder(
                      itemCount: keuanganData.length,
                      itemBuilder: (context, index) {
                        var item = keuanganData[index];

                        return Slidable(
                          startActionPane: ActionPane(
                            motion: const DrawerMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                  // Handle delete action
                                  controller.deleteKeuangan(item['id']);
                                },
                                backgroundColor: Colors.transparent,
                                foregroundColor: Colors.red,
                                icon: Icons.delete,
                              ),
                              SlidableAction(
                                onPressed: (context) {
                                  // Implement Edit
                                  Get.to(CreateKeuanganview(
                                    docId: item['id'],
                                    existingData: item,
                                  ));
                                },
                                backgroundColor: Colors.transparent,
                                foregroundColor: Colors.black,
                                icon: Icons.edit_square,
                              ),
                            ],
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 25, horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['kategori'] ?? 'Category',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 15),
                                    Text(
                                      item['tanggal'] ?? 'Tanggal',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Pengeluaran',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 15),
                                    Text(
                                      'Rp. ${item['pengeluaran'] ?? '0.00'}',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.red),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to CreateKeuanganView
          Get.to(CreateKeuanganview());
        },
        backgroundColor: Colors.lightBlue[200],
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
