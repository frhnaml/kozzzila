import 'package:flutter/material.dart';

class KeuanganClientView extends StatelessWidget {
  final List<Map<String, String>> transactions = [
    {
      "kategori": "Listrik",
      "tanggal": "02 Nov 2022",
      "jumlah": "-Rp. 50.000.000"
    },
    {
      "kategori": "Air PDAM",
      "tanggal": "01 Nov 0001",
      "jumlah": "-Rp. 50.000.000"
    },
    {
      "kategori": "Listrik",
      "tanggal": "02 Nov 2022",
      "jumlah": "-Rp. 50.000.000"
    },
    {
      "kategori": "Air PDAM",
      "tanggal": "01 Nov 0001",
      "jumlah": "-Rp. 50.000.000"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Keuangan"),
        backgroundColor: Colors.cyan,
        actions: [
          IconButton(
            onPressed: () {
              // Tambahkan logika untuk download laporan
            },
            icon: Icon(Icons.download),
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // Tambahkan logika untuk filter
                  },
                  icon: Icon(Icons.filter_alt),
                  label: Text("30 Hari terakhir"),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.grey.shade200,
                  ),
                ),
              ],
            ),
          ),

          // Transaction List
          Expanded(
            child: ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: Icon(
                      Icons.receipt_long,
                      color: Colors.cyan,
                    ),
                    title: Text(
                      transaction["kategori"]!,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(transaction["tanggal"]!),
                    trailing: Text(
                      transaction["jumlah"]!,
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Pay Button
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Tambahkan logika untuk pembayaran
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  "Bayar",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
