import 'package:flutter/material.dart';

class MutasiPage extends StatelessWidget {
  final List<Map<String, dynamic>> transaksi = [
    {
      'tanggal': '10 Apr 2025',
      'deskripsi': 'Bayar QRIS',
      'jumlah': -10000,
      'waktu': '16:22:09 WIB',
    },
    {
      'tanggal': '9 Apr 2025',
      'deskripsi': 'Bayar QRIS',
      'jumlah': -10000,
      'waktu': '10:51:11 WIB',
    },
    {
      'tanggal': '4 Apr 2025',
      'deskripsi': 'Transfer Dari MAYLIN MONICA via BRImo',
      'jumlah': 50000,
      'waktu': '19:01:06 WIB',
    },
    {
      'tanggal': '25 Mar 2025',
      'deskripsi': 'Transfer Ke GEDE ANGGA PUTRA via BRImo',
      'jumlah': -25000,
      'waktu': '20:39:35 WIB',
    },
    {
      'tanggal': '24 Mar 2025',
      'deskripsi': 'Transfer Dari NIA NARYANTIKA via BRImo',
      'jumlah': 24000,
      'waktu': '21:25:39 WIB',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mutasi'),
        backgroundColor: Colors.blue[900],
        foregroundColor: Colors.white, 
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: transaksi.length,
        itemBuilder: (context, index) {
          final item = transaksi[index];
          final isPositive = item['jumlah'] >= 0;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (index == 0 || transaksi[index - 1]['tanggal'] != item['tanggal'])
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  color: Colors.grey[200],
                  child: Text(
                    item['tanggal'],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ListTile(
                title: Text(item['deskripsi']),
                subtitle: Text(item['waktu']),
                trailing: Text(
                  "${isPositive ? '+' : '-'} Rp${item['jumlah'].abs().toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')},00",
                  style: TextStyle(
                    color: isPositive ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(height: 0),
            ],
          );
        },
      ),
    );
  }
}
