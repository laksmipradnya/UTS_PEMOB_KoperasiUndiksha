import 'package:flutter/material.dart';
import 'package:layout2/pages/deposito_page.dart';
import 'package:layout2/pages/mutasi_page.dart';
import 'package:layout2/pages/pembayaran_page.dart';
import 'package:layout2/pages/pinjaman_page.dart';
import '../pages/transfer_page.dart';
import 'package:provider/provider.dart';
import '../providers/saldo_notifier.dart'; // pastikan path-nya benar

class GridMenu extends StatelessWidget {
  const GridMenu({Key? key}) : super(key: key);

  Widget menuItem(IconData icon, String label, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 222, 235, 250),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey[400]!, width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.blue[900]),
            SizedBox(height: 5),
            Text(
              label,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: GridView.count(
        crossAxisCount: 3,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: [
          menuItem(Icons.account_balance_wallet, "Cek Saldo", onTap: () {
            final saldo = Provider.of<SaldoNotifier>(context, listen: false).saldo;

            final formattedSaldo = saldo
                .toStringAsFixed(0)
                .replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                    (match) => '${match[1]}.');

            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  title: const Text('Saldo Anda'),
                  content: Text(
                    'Total Saldo Anda adalah:\nRp $formattedSaldo',
                    style: const TextStyle(fontSize: 16),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
            );
          }),
          menuItem(Icons.sync_alt, "Transfer", onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TransferPage()),
            );
          }),
          menuItem(Icons.savings, "Deposito" , onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DepositoPage()),
            );
          }),
          menuItem(Icons.payment, "Pembayaran", onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PembayaranPage()),
            );
          }),
          menuItem(Icons.business_center, "Pinjaman",onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PinjamanPage()),
            );
          }),
          menuItem(Icons.receipt_long, "Mutasi", onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MutasiPage()),
            );
          }),
        ],
      ),
    );
  }
}
