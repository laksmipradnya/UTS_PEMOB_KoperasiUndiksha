import 'package:flutter/material.dart';

class BahasaPage extends StatefulWidget {
  const BahasaPage({Key? key}) : super(key: key);

  @override
  State<BahasaPage> createState() => _BahasaPageState();
}

class _BahasaPageState extends State<BahasaPage> {
  String _selectedLanguage = 'Indonesia';

  final List<String> _languages = ['Indonesia', 'English'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bahasa'),
        backgroundColor: Colors.blue[900],
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: _languages.length,
        itemBuilder: (context, index) {
          final language = _languages[index];
          return ListTile(
            title: Text(language),
            trailing: _selectedLanguage == language
                ? const Icon(Icons.check, color: Colors.blue)
                : null,
            onTap: () {
              setState(() {
                _selectedLanguage = language;
              });

              // Simpan pilihan bahasa ke storage lokal jika diperlukan
              // Misalnya menggunakan SharedPreferences
            },
          );
        },
      ),
    );
  }
}
