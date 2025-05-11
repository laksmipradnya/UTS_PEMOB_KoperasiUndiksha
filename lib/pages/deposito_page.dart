import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/saldo_notifier.dart';
import '../../providers/riwayat_deposito_notifier.dart';
import '../../models/riwayat_deposito_model.dart';
import 'dart:math';

class DepositoPage extends StatelessWidget {
  const DepositoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Deposito Koperasi'),
          backgroundColor: Colors.blue[900],
          foregroundColor: Colors.white,
          centerTitle: true,
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Color.fromARGB(255, 145, 165, 189),
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'Buka Deposito Baru'),
              Tab(text: 'Riwayat'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            BukaDepositoTab(),
            RiwayatDepositoTab(),
          ],
        ),
      ),
    );
  }
}

class BukaDepositoTab extends StatefulWidget {
  const BukaDepositoTab({super.key});

  @override
  State<BukaDepositoTab> createState() => _BukaDepositoTabState();
}

class _BukaDepositoTabState extends State<BukaDepositoTab> {
  String _selectedSumberDana = 'Cash';
  final TextEditingController _nominalController = TextEditingController();

  String _generateRandomNumber() {
    final random = Random();
    return List.generate(9, (_) => random.nextInt(10)).join();
  }

  String _getTodayDate() {
    final now = DateTime.now();
    return '${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          TextField(
            controller: _nominalController,
            decoration: const InputDecoration(
              labelText: 'Nominal Deposito',
              prefixText: 'Rp ',
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              String nominalText = _nominalController.text.trim().replaceAll('.', '').replaceAll(',', '');
              int? nominal = int.tryParse(nominalText);

              if (nominal == null || nominal <= 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Masukkan nominal yang valid')),
                );
                return;
              }

              final saldoNotifier = Provider.of<SaldoNotifier>(context, listen: false);
              saldoNotifier.updateSaldo(saldoNotifier.saldo - nominal);

              final riwayatNotifier = Provider.of<RiwayatDepositoNotifier>(context, listen: false);
              riwayatNotifier.tambahRiwayat(
                RiwayatDeposito(
                  nomor: _generateRandomNumber(),
                  tanggal: _getTodayDate(),
                  nominal: 'Rp ${nominal.toString()}',
                  status: 'Aktif',
                ),
              );

              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    title: const Text('Berhasil'),
                    content: const Text('Deposit Berhasil Dikirim!'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('OK', style: TextStyle(color: Colors.purple)),
                      ),
                    ],
                  );
                },
              );

              _nominalController.clear();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[900],
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 48),
            ),
            child: const Text('Deposit'),
          ),
        ],
      ),
    );
  }
}

class RiwayatDepositoTab extends StatelessWidget {
  const RiwayatDepositoTab({super.key});

  @override
  Widget build(BuildContext context) {
    final riwayatList = context.watch<RiwayatDepositoNotifier>().riwayatList;

    if (riwayatList.isEmpty) {
      return const Center(child: Text('Belum ada transaksi deposito.'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: riwayatList.length,
      itemBuilder: (context, index) {
        final item = riwayatList[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            title: Text('No. Deposito ${item.nomor}'),
            subtitle: Text('${item.tanggal} • ${item.nominal}'),
            trailing: Text(item.status, style: const TextStyle(color: Colors.blue)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => DetailDepositoPage(deposito: item)),
              );
            },
          ),
        );
      },
    );
  }
}

class DetailDepositoPage extends StatelessWidget {
  final RiwayatDeposito deposito;

  const DetailDepositoPage({super.key, required this.deposito});

  @override
  Widget build(BuildContext context) {
    final isAktif = deposito.status == 'Aktif';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Deposito'),
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            detailRow('Nomor Deposito', deposito.nomor, bold: true),
            detailRow('Tanggal', deposito.tanggal),
            detailRow('Nominal', deposito.nominal),
            detailRow('Status', deposito.status),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isAktif
                    ? () {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text("Konfirmasi"),
                            content: const Text("Apakah Anda yakin ingin menarik dana?"),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text("Batal"),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  final saldoNotifier = Provider.of<SaldoNotifier>(context, listen: false);
                                  final nominalString = deposito.nominal.replaceAll(RegExp(r'[^0-9]'), '');
                                  final nominal = int.tryParse(nominalString) ?? 0;

                                  saldoNotifier.updateSaldo(saldoNotifier.saldo + nominal);

                                  deposito.status = 'Tidak Aktif';
                                  final riwayatNotifier = Provider.of<RiwayatDepositoNotifier>(context, listen: false);
  riwayatNotifier.updateRiwayat(); 

                                  Navigator.of(context)
                                  ..pop()
                                  ..pop();

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Dana berhasil ditarik!")),
                                  );
                                },
                                child: const Text("Ya"),
                              ),
                            ],
                          ),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isAktif ? Colors.blue[900] : Colors.grey,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text("Tarik Dana"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget detailRow(String label, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value, style: TextStyle(fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }
}
