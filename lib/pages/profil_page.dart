import 'package:flutter/material.dart';

void main() {
  runApp(KoperasiApp());
}

class KoperasiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profil Koperasi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProfilPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ProfilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFEF8FF),
      appBar: AppBar(
        backgroundColor: Colors.blue[900], // HEADER BIRU
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Foto & Nama
            Row(
              children: [
                CircleAvatar(
                  radius: 45,
                  backgroundImage: AssetImage('assets/profile.jpg'),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ni Made Laksmi Mas Pradnyadewi',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text('No. Anggota: 123456789'),
                      Text('Status: Aktif', style: TextStyle(color: Colors.green)),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),

            // Informasi Pribadi
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Informasi Pribadi",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text("Alamat: Jl. Bekisar No. 28"),
                  Text("Telepon: 08155667788"),
                  Text("Email: laksmi@gmail.com"),
                ],
              ),
            ),

            SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EditProfilePage()),
                );
              },
              icon: Icon(Icons.edit, color: const Color.fromARGB(255, 39, 62, 176)),
              label: Text("Edit Profil", style: TextStyle(color: const Color.fromARGB(255, 39, 48, 176))),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFF0EDF4),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController nameController = TextEditingController(text: "Ni Made Laksmi Mas Pradnyadewi");
  final TextEditingController alamatController = TextEditingController(text: "Jl. Bekisar No. 28");
  final TextEditingController teleponController = TextEditingController(text: "08155667788");
  final TextEditingController emailController = TextEditingController(text: "laksmi@gmail.com");

  void _saveProfile() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Profil berhasil diperbarui."),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.pop(context); // kembali ke halaman sebelumnya
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 254, 254, 255),
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Text('Edit Profil', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Nama Lengkap",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: alamatController,
              decoration: const InputDecoration(
                labelText: "Alamat",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: teleponController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: "Telepon",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: _saveProfile,
              icon: Icon(Icons.save, color: const Color.fromARGB(255, 249, 250, 251)),
              label: const Text("Simpan"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade800,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

