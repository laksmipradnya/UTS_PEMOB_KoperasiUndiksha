import 'package:flutter/material.dart';
import 'pembayaran_detail_page.dart';

class PembayaranPage extends StatefulWidget {
  const PembayaranPage({super.key});

  @override
  State<PembayaranPage> createState() => _PembayaranPageState();
}

class _PembayaranPageState extends State<PembayaranPage> {
  final List<Map<String, dynamic>> tagihan = [
    {
      'tipe': 'Iuran Wajib',
      'nominal': 200000,
      'tanggal': '10 Mei 2024',
      'status': 'Belum Dibayar',
    },
    {
      'tipe': 'Angsuran Pinjaman',
      'nominal': 1000000,
      'tanggal': '25 Mar 2024',
      'status': 'Sudah Dibayar',
    },
  ];

  void _handleBayar(int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PembayaranDetailPage(),
      ),
    );

    if (result == true) {
      setState(() {
        tagihan[index]['status'] = 'Sudah Dibayar';
      });
    }
  }

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
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: tagihan.length,
          itemBuilder: (context, index) {
            final item = tagihan[index];
            return TagihanCard(
              tipe: item['tipe'],
              nominal: item['nominal'],
              tanggal: item['tanggal'],
              status: item['status'],
              onBayar: item['status'] == 'Belum Dibayar'
                  ? () => _handleBayar(index)
                  : null,
            );
          },
        ),
      ),
    );
  }
}

class TagihanCard extends StatelessWidget {
  final String tipe;
  final int nominal;
  final String tanggal;
  final String status;
  final VoidCallback? onBayar;

  const TagihanCard({
    super.key,
    required this.tipe,
    required this.nominal,
    required this.tanggal,
    required this.status,
    this.onBayar,
  });

  @override
  Widget build(BuildContext context) {
    final bool isLunas = status == 'Sudah Dibayar';

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  tipe,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: isLunas ? Colors.green[100] : Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      fontSize: 12,
                      color: isLunas ? Colors.green[800] : Colors.grey[800],
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Nominal\nRp ${nominal.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')}',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Text(
              'Jatuh Tempo\n$tanggal',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: onBayar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: onBayar == null ? Colors.grey[400] : Colors.blue[800],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Bayar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
