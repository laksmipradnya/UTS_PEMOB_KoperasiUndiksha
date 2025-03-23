import 'package:flutter/material.dart';
import 'koperasi_page.dart'; // Pastikan file ini di-import

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controllers to manage input fields
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Validation flag
  bool isValid = true;

  void _login() {
    // Check if the username and password fields are not empty
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      setState(() {
        isValid = false; // Invalid if either field is empty
      });
      return;
    }

    // Add your validation logic here, for example:
    if (usernameController.text == '2315091006' && passwordController.text == '2315091006') {
      // Navigate to the next page if valid
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => KoperasiPage(),
        ),
      );

    } else {
      // Show error message with SnackBar
      setState(() {
        isValid = false; // Invalid credentials
      });
      // Display the SnackBar with an error message
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
          // Header
          Container(
            height: 70,
            color: Colors.blue[900],
            alignment: Alignment.center,
            child: Text(
              'Koperasi Undiksha',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20),

          // Logo
          Image.asset('assets/undiksha.png', height: 150),
          SizedBox(height: 20),

          // Form Container
          Padding(
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
                  // Label Username
                  Text(
                    "Username",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),

                  // Input Username
                  TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      errorText: isValid || usernameController.text.isNotEmpty
                          ? null
                          : 'Username cannot be empty',
                    ),
                  ),
                  SizedBox(height: 15),

                  // Label Password
                  Text(
                    "Password",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),

                  // Input Password
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      errorText: isValid || passwordController.text.isNotEmpty
                          ? null
                          : 'Password cannot be empty',
                    ),
                  ),
                  SizedBox(height: 20),

                  // Tombol Login
                  Center(
                    child: ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[900],
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 5,
                        shadowColor: Colors.black45,
                      ),
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

                  // Daftar & Lupa Password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Daftar Mbanking',
                          style: TextStyle(
                            color: Colors.blue[900],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Lupa password?',
                          style: TextStyle(
                            color: Colors.blue[900],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 20),

          // Spacer untuk mendorong footer ke bawah
          Spacer(),

          // Footer
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            color: Color(0xFFD0D3E2), // Warna abu-abu seperti gambar
            alignment: Alignment.center,
            child: Text(
              'copyright @2022 by Undiksha',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

