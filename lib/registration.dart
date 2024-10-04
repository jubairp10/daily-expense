import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:texol/login.dart';
import 'home.dart';
 // Import your HomeScreen

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Registeration")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Center(
                child: Image(
                  image: AssetImage('assets/img/budget (1).png'),
                  height: 100,
                  width: 100,
                ),
              ),
              SizedBox(height: 40,),
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration( border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black)),
                    labelText: "Username"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20,),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration( border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black)),
                    labelText: "Password"),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Save user details for registration
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    await prefs.setString('username', _usernameController.text);
                    await prefs.setString('password', _passwordController.text); // Store password securely if possible

                    // Navigate to HomeScreen after registration
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>LoginScreen()));
                  }
                },
                child: Text("Register"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Go back to Login Screen
                },
                child: Text("Already have an account? Login here"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
