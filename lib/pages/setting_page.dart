import 'package:flutter/material.dart';
import 'package:layout2/pages/bahasa_page.dart';
import 'package:layout2/pages/ganti_password_page.dart';
import 'package:layout2/pages/login_page.dart'; // Tambahkan ini

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
        backgroundColor: Colors.blue[900],
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20),

          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text("Ganti Password"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const GantiPasswordPage()),
              );
            },
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text("Notifikasi"),
            trailing: Switch(
              value: true,
              onChanged: (val) {
                // Aktif/nonaktifkan notifikasi
              },
            ),
          ),

          ListTile(
            leading: const Icon(Icons.language),
            title: const Text("Bahasa"),
            trailing: const Text("Indonesia"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BahasaPage()),
              );
            },
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Keluar"),
            onTap: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => AlertDialog(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  title: const Text("Keluar"),
                  content: const Text("Apakah Anda yakin ingin keluar?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Batal", style: TextStyle(color: const Color.fromARGB(255, 10, 21, 179))),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 168, 189, 245),
                        foregroundColor: const Color.fromARGB(255, 10, 21, 179),
                      ),
                      onPressed: () {
                        // Navigasi ke LoginPage dan hapus semua route sebelumnya
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => LoginPage()),
                          (Route<dynamic> route) => false,
                        );
                      },
                      child: const Text("Ya"),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}