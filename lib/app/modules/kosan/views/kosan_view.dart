import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class KosanView extends StatefulWidget {
  @override
  _KosanViewState createState() => _KosanViewState();
}

class _KosanViewState extends State<KosanView> {
  List<String> rooms = [
    "Reguler 01",
    "Reguler 02",
    "Reguler 04",
    "Reguler 05",
    "Reguler 06",
    "Eksklusif 01",
    "Eksklusif 02",
    "Eksklusif 03",
    "Eksklusif 04"
  ];

  void editRoom(int index) {
    final controller = TextEditingController(text: rooms[index]);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Nama Kamar"),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: "Nama Kamar",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  rooms[index] = controller.text;
                });
                Navigator.pop(context);
              },
              child: const Text("Simpan"),
            ),
          ],
        );
      },
    );
  }

  void deleteRoom(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Hapus Kamar"),
          content: Text("Apakah Anda yakin ingin menghapus ${rooms[index]}?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  rooms.removeAt(index);
                });
                Navigator.pop(context);
              },
              child: const Text("Hapus"),
            ),
          ],
        );
      },
    );
  }

  // Add new room
  void addRoom() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Tambah Nama Kamar"),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: "Nama Kamar Baru",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  rooms.add(controller.text);
                });
                Navigator.pop(context);
              },
              child: const Text("Tambah"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kosan"),
        backgroundColor: Colors.cyan,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // Tambahkan logika untuk filter
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: rooms.length,
        itemBuilder: (context, index) {
          return Slidable(
            key: ValueKey(rooms[index]),
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) => editRoom(index),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  icon: Icons.edit,
                  label: 'Edit',
                ),
                SlidableAction(
                  onPressed: (context) => deleteRoom(index),
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
              ],
            ),
            child: KosanTile(title: rooms[index]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan,
        child: const Icon(Icons.add),
        onPressed: addRoom, // Call addRoom method when FAB is pressed
      ),
    );
  }
}

class KosanTile extends StatelessWidget {
  final String title;

  const KosanTile({required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.meeting_room),
        title: Text(title),
        trailing: IconButton(
          icon: const Icon(Icons.person),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => KelolaKosAdminView(roomTitle: title),
              ),
            );
          },
        ),
      ),
    );
  }
}

class KelolaKosAdminView extends StatelessWidget {
  final String roomTitle;

  const KelolaKosAdminView({required this.roomTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(roomTitle),
        backgroundColor: Colors.cyan,
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
            Center(
              child: CircleAvatar(
                radius: 50,
                child: IconButton(
                  icon: const Icon(Icons.camera_alt),
                  onPressed: () {
                    // Tambahkan logika untuk upload foto
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Nama",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "No. HP",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "NIK",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              title: Text("Tanggal Masuk"),
              trailing: Text("01-11-2023"),
            ),
            ListTile(
              title: Text("Jenis Kamar"),
              trailing: Text(roomTitle),
            ),
            const Divider(),
            const Text("List Pembayaran"),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    title: Text("Pembayaran Juni"),
                    trailing: Text("01-06-2023"),
                  ),
                  ListTile(
                    title: Text("Pembayaran Juli"),
                    trailing: Text("01-07-2023"),
                  ),
                  ListTile(
                    title: Text("Pembayaran Agustus"),
                    trailing: Text("01-08-2023"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
