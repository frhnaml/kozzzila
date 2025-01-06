import 'package:flutter/material.dart';

class KeuanganClientView extends StatefulWidget {
  @override
  _KeuanganClientViewState createState() => _KeuanganClientViewState();
}

class _KeuanganClientViewState extends State<KeuanganClientView> {
  // Daftar transaksi
  List<Map<String, dynamic>> transactions = [
    {
      "title": "Listrik",
      "date": "02 Nov 2022",
      "amount": 50000000,
      "isChecked": false
    },
    {
      "title": "Air PDAM",
      "date": "01 Nov 2022",
      "amount": 50000000,
      "isChecked": false
    },
    {
      "title": "Listrik",
      "date": "02 Nov 2022",
      "amount": 50000000,
      "isChecked": false
    },
    {
      "title": "Air PDAM",
      "date": "01 Nov 2022",
      "amount": 50000000,
      "isChecked": false
    },
  ];

  // Menghitung total transaksi yang dicentang
  int getTotalCheckedAmount() {
    return transactions
        .where((transaction) => transaction["isChecked"] == true)
        .fold<int>(0, (sum, item) => sum + (item["amount"] as int));
  }

  // Menghapus transaksi yang dicentang
  void paySelectedTransactions() {
    setState(() {
      transactions.removeWhere((transaction) => transaction["isChecked"]);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Transaksi berhasil dibayar!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Keuangan"),
        backgroundColor: Colors.cyan,
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              // Implementasi untuk download data jika diperlukan
            },
          )
        ],
      ),
      body: Column(
        children: [
          // Daftar transaksi
          Expanded(
            child: ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: Checkbox(
                      value: transaction["isChecked"],
                      onChanged: (value) {
                        setState(() {
                          transaction["isChecked"] = value!;
                        });
                      },
                    ),
                    title: Text(transaction["title"]),
                    subtitle: Text(transaction["date"]),
                    trailing: Text(
                      "-Rp. ${transaction["amount"].toString()}",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                );
              },
            ),
          ),
          // Total jumlah yang dicentang
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total: Rp. ${getTotalCheckedAmount()}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (transactions
                        .any((transaction) => transaction["isChecked"])) {
                      paySelectedTransactions();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text("Pilih transaksi terlebih dahulu!")),
                      );
                    }
                  },
                  child: Text("Bayar"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyan,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
