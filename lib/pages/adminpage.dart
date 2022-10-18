import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:management/database/auth_exception.dart';
import 'package:management/database/auth_functions.dart';
import 'package:management/pages/mainpage.dart';

class AdminPage extends StatefulWidget {
  AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  String email = "";
  String password = "";
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Container(
          width: 400,
          height: 400,
          decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(20)),
          child: Form(
            key: _formkey,
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  TextFormField(
                    key: ValueKey('email'),
                    decoration: InputDecoration(hintText: "Enter Email"),
                    validator: (value) {
                      if (!(value.toString().contains('@'))) {
                        return 'Invalid Email';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      setState(() {
                        email = value!;
                      });
                    },
                  ),
                  TextFormField(
                    obscureText: true,
                    key: ValueKey('password'),
                    decoration: InputDecoration(hintText: "Enter Password"),
                    validator: (value) {
                      if (value.toString().length < 6) {
                        return 'Password is so small';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      setState(() {
                        password = value!;
                      });
                    },
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (_formkey.currentState!.validate()) {
                          _formkey.currentState!.save();

                          final signInStatus =
                              await Auth().signIn(email.trim(), password);

                          if (signInStatus == AuthResultStatus.successful) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MainPage(),
                                ));
                          }
                        }
                      },
                      child: Text("Login"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
