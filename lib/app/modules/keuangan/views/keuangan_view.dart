import 'package:flutter/material.dart';

class KeuanganView extends StatelessWidget {
  const KeuanganView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: [
                transaksiItem(context, "Listrik", "02 Nov 0022", -50000000),
                transaksiItem(context, "Air PDAM", "01 Nov 0001", -50000000),
                transaksiItem(context, "Listrik", "01 Nov 0022", -50000000),
                transaksiItem(context, "Air PDAM", "01 Nov 0001", -50000000),
              ],
            ),
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
      BuildContext context, String nama, String tanggal, int jumlah) {
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
                  // Implementasi Hapus
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
              decoration: const InputDecoration(
                labelText: "Tanggal",
                hintText: "01-01-2022",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: "Kosan",
                hintText: "Kosan 1",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              items: const [
                DropdownMenuItem(value: "Listrik", child: Text("Listrik")),
                DropdownMenuItem(value: "Air PDAM", child: Text("Air PDAM")),
              ],
              onChanged: (value) {
                // Pilihan kategori
              },
              decoration: const InputDecoration(
                labelText: "Kategori",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: "Keterangan",
                hintText: "Keterangan tambahan",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
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
                  // Implementasi Simpan
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
