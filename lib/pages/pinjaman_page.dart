import 'package:flutter/material.dart';
import 'permohonan_baru_page.dart';

class PinjamanPage extends StatefulWidget {
  const PinjamanPage({super.key});

  @override
  State<PinjamanPage> createState() => _PinjamanPageState();
}

class _PinjamanPageState extends State<PinjamanPage> {
  final List<Map<String, dynamic>> pinjamanList = [
    {
      'jenis': 'Pinjaman Uang',
      'status': 'Lunas',
      'noKredit': '005-0047',
      'pengajuan': '28 Jul 2021',
      'tenor': '3 Bulan',
      'plafon': 1500000,
      'angsuran': 0,
      'jatuhTempo': '28 Okt 2021',
      'sisaPlafon': 1500000,
    },
    {
      'jenis': 'Pinjaman Uang',
      'status': 'Lunas',
      'noKredit': '000-0042',
      'pengajuan': '27 Feb 2021',
      'tenor': '6 Bulan',
      'plafon': 3300000,
      'angsuran': 0,
      'jatuhTempo': '27 Agu 2021',
      'sisaPlafon': 3300000,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          title: const Text('Pinjaman'),
          foregroundColor: Colors.white,
          centerTitle: true,
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'Data Pinjaman'),
              Tab(text: 'Permohonan Baru'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Tab 1 - Data Pinjaman
            ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: pinjamanList.length,
              itemBuilder: (context, index) {
                final item = pinjamanList[index];
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  margin: const EdgeInsets.only(bottom: 16),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.account_balance_wallet,
                                color: Colors.orange),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item['jenis'],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Text('Status: ${item['status']}',
                                      style:
                                          const TextStyle(color: Colors.green)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        infoBar('No. Kredit', item['noKredit']),
                        infoBar('Pengajuan', item['pengajuan']),
                        infoBar('Tenor', item['tenor']),
                        infoBar('Plafon', formatRupiah(item['plafon'])),
                        infoBar('Angsuran', formatRupiah(item['angsuran'])),
                        infoBar('Jatuh Tempo', item['jatuhTempo']),
                        infoBar('Sisa Plafon', formatRupiah(item['sisaPlafon'])),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                );
              },
            ),

            // Tab 2 - Permohonan Baru
            PermohonanBaruPage(
              onSubmit: (dataBaru) {
                setState(() {
                  pinjamanList.add(dataBaru);
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget infoBar(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  String formatRupiah(int value) {
    return 'Rp ${value.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (match) => '${match[1]}.')}';
  }
}
