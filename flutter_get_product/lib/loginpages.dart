import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_23_12_2022/productpage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:localstorage/localstorage.dart';
import 'package:http/http.dart' as http;

import 'homepages.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final LocalStorage storage = LocalStorage('user-key');
  static String apiUrl = dotenv.env['API_URL'].toString();
  String? username;
  String? password;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/bg2.jpg'), fit: BoxFit.cover),
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
                  "LOGIN",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontFamily: 'Arial Rounded MT Bold'),
                ),
                createLoginForm(),
              ],
            ),
          )),
    ));
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

  _login(acc) async {
    var urlLogin = Uri.http(apiUrl, '/api/login');
    var header = {'Content-Type': 'application/json'};
    final response =
        await http.post(urlLogin, headers: header, body: jsonEncode(acc));

    if (response.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(response.body);
      if (res['status'] == 'ok') {
        Map<String, dynamic> userSession =
            Map<String, dynamic>.from(jsonDecode(response.body));
        String accessToken = (userSession.values.toList())[1];

        storage.setItem('user-key', accessToken);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    }
  }

  Widget createSubmitButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          // debugPrint(username);
          Map<String, dynamic> acc = {
            'username': username,
            'password': password
          };
          _login(acc);

          //   if (username == "admin" && password == "1234") {
          //     Navigator.pushReplacement(context,
          //         MaterialPageRoute(builder: (context) => const HomePage()));
          //   }
        }
      },
      child: const Text("LOGIN"),
    );
  }

  Widget createRegisterButton() {
    return ElevatedButton(
      onPressed: () {
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => const RegisterPage()));
      },
      child: const Text("REGISTER"),
    );
  }

  Widget createLoginForm() {
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
            ]),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              createRegisterButton(),
              const Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
              createSubmitButton(),
            ],
          )
        ]),
      ),
    );
  }
}
