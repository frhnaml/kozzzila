import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class KomplainView extends StatefulWidget {
  @override
  _KomplainViewState createState() => _KomplainViewState();
}

class _KomplainViewState extends State<KomplainView> {
  List<Map<String, dynamic>> komplainData = [];
  Map<String, dynamic>? selectedKomplain;

  @override
  void initState() {
    super.initState();
    _loadKomplainData();
  }

  // Load data from GetStorage
  _loadKomplainData() {
    final box = GetStorage();
    List<dynamic> storedData = box.read('komplainData') ?? [];
    setState(() {
      komplainData = storedData.map((e) => Map<String, dynamic>.from(e)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Komplain'),
        backgroundColor: Colors.cyan,
        leading: selectedKomplain != null
            ? IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
                    selectedKomplain = null;
                  });
                },
              )
            : null,
      ),
      body: selectedKomplain == null
          ? _buildKomplainList()
          : _buildKomplainDetail(),
    );
  }

  Widget _buildKomplainList() {
    return ListView.builder(
      itemCount: komplainData.length,
      itemBuilder: (context, index) {
        final item = komplainData[index];
        return Card(
          margin: EdgeInsets.all(8),
          child: ListTile(
            title: Text(item['name']),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Tanggal: ${item['date']}'),
                Text('Deskripsi: ${item['description']}'),
                Text('Feedback: ${item['feedback'] ?? "-"}'),
              ],
            ),
            trailing: Container(
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
            onTap: () {
              setState(() {
                selectedKomplain = item;
              });
            },
          ),
        );
      },
    );
  }

  Widget _buildKomplainDetail() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Nama: ${selectedKomplain!['name']}'),
          Text('Tanggal: ${selectedKomplain!['date']}'),
          Text('Deskripsi: ${selectedKomplain!['description']}'),
          SizedBox(height: 16),
          Text(
            'Status:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _getStatusColor(selectedKomplain!['status']),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              selectedKomplain!['status'],
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Feedback:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              selectedKomplain!['feedback'] ?? '-',
              style: TextStyle(color: Colors.black),
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    selectedKomplain = null;
                  });
                },
                child: Text('Kembali'),
              ),
            ],
          ),
        ],
      ),
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
