import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kozzzila/app/modules/home/controllers/home_controller.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Kosan"),
        backgroundColor: Colors.cyan,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Image
            Stack(
              children: [
                Image.asset(
                  'assets/image/kosan.png', // Replace with your image asset
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 10,
                  left: 16,
                  child: Text(
                    'Apps Manajemen Kost',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            // Kost Info
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Kosan Ngawi Sigma',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Icon(Icons.info, color: Colors.blue),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Pembayaran kos terakhir tanggal 28 Sep 2024',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Navigation Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavButton(
                    icon: Icons.inbox,
                    label: 'Paket',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PaketPage()),
                      );
                    },
                  ),
                  _buildNavButton(
                    icon: Icons.help_outline,
                    label: 'Barang Hilang',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BarangHilangPage()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your action here
        },
        backgroundColor: Colors.cyan,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildNavButton(
      {required IconData icon,
      required String label,
      required Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.cyan,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.all(16),
            child: Icon(icon, color: Colors.white),
          ),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class PaketPage extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Paket"),
        backgroundColor: Colors.cyan,
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.paketList.length,
          itemBuilder: (context, index) {
            final paket = controller.paketList[index];
            return Card(
              margin: EdgeInsets.all(8),
              child: ListTile(
                leading: Image.asset(
                  paket["gambar"]!,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
                title: Text(paket["nama"]!),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("No. Resi: ${paket["resi"]}"),
                    Text("Penerima: ${paket["penerima"]}"),
                    Text("Status: ${paket["status"]}"),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        _showEditDialog(context, index, true);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        controller.deletePaket(index);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showEditDialog(context, null, true);
        },
        backgroundColor: Colors.cyan,
        child: Icon(Icons.add),
      ),
    );
  }

  void _showEditDialog(BuildContext context, int? index, bool isPaket) {
    final isEditing = index != null;
    final item = isEditing
        ? controller.paketList[index!]
        : {"nama": "", "resi": "", "penerima": "", "status": "", "gambar": ""};

    final TextEditingController namaController =
        TextEditingController(text: item["nama"]);
    final TextEditingController resiController =
        TextEditingController(text: item["resi"]);
    final TextEditingController penerimaController =
        TextEditingController(text: item["penerima"]);
    final TextEditingController statusController =
        TextEditingController(text: item["status"]);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isEditing ? "Edit Paket" : "Tambah Paket"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: namaController,
              decoration: InputDecoration(labelText: "Nama Paket"),
            ),
            TextField(
              controller: resiController,
              decoration: InputDecoration(labelText: "No. Resi"),
            ),
            TextField(
              controller: penerimaController,
              decoration: InputDecoration(labelText: "Penerima"),
            ),
            TextField(
              controller: statusController,
              decoration: InputDecoration(labelText: "Status"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              final newPaket = {
                "nama": namaController.text,
                "resi": resiController.text,
                "penerima": penerimaController.text,
                "status": statusController.text,
                "gambar": "assets/image/paket.png",
              };

              if (isEditing) {
                controller.updatePaket(index!, newPaket);
              } else {
                controller.addPaket(newPaket);
              }
              Navigator.pop(context);
            },
            child: Text("Save"),
          ),
        ],
      ),
    );
  }
}


class BarangHilangPage extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Barang Hilang"),
        backgroundColor: Colors.cyan,
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.barangList.length,
          itemBuilder: (context, index) {
            final barang = controller.barangList[index];
            return Card(
              margin: EdgeInsets.all(8),
              child: ListTile(
                leading: Image.asset(
                  barang["gambar"]!,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
                title: Text(barang["nama"]!),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Pemilik: ${barang["pemilik"]}"),
                    Text("Status: ${barang["status"]}"),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        _showEditDialog(context, index, false);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        controller.deleteBarang(index);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showEditDialog(context, null, false);
        },
        backgroundColor: Colors.cyan,
        child: Icon(Icons.add),
      ),
    );
  }

  void _showEditDialog(BuildContext context, int? index, bool isPaket) {
    final isEditing = index != null;
    final item = isEditing
        ? controller.barangList[index!]
        : {"nama": "", "pemilik": "", "status": "", "gambar": ""};

    final TextEditingController namaController =
        TextEditingController(text: item["nama"]);
    final TextEditingController pemilikController =
        TextEditingController(text: item["pemilik"]);
    final TextEditingController statusController =
        TextEditingController(text: item["status"]);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isEditing ? "Edit Barang Hilang" : "Tambah Barang Hilang"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: namaController,
              decoration: InputDecoration(labelText: "Nama Barang"),
            ),
            TextField(
              controller: pemilikController,
              decoration: InputDecoration(labelText: "Pemilik"),
            ),
            TextField(
              controller: statusController,
              decoration: InputDecoration(labelText: "Status"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              final newBarang = {
                "nama": namaController.text,
                "pemilik": pemilikController.text,
                "status": statusController.text,
                "gambar": "assets/image/kunci_motor.png", // Default image or can be dynamic
              };

              if (isEditing) {
                controller.updateBarang(index!, newBarang);
              } else {
                controller.addBarang(newBarang);
              }
              Navigator.pop(context);
            },
            child: Text("Save"),
          ),
        ],
      ),
    );
  }
}
