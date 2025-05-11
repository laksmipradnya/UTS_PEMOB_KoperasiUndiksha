import 'package:flutter/foundation.dart';
import '../models/riwayat_deposito_model.dart';

class RiwayatDepositoNotifier extends ChangeNotifier {
  final List<RiwayatDeposito> _riwayatList = [];

  List<RiwayatDeposito> get riwayatList => _riwayatList;

  void tambahRiwayat(RiwayatDeposito deposito) {
    _riwayatList.insert(0, deposito); // tambahkan ke atas
    notifyListeners();
  }
  void updateRiwayat() {
  notifyListeners();
}
}
