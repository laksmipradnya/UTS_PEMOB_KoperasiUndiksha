import 'package:flutter/material.dart';

class PermohonanBaruPage extends StatefulWidget {
  final void Function(Map<String, dynamic>) onSubmit;

  const PermohonanBaruPage({super.key, required this.onSubmit});

  @override
  State<PermohonanBaruPage> createState() => _PermohonanBaruPageState();
}

class _PermohonanBaruPageState extends State<PermohonanBaruPage> {
  final _formKey = GlobalKey<FormState>();
  String? _jenisPinjaman;
  DateTime? _tanggalPengajuan;
  final TextEditingController _tenorController = TextEditingController();
  final TextEditingController _plafonController = TextEditingController();

  @override
  void dispose() {
    _tenorController.dispose();
    _plafonController.dispose();
    super.dispose();
  }

  Future<void> _selectTanggal() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        _tanggalPengajuan = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Nama Pinjaman'),
              const SizedBox(height: 8),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Contoh: Pinjaman Uang',
                ),
                onChanged: (value) {
                  _jenisPinjaman = value;
                },
                validator: (value) =>
                    value == null || value.isEmpty ? 'Masukkan jenis pinjaman' : null,
              ),
              const SizedBox(height: 16),
              const Text('Tanggal Pengajuan'),
              const SizedBox(height: 8),
              InkWell(
                onTap: _selectTanggal,
                child: InputDecorator(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  child: Text(
                    _tanggalPengajuan != null
                        ? '${_tanggalPengajuan!.day} ${_bulan(_tanggalPengajuan!.month)} ${_tanggalPengajuan!.year}'
                        : 'Pilih Tanggal',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Tenor (bulan)'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _tenorController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Contoh: 6',
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Masukkan tenor' : null,
              ),
              const SizedBox(height: 16),
              const Text('Plafon Pinjaman'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _plafonController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Contoh: 1500000',
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Masukkan plafon' : null,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate() &&
                        _tanggalPengajuan != null &&
                        _jenisPinjaman != null) {
                      final pengajuanBaru = {
                        'jenis': _jenisPinjaman!,
                        'status': 'Menunggu',
                        'noKredit':
                            '000-${DateTime.now().millisecondsSinceEpoch % 10000}',
                        'pengajuan':
                            '${_tanggalPengajuan!.day} ${_bulan(_tanggalPengajuan!.month)} ${_tanggalPengajuan!.year}',
                        'tenor': '${_tenorController.text} Bulan',
                        'plafon': int.parse(_plafonController.text),
                        'angsuran': 0,
                        'jatuhTempo': '-',
                        'sisaPlafon': int.parse(_plafonController.text),
                      };

                      widget.onSubmit(pengajuanBaru);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Permohonan berhasil diajukan')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[900],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Ajukan Permohonan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _bulan(int bulan) {
    const namaBulan = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'Mei',
      'Jun',
      'Jul',
      'Agu',
      'Sep',
      'Okt',
      'Nov',
      'Des'
    ];
    return namaBulan[bulan];
  }
}
