// ignore_for_file: sort_child_properties_last, prefer_const_constructors, preferhomepagehome_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:thebookest/constants.dart';
import 'package:thebookest/screens/admin/admin_panel.dart';
import 'package:thebookest/screens/home/home_screen.dart';
import 'package:thebookest/screens/admin/edit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Book Store',
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  var nameController = TextEditingController();
  var passwordController = TextEditingController();

  var validLogin = true;

  void checkLogin() {
    var check = false;
    if (nameController.text == "123" && passwordController.text == "123") {
      check = true;
    }
    setState(() {
      validLogin = check;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // or MaterialApp
        body: Form(
            onChanged: checkLogin,
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'TheBookest',
                      style: TextStyle(
                          color: Color.fromARGB(255, 243, 65, 33),
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'ĐĂNG NHẬP',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                // TextButton(
                //   onPressed: () {
                //     //forgot password screen
                //   },
                //   child: const Text(
                //     'Forgot Password',
                //   ),
                // ),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                        child: const Text('Đăng nhập'),
                        onPressed: validLogin
                            ? () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()))
                            : () => null)),
                // Row(
                //   children: <Widget>[
                //     const Text('Does not have account?'),
                //     TextButton(
                //       child: const Text(
                //         'Sign in',
                //         style: TextStyle(fontSize: 20),
                //       ),
                //       onPressed: () {
                //         //signup screen
                //       },
                //     )
                //   ],
                //   mainAxisAlignment: MainAxisAlignment.center,
                // ),
              ],
            )));
  }
}
