import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/saldo_notifier.dart';
import 'detail_transfer_page.dart';

class PenerimaBaruPage extends StatefulWidget {
  @override
  State<PenerimaBaruPage> createState() => _PenerimaBaruPageState();
}

class _PenerimaBaruPageState extends State<PenerimaBaruPage> {
  String? selectedBank = "BANK BRI";
  final TextEditingController accountController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  final List<String> banks = ["BANK BRI", "BANK BCA", "BANK BNI"];

  @override
  Widget build(BuildContext context) {
    final saldo = Provider.of<SaldoNotifier>(context).saldo;

    bool isButtonEnabled = accountController.text.trim().isNotEmpty &&
        nameController.text.trim().isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Penerima Baru'),
        backgroundColor: Colors.blue[900],
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),

            // Bank Tujuan Dropdown
            const Text("Bank Tujuan", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: selectedBank,
              items: banks.map((bank) {
                return DropdownMenuItem(
                  value: bank,
                  child: Row(
                    children: [
                      const Icon(Icons.account_balance),
                      const SizedBox(width: 8),
                      Text(bank),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedBank = value!;
                });
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 24),

            // Nama Penerima
            const Text("Nama Penerima", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: nameController,
              onChanged: (_) => setState(() {}),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Masukkan nama penerima",
                prefixIcon: Icon(Icons.person),
              ),
            ),

            const SizedBox(height: 24),

            // Nomor Rekening
            const Text("Nomor Rekening", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: accountController,
              onChanged: (_) => setState(() {}),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Masukkan nomor rekening",
                prefixIcon: Icon(Icons.numbers),
              ),
            ),

            const Spacer(),

            // Tombol Lanjutkan
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: isButtonEnabled
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailTransferPage(
                              name: nameController.text.trim(),
                              bank: selectedBank ?? '',
                              account: accountController.text.trim(),
                            ),
                          ),
                        );
                      }
                    : null,
                child: const Text("Lanjutkan"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isButtonEnabled ? Colors.blue[900] : Colors.grey[300],
                  foregroundColor: isButtonEnabled ? Colors.white : Colors.black38,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
