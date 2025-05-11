import 'package:flutter/material.dart';
import '../widgets/grid_menu.dart';
import '../widgets/bottom_menu.dart';
import '../pages/transfer_page.dart';
import '../pages/mutasi_page.dart';
import '../pages/pinjaman_page.dart';
import '../pages/deposito_page.dart';
import '../pages/pembayaran_page.dart';
import 'package:provider/provider.dart';
import '../providers/saldo_notifier.dart'; 
import 'package:layout2/pages/profil_page.dart';
import 'package:layout2/pages/setting_page.dart';


class KoperasiPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 254, 254, 254),
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text(
          'Koperasi Undiksha',
          style: TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          // Informasi Nasabah
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: NasabahInfo(),
          ),
          SizedBox(height: 20),
          // Grid Menu Utama
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: GridMenu(),
          ),
          SizedBox(height: 20),
          // Bantuan
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: BantuanInfo(),
          ),
          Spacer(),
          // Menu Bawah
          BottomMenu(),
        ],
      ),
    );
  }
}

class NasabahInfo extends StatelessWidget {
  const NasabahInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SaldoNotifier>(
      builder: (context, saldoNotifier, _) {
        final double saldo = saldoNotifier.saldo;

        final String formattedSaldo = saldo
            .toStringAsFixed(0)
            .replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (match) => '${match[1]}.');

        return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
              ),
            ],
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/profile.jpg',
                  width: 90,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 209, 229, 245),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Nasabah',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 26, 20, 20),
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Ni Made Laksmi Mas P',
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 209, 229, 245),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Total Saldo Anda',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Rp. $formattedSaldo',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class BantuanInfo extends StatelessWidget {
  const BantuanInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 139, 193, 236),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Butuh Bantuan?',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              Text(
                '0878-1234-1024',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Icon(
            Icons.phone,
            color: Colors.blue[900],
            size: 40,
          ),
        ],
      ),
    );
  }
}

class BottomMenu extends StatelessWidget {
  const BottomMenu({Key? key}) : super(key: key);

  Widget menuBottom(IconData icon, String label, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, size: 45, color: Colors.blue[900]),
          SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      color:const Color.fromARGB(255, 188, 203, 227),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          menuBottom(Icons.settings, "Setting", onTap: () { Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingPage()),
            );
          }),
          
          // QR Code dalam lingkaran
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue[900],
            ),
            child: Center(
              child: Icon(Icons.qr_code, size: 60, color: Colors.white),
            ),
          ),

          menuBottom(Icons.person, "Profile", onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilPage()),
            );
          }),
        ],
      ),
    );
  }
}


