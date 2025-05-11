import 'package:flutter/material.dart';
import 'package:layout2/pages/daftar_page.dart';
import 'package:layout2/pages/lupa_password_page.dart';
import 'koperasi_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isValid = true;

  void _login() {
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      setState(() => isValid = false);
      return;
    }

    if (usernameController.text == '2315091006' && passwordController.text == '2315091006') {
      Navigator.push(context, MaterialPageRoute(builder: (context) => KoperasiPage()));
    } else {
      setState(() => isValid = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Username or Password is incorrect. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Header(title: 'Koperasi Undiksha'),
          SizedBox(height: 20),
          Image.asset('assets/undiksha.png', height: 150),
          SizedBox(height: 20),
          LoginForm(
            usernameController: usernameController,
            passwordController: passwordController,
            isValid: isValid,
            onLogin: _login,
          ),
          SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const DaftarPage()),
                          );
                        }, 
                          child: Text('Daftar Mbanking'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LupaPasswordPage()),
                          );
                          }, // Tambahkan aksi jika ada
                          child: Text('lupa password?'),
                        ),
                      ],
                    ),
          Spacer(),
          Container(
          color: Colors.blue[100],
          width: double.infinity,
          padding: EdgeInsets.all(10),
          child: Center(
            child: Text(
              'copyright @2022 by Undiksha',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  final String title;
  
  const Header({required this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      color: Colors.blue[900],
      alignment: Alignment.center,
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final bool isValid;
  final VoidCallback onLogin;

  const LoginForm({
    required this.usernameController,
    required this.passwordController,
    required this.isValid,
    required this.onLogin,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Username", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                errorText: isValid || usernameController.text.isNotEmpty ? null : 'Username cannot be empty',
              ),
            ),
            SizedBox(height: 15),
            Text("Password", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                errorText: isValid || passwordController.text.isNotEmpty ? null : 'Password cannot be empty',
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: onLogin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[900],
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  elevation: 5,
                  shadowColor: Colors.black45,
                ),
                child: Text('Login', style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      color: Color(0xFFD0D3E2),
      alignment: Alignment.center,
      child: Text(
        'copyright @2022 by Undiksha',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

