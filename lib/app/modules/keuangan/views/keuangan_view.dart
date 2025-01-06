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
                  Map<String, dynamic> transaksi = controller.transaksiList[index]; // Explicitly declare the type here
                  return transaksiItem(
                      context,
                      transaksi['nama'],
                      transaksi['tanggal'],
                      transaksi['jumlah'],
                      controller,
                      index,
                      transaksi // Pass the whole transaksi data
                  );
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
      KeuanganClientController controller, int index, Map<String, dynamic> transaksi) {
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
                  // Pass the current transaksi data for editing
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TambahPengeluaranView(
                        transaksi: transaksi, // Pass the full transaksi data
                        index: index, // Pass the index
                      ),
                    ),
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
  final Map<String, dynamic>? transaksi;
  final int? index;

  const TambahPengeluaranView({Key? key, this.transaksi, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final KeuanganClientController controller = Get.find();

    TextEditingController namaController = TextEditingController();
    TextEditingController jumlahController = TextEditingController();
    DateTime? selectedDate = DateTime.now();
    int? selectedKosan;

    // If editing, populate fields with current data
    if (transaksi != null) {
      namaController.text = transaksi!['nama'];
      jumlahController.text = transaksi!['jumlah'].toString();
      selectedDate = DateTime.parse(transaksi!['tanggal']);
      selectedKosan = int.parse(transaksi!['nama'].split(' ')[1]);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(transaksi == null ? "Tambah Pengeluaran" : "Edit Pengeluaran"),
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
            // Date Picker for Tanggal
            GestureDetector(
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: selectedDate!,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null && pickedDate != selectedDate) {
                  selectedDate = pickedDate;
                }
              },
              child: AbsorbPointer(
                child: TextField(
                  controller: TextEditingController(
                      text: "${selectedDate?.toLocal()}".split(' ')[0]),
                  decoration: const InputDecoration(
                    labelText: "Tanggal",
                    hintText: "Pick a date",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Dropdown for Kosan
            DropdownButtonFormField<int>(
              value: selectedKosan,
              hint: const Text("Pilih Kosan"),
              onChanged: (int? newValue) {
                selectedKosan = newValue;
              },
              items: List.generate(5, (index) {
                return DropdownMenuItem<int>(
                  value: index + 1,
                  child: Text("Kosan ${index + 1}"),
                );
              }),
              decoration: const InputDecoration(
                labelText: "Kosan",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // TextField for Jumlah Pengeluaran
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

            // Save Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (selectedKosan != null && selectedDate != null) {
                    Map<String, dynamic> transaksiData = {
                      'nama': "Kosan ${selectedKosan}",
                      'tanggal': "${selectedDate?.toLocal()}".split(' ')[0],
                      'jumlah': int.parse(jumlahController.text),
                    };

                    if (transaksi == null) {
                      // Add new transaksi if no data is passed
                      controller.addTransaksi(transaksiData);
                    } else {
                      // Update existing transaksi if data is passed
                      controller.updateTransaksi(index!, transaksiData);
                    }
                    Navigator.pop(context);
                  } else {
                    // You can add validation to show an error message
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                child: Text(transaksi == null ? "Simpan" : "Update"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
