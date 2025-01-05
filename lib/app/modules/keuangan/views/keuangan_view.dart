import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kozzzila/app/modules/keuangan/controllers/keuangan_client_controller.dart';

class KeuanganView extends StatelessWidget {
  const KeuanganView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final KeuanganClientController controller = Get.put(KeuanganClientController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Keuangan'),
        backgroundColor: Colors.lightBlue,
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {
              // Implementasi tombol download
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Header pemasukan & pengeluaran
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Pemasukan",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text("-"),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Pengeluaran",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "-Rp. 51.000.000,00",
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Filter Transaksi
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Transaksi",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                DropdownButton<String>(
                  value: "30 Hari terakhir",
                  items: const [
                    DropdownMenuItem(
                        value: "30 Hari terakhir",
                        child: Text("30 Hari terakhir")),
                    DropdownMenuItem(
                        value: "Semua waktu", child: Text("Semua waktu")),
                  ],
                  onChanged: (value) {
                    // Implementasi filter
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // List Transaksi
          Expanded(
            child: Obx(() {
              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: controller.transaksiList.length,
                itemBuilder: (context, index) {
                  var transaksi = controller.transaksiList[index];
                  return transaksiItem(
                      context,
                      transaksi['nama'],
                      transaksi['tanggal'],
                      transaksi['jumlah'],
                      controller,
                      index);
                },
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const TambahPengeluaranView()),
          );
        },
        backgroundColor: Colors.lightBlue,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget transaksiItem(
      BuildContext context, String nama, String tanggal, int jumlah, 
      KeuanganClientController controller, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          leading: const Icon(Icons.receipt_long, color: Colors.lightBlue),
          title: Text(nama),
          subtitle: Text(tanggal),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                jumlah < 0
                    ? "-Rp. ${jumlah.abs().toStringAsFixed(0)}"
                    : "Rp. ${jumlah.toStringAsFixed(0)}",
                style: TextStyle(color: jumlah < 0 ? Colors.red : Colors.green),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.blue),
                onPressed: () {
                  // Implementasi Edit
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TambahPengeluaranView()),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  controller.deleteTransaksi(index);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class TambahPengeluaranView extends StatelessWidget {
  const TambahPengeluaranView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final KeuanganClientController controller = Get.find();

    TextEditingController namaController = TextEditingController();
    TextEditingController tanggalController = TextEditingController();
    TextEditingController jumlahController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Pengeluaran"),
        backgroundColor: Colors.lightBlue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: tanggalController,
              decoration: const InputDecoration(
                labelText: "Tanggal",
                hintText: "01-01-2022",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: namaController,
              decoration: const InputDecoration(
                labelText: "Kosan",
                hintText: "Kosan 1",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: jumlahController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Jumlah Pengeluaran",
                hintText: "Rp. 0",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Map<String, dynamic> transaksi = {
                    'nama': namaController.text,
                    'tanggal': tanggalController.text,
                    'jumlah': int.parse(jumlahController.text),
                  };

                  controller.addTransaksi(transaksi);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                child: const Text("Simpan"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}