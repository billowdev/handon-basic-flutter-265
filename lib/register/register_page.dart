import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:myapp_week5/login/login_page.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import '../home/homepage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  String? username;
  String? password;
  String? retypePassword;
  String? nameTH;
  String? nameEN;
  String? imageURL;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg2.jpg'),
                  fit: BoxFit.cover),
            ),
            child: SingleChildScrollView(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Image(
                    image: AssetImage('assets/images/logo_snru.png'),
                    height: 100,
                    width: 100,
                  ),
                  const Text(
                    "REGISTER PAGE",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontFamily: 'Arial Rounded MT Bold'),
                  ),
                  createRegisterForm()
                ],
              ),
            )),
      ),
    );
  }

  Widget createUsernameTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        icon: Icon(Icons.person),
        border: OutlineInputBorder(),
        labelText: 'Username',
      ),
      validator: (value) {
        if (value == null) {
          return "please enter something";
        } else {
          username = value;
          return null;
        }
      },
    );
  }

  Widget createPasswordTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        icon: Icon(Icons.key),
        border: OutlineInputBorder(),
        labelText: 'Password',
      ),
      obscureText: true,
      validator: (value) {
        if (value == null) {
          return "please enter something";
        } else {
          password = value;
          return null;
        }
      },
    );
  }

  Widget createRetypePasswordTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        icon: Icon(Icons.key),
        border: OutlineInputBorder(),
        labelText: 'retype password',
      ),
      obscureText: true,
      validator: (value) {
        if (value == null) {
          return "please enter something";
        } else {
          retypePassword = value;
          return null;
        }
      },
    );
  }

  Widget createNameTHTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        icon: Icon(Icons.person),
        border: OutlineInputBorder(),
        labelText: 'Name Thai',
      ),
      validator: (value) {
        if (value == null) {
          return "please enter something";
        } else {
          nameTH = value;
          return null;
        }
      },
    );
  }

  Widget createNameENTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        icon: Icon(Icons.person),
        border: OutlineInputBorder(),
        labelText: 'Name English',
      ),
      validator: (value) {
        if (value == null) {
          return "please enter something";
        } else {
          nameEN = value;
          return null;
        }
      },
    );
  }

  Widget createImageUrlTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        icon: Icon(Icons.person),
        border: OutlineInputBorder(),
        labelText: 'URL image',
      ),
      validator: (value) {
        if (value == null) {
          return "please enter something";
        } else {
          imageURL = value;
          return null;
        }
      },
    );
  }

  _register(acc) async {
    var urlRegister = Uri.http('host_name', '/api/register');
    var header = {'Content-Type': 'application/json'};
    final response =
        await http.post(urlRegister, headers: header, body: jsonEncode(acc));
    print('=========accccc=========');
    print(response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(response.body);
      if (res['status'] == 'ok') {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      }
    }
  }

  Widget createSubmitButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          if (password == retypePassword) {
            Map<String, dynamic> acc = {
              'username': username,
              'password': password,
              'nameTH': nameTH,
              'nameEN': nameEN,
              'imageURL': imageURL
            };
            _register(acc);
          } else {
            return null;
          }

          // debugPrint(username);
          // if (username == "admin" && password == "1234") {
          //   Navigator.pushReplacement(context,
          //       MaterialPageRoute(builder: (context) => const HomePage()));
          // }
        } else {
          return null;
        }
      },
      child: const Text("REGISTER"),
    );
  }

  Widget createLoginButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginPage()));
      },
      child: const Text("LOGIN"),
    );
  }

  Widget createRegisterForm() {
    return Form(
      key: _formKey,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blueAccent,
            ),
            borderRadius: BorderRadius.circular(10),
            color: Colors.white),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(children: [
              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              createUsernameTextField(),
              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              createPasswordTextField(),
              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              createRetypePasswordTextField(),
              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              createNameTHTextField(),
              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              createNameENTextField(),
              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              createImageUrlTextField(),
              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            ]),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              createLoginButton(),
              const Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
              createSubmitButton(),
            ],
          )
        ]),
      ),
    );
  }
}
