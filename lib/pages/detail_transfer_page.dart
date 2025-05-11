import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/saldo_notifier.dart';

class DetailTransferPage extends StatefulWidget {
  final String name;
  final String bank;
  final String account;

  const DetailTransferPage({
    Key? key,
    required this.name,
    required this.bank,
    required this.account,
  }) : super(key: key);

  @override
  State<DetailTransferPage> createState() => _DetailTransferPageState();
}

class _DetailTransferPageState extends State<DetailTransferPage> {
  final TextEditingController _amountController = TextEditingController();

  bool get isButtonEnabled {
    final nominal = double.tryParse(_amountController.text) ?? 0;
    return widget.name.isNotEmpty &&
        widget.bank.isNotEmpty &&
        widget.account.isNotEmpty &&
        nominal >= 10000;
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final saldoNotifier = Provider.of<SaldoNotifier>(context);
    final currentSaldo = saldoNotifier.saldo;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfer Dana'),
        backgroundColor: Colors.blue[900],
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.name.isEmpty ? "(Tanpa Nama)" : widget.name,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(widget.bank),
            Text(widget.account, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),
            const Text("Nominal Transfer"),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              onChanged: (_) => setState(() {}),
              decoration: const InputDecoration(hintText: "Rp0 (minimal Rp10.000)"),
            ),
            const SizedBox(height: 20),
            const Text("Sumber Dana"),
            Card(
              child: ListTile(
                title: const Text("3576 0103 3535 539"),
                subtitle: const Text("NI MADE LAKSMI MAS PRADNYADEWI"),
                trailing: Text("Rp${currentSaldo.toStringAsFixed(2)}"),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: isButtonEnabled
                    ? () {
                        final amount = double.tryParse(_amountController.text);
                        if (amount == null || amount < 10000) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Nominal minimal Rp10.000')),
                          );
                          return;
                        }
                        if (amount > currentSaldo) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Saldo tidak mencukupi')),
                          );
                          return;
                        }

                        saldoNotifier.kurangiSaldo(amount);

                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Transfer Berhasil'),
                            content: Text('Rp ${amount.toStringAsFixed(2)} berhasil dikirim ke ${widget.account}.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isButtonEnabled ? Colors.blue[900] : Colors.grey[300],
                  foregroundColor: isButtonEnabled ? Colors.white : Colors.black38,
                ),
                child: const Text("Kirim"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
