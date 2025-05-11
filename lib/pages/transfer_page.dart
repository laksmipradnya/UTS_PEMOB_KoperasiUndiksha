import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'detail_transfer_page.dart';
import '../providers/saldo_notifier.dart';
import 'penerima_baru_page.dart';

class TransferPage extends StatefulWidget {
  const TransferPage({Key? key}) : super(key: key);

  @override
  State<TransferPage> createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {

  @override
  Widget build(BuildContext context) {
    final currentSaldo = Provider.of<SaldoNotifier>(context).saldo;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfer'),
        backgroundColor: Colors.blue[900],
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(child: _buildSavedList(context)),
          _buildAddNewButton(),
        ],
      ),
    );
  }

  Widget _buildRecipientCard(String initials, String name, String bank, String account) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            CircleAvatar(backgroundColor: Colors.blue, child: Text(initials, style: const TextStyle(color: Colors.white))),
            const SizedBox(height: 6),
            Text(name, maxLines: 1, overflow: TextOverflow.ellipsis),
            Text(bank, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            Text(account, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildScheduledTransferInfo() {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(color: Colors.blue[50], borderRadius: BorderRadius.circular(8)),
    );
  }

  Widget _buildSavedList(BuildContext context) {
    final savedList = [
      ["MM", "MAYLIN MONICA", "BANK BNI", "000778886669900"],
      ["GP", "GEDE ANGGA PUTRA", "BANK BRI", "099999079622506"],
      ["NN", "NIA NARYANTIKA", "BANK BRI", "111556677788899"],
      ["DP", "DINDA PRAMESWARI", "BANK BCA", "22333444556670"],
      ["JY", "JYOTISA YOGISWARI", "BANK BCA", "123456789012345"],
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Daftar Tersimpan", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          ...savedList.map((data) => _buildSavedListItem(data[0], data[1], data[2], data[3], context)),
        ],
      ),
    );
  }

  Widget _buildSavedListItem(String initials, String name, String bank, String account, BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(backgroundColor: Colors.blue[900], child: Text(initials, style: const TextStyle(color: Colors.white))),
      title: Text(name),
      subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(bank), Text(account)]),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailTransferPage(
              name: name,
              bank: bank,
              account: account,
            ),
          ),
        );

        if (result != null && result is double) {
          setState(() {
            Provider.of<SaldoNotifier>(context, listen: false).updateSaldo(result);
          });
        }
      },
    );
  }

  Widget _buildAddNewButton() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PenerimaBaruPage()),
        );
      },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue[900],
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: const Text("Tambah Penerima Baru"),
      ),
    );
  }
}
