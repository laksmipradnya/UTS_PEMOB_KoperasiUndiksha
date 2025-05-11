import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/login_page.dart';
import 'pages/koperasi_page.dart';
import 'providers/saldo_notifier.dart'; // pastikan path-nya sesuai
import 'providers/riwayat_deposito_notifier.dart'; 

// Buat navigatorKey global agar bisa digunakan untuk navigasi antar halaman
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// Inisialisasi saldo awal sebagai ValueNotifier (state global)
final SaldoNotifier saldoNotifier = SaldoNotifier(); // Rp1.200.000

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SaldoNotifier()),
        ChangeNotifierProvider(create: (_) => RiwayatDepositoNotifier()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: KoperasiPage(), // ganti sesuai halaman awal kamu
    );
  }
}
