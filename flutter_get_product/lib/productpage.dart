import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_23_12_2022/models/news.model.dart';
import 'package:flutter_23_12_2022/models/product.model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});
  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final LocalStorage token = LocalStorage('user-key');

  @override
  void initState() {
    super.initState();
    _getProduct();
  }

  // List<dynamic>? products;
  var products = [];
  int productLength = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('หน้าสินค้า'),
      ),
      body: ListView.separated(
        itemCount: productLength,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                      image: NetworkImage('${products[index]['picture']}'))),
            ),
            title: Text('${products[index]['title']}'),
            subtitle: Text(
                '${products[index]['detail']}\nวันที่ ${products[index]['date']}\nจำนวนคนดู: ${products[index]['view']}'),
            onTap: () async {
              // Uri urlx = Uri.parse("${news[index].url}");
              // await launchUrl(urlx);
            },
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      ),
    ));
  }

  _getProduct() async {
    // var queryParam = {"country": "th", "apiKey": "your-api-key"};
    var urlNews = Uri.http('apiurl', '/api/product');
    String accessToken = token.getItem('user-key');
    print("${dotenv.env['API_URL']}");
    var header = {
      'Content-Type': 'application/json',
      'Authorization': accessToken
    };
    final response = await http.get(urlNews, headers: header);
    if (response.statusCode == 200) {
      setState(() {
        products = jsonDecode(response.body);
        productLength = products.toList().length;
        // products = jsonDecode(response.body);
      });
    }
  }
}
