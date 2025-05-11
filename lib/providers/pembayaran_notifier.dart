import 'package:flutter/material.dart';

class Pembayaran {
  final String jenis;
  final double nominal;
  final String jatuhTempo;
  bool sudahDibayar;

  Pembayaran({
    required this.jenis,
    required this.nominal,
    required this.jatuhTempo,
    this.sudahDibayar = false,
  });
}

class PembayaranNotifier extends ChangeNotifier {
  final List<Pembayaran> _daftar = [
    Pembayaran(jenis: 'Simpanan Wajib', nominal: 200000, jatuhTempo: '10 Mei 2024'),
    Pembayaran(jenis: 'Angsuran', nominal: 1000000, jatuhTempo: '25 Apr 2024'),
    Pembayaran(jenis: 'Simpanan Sukarela', nominal: 1000000, jatuhTempo: '25 Mar 2024', sudahDibayar: true),
    Pembayaran(jenis: 'Angsuran', nominal: 1000000, jatuhTempo: '25 Mar 2024'),
  ];

  List<Pembayaran> get daftarPembayaran => _daftar;

  void tandaiSudahDibayar(String jenis) {
    final item = _daftar.firstWhere((e) => e.jenis == jenis && !e.sudahDibayar);
    item.sudahDibayar = true;
    notifyListeners();
  }
}
