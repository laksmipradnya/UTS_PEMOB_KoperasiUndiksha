import 'package:flutter/material.dart';

class SaldoNotifier extends ChangeNotifier {
  double _saldo = 1000000.0; // saldo awal

  double get saldo => _saldo;

  void updateSaldo(double newSaldo) {
    _saldo = newSaldo;
    notifyListeners();
  }

  void kurangiSaldo(double amount) {
    _saldo -= amount;
    notifyListeners();
  }
}