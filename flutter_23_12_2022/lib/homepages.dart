import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_23_12_2022/newspages.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(title: const Text('หน้าหลัก')),
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 100,
                    margin: const EdgeInsets.all(10.0),
                    // padding: EdgeInsets.symmetric(vertical: 100),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(184, 44, 203, 57),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ListTile(
                      leading: Icon(
                        Icons.newspaper,
                        size: 40,
                      ),
                      title: Text(
                        'ข่าววันนี้',
                        style: TextStyle(fontSize: 20),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const NewsPage()))
                      },
                    ),
                  )
                ],
              ),
            )));
  }
}
