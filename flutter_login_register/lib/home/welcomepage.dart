import 'package:flutter/material.dart';
import 'package:myapp_week5/login/login_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg2.jpg'),
            fit: BoxFit.cover,
          ),
        ),
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
              "WELCOME",
              style: TextStyle(
                  // backgroundColor: Colors.green,
                  color: Colors.white,
                  fontSize: 30,
                  fontFamily: 'Arial Rounded MT Bold'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
              child: const Text("Next >>"),
            )
          ],
        ),
      ),
    ));
  }
}
