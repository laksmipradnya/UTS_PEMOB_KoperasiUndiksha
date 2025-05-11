import 'package:flutter/material.dart';

class ButuhBantuanPage extends StatelessWidget {
  const ButuhBantuanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        title: const Text("Butuh Bantuan", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Hubungi Kami",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Card(
              child: ListTile(
                leading: const Icon(Icons.phone, color: Colors.blue),
                title: const Text("Telepon"),
                subtitle: const Text("0878-1234-1024"),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // Tambahkan fungsi panggilan jika perlu
                },
              ),
            ),
            const SizedBox(height: 10),
            Card(
              child: ListTile(
                leading: const Icon(Icons.email, color: Colors.blue),
                title: const Text("Email"),
                subtitle: const Text("support@koperasiundiksha.ac.id"),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              child: ListTile(
                leading: const Icon(Icons.location_on, color: Colors.blue),
                title: const Text("Alamat"),
                subtitle: const Text("Jl. Udayana No.11, Singaraja, Bali"),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "Jam Operasional",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text("Senin - Jumat: 08.00 - 16.00 WITA"),
            const Text("Sabtu - Minggu & Hari Libur: Tutup"),
          ],
        ),
      ),
    );
  }
}
