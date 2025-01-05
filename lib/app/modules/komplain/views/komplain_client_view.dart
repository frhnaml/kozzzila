import 'package:flutter/material.dart';

class KomplainClientView extends StatefulWidget {
  @override
  _KomplainViewState createState() => _KomplainViewState();
}

class _KomplainViewState extends State<KomplainClientView> {
  final List<Map<String, dynamic>> komplainData = [
    {
      "name": "Riyo",
      "date": "12 Sep 2024",
      "description": "Ada Kunci Motor Ketinggalan di Parkiran",
      "status": "Tunda"
    },
    {
      "name": "Hanif",
      "date": "10 Sep 2024",
      "description": "Sinyal wifi buruk",
      "status": "Proses"
    },
    {
      "name": "Mamat",
      "date": "7 Sep 2024",
      "description": "Kasur saya rusak mas",
      "feedback": "Sudah saya perbaiki mas tadi jam 9 pagi tks",
      "status": "Selesai"
    },
  ];

  Map<String, dynamic>? selectedKomplain;

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return _buildAddKomplainDialog();
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
                    _confirmDelete(index);
                  },
                ),
              ],
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
          if (selectedKomplain!['feedback'] != null)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Feedback:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(selectedKomplain!['feedback']),
                  ),
                ],
              ),
            ),
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

  Widget _buildAddKomplainDialog() {
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
            setState(() {
              komplainData.add({
                "name": nameController.text,
                "date": DateTime.now().toString().split(' ')[0],
                "description": descriptionController.text,
                "status": "Tunda"
              });
            });
            Navigator.pop(context);
          },
          child: Text("Simpan"),
        ),
      ],
    );
  }

  void _confirmDelete(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Hapus Komplain"),
          content: Text("Apakah Anda yakin ingin menghapus komplain ini?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  komplainData.removeAt(index);
                });
                Navigator.pop(context);
              },
              child: Text("Hapus"),
            ),
          ],
        );
      },
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
