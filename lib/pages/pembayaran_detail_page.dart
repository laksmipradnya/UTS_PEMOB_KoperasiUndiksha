import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/saldo_notifier.dart';
import 'pembayaran_berhasil_page.dart';

class PembayaranDetailPage extends StatefulWidget {
  const PembayaranDetailPage({super.key});

  @override
  _PembayaranDetailPageState createState() => _PembayaranDetailPageState();
}

class _PembayaranDetailPageState extends State<PembayaranDetailPage> {
  String _selectedMethod = 'Transfer Bank';
  final double nominalPembayaran = 200000.0;

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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      border: Border.all(color: Colors.blue.shade100),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Jenis Pembayaran',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        const Text('Iuran Wajib'),
                        const Text('Rp 200.000'),
                        const Divider(),
                        const Text('Metode Pembayaran',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        RadioListTile<String>(
                          value: 'Transfer Bank',
                          groupValue: _selectedMethod,
                          onChanged: (value) {
                            setState(() => _selectedMethod = value!);
                          },
                          title: const Text('Transfer Bank'),
                        ),
                        RadioListTile<String>(
                          value: 'E-Wallet',
                          groupValue: _selectedMethod,
                          onChanged: (value) {
                            setState(() => _selectedMethod = value!);
                          },
                          title: const Text('E-Wallet'),
                        ),
                        RadioListTile<String>(
                          value: 'Kartu Kredit',
                          groupValue: _selectedMethod,
                          onChanged: (value) {
                            setState(() => _selectedMethod = value!);
                          },
                          title: const Text('Kartu Kredit'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Batal'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      final saldoProvider =
                          Provider.of<SaldoNotifier>(context, listen: false);
                      final saldoSekarang = saldoProvider.saldo;

                      if (saldoSekarang >= nominalPembayaran) {
                        double saldoBaru = saldoSekarang - nominalPembayaran;
                        saldoProvider.updateSaldo(saldoBaru);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PembayaranBerhasilPage(
                              onSelesai: () {
                                Navigator.pop(context); // Tutup halaman berhasil
                                Navigator.pop(context, true); // Kembalikan true ke PembayaranPage
                              },
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Saldo tidak mencukupi.'),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[900],
                      foregroundColor: const Color.fromARGB(255, 239, 238, 241),
                    ),
                    child: const Text('Kirim'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
