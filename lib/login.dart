// import 'package:flutter/material.dart';
//
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'home.dart';
//
// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Login")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Center(
//             child:Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 SizedBox(height: 50,),
//                 Center(child: Image(image: AssetImage('assets/img/budget (1).png'),height: 100,width: 100,)),
//                 SizedBox(height: 40,),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: TextFormField(
//                     controller: _usernameController,
//                     decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
//                     borderSide: BorderSide(color: Colors.black)),
//                         labelText: "Username"),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your username';
//                       }
//                       return null;
//                     },
//                   ),
//                 ),
//                 SizedBox(height: 10,),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: TextFormField(
//                     controller: _passwordController,
//                     decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//                         labelText: "Password"),
//                     obscureText: true,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your password';
//                       }
//                       return null;
//                     },
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () async {
//                     // Validate the form
//                     if (_formKey.currentState!.validate()) {
//                       // If the form is valid, save the credentials
//                       SharedPreferences prefs = await SharedPreferences.getInstance();
//                       await prefs.setString('username', _usernameController.text);
//                       await prefs.setString('password', _passwordController.text);
//
//                       // Navigate to the HomeScreen
//                       Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(builder: (context) => HomeScreen()),
//                       );
//                     }
//                   },
//                   child: Text("Login"),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart'; // Your HomeScreen
import 'registration.dart'; // Import your RegistrationScreen

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  // Check if user is already logged in
  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('username') != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                Center(
                  child: Image(
                    image: AssetImage('assets/img/budget (1).png'),
                    height: 100,
                    width: 100,
                  ),
                ),
                SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      labelText: "Username",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Password",
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    // Validate the form
                    if (_formKey.currentState!.validate()) {
                      // Retrieve stored credentials
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      String? savedUsername = prefs.getString('username');
                      String? savedPassword = prefs.getString('password');

                      // Validate against stored credentials
                      if (_usernameController.text == savedUsername &&
                          _passwordController.text == savedPassword) {
                        // Navigate to HomeScreen if credentials match
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      } else {
                        // Show SnackBar for invalid credentials
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Invalid username or password")),
                        );
                      }
                    }
                  },
                  child: Text("Login"),
                ),
                TextButton(
                  onPressed: () {
                    // Navigate to RegistrationScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegistrationScreen()),
                    );
                  },
                  child: Text("Don't have an account? Register here"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
