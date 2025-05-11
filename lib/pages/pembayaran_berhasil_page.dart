import 'package:flutter/material.dart';

class PembayaranBerhasilPage extends StatelessWidget {
  final VoidCallback onSelesai;

  const PembayaranBerhasilPage({super.key, required this.onSelesai});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pembayaran'),
        backgroundColor: Colors.blue[900],
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 24),
            const Icon(Icons.check_circle, size: 100, color: Colors.green),
            const SizedBox(height: 24),
            const Text(
              'Pembayaran Berhasil',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                DetailRow(label: 'Jenis Pembayaran', value: 'Simpanan Wajib'),
                DetailRow(label: 'Nominal', value: 'Rp 200.000'),
                DetailRow(label: 'Metode Pembayaran', value: 'Transfer Bank'),
                DetailRow(label: 'Tanggal Pembayaran', value: '8 Mei 2025'),
                DetailRow(
                  label: 'Status',
                  value: 'Sudah Dibayar',
                  isBold: true,
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onSelesai,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[900],
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Kembali ke Daftar Pembayaran'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;

  const DetailRow({
    super.key,
    required this.label,
    required this.value,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(label),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
