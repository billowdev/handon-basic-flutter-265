import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:localstorage/localstorage.dart';
import 'package:http/http.dart' as http;

class ProductDetailPage extends StatefulWidget {
  final String id;
  const ProductDetailPage({super.key, required this.id});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState(id: id);
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final String id;
  var productData = [];
  int productLength = 0;
  _ProductDetailPageState({required this.id});
  final LocalStorage storage = LocalStorage('user-key');
  static String apiUrl = dotenv.env['API_URL'].toString();

  @override
  void initState() {
    super.initState();
    _getProduct();
  }

  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Product detail $id'),
      ),
      body: ListView.separated(
        itemCount: productLength,
        itemBuilder: (context, index) {
          return ListTile(
            // leading: Container(
            //   width: 80,
            //   height: 80,
            //   decoration: BoxDecoration(
            //       shape: BoxShape.rectangle,
            //       image: DecorationImage(
            //           image: NetworkImage('${productData[index]['picture']}'))),
            // ),
            title: Text('${productData[index]['ch_title']}'),
            subtitle: Text(
                '${productData[index]['ch_title']} วันที่ ${productData[index]['ch_dateadd']}\nระยะเวลา ${productData[index]['ch_timetotal']}'),
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

    var urlNews = Uri.http(apiUrl, '/api/product/${id}');
    String accessToken = storage.getItem('user-key');

    var header = {
      'Content-Type': 'application/json',
      'Authorization': accessToken
    };
    final response = await http.get(urlNews, headers: header);
    if (response.statusCode == 200) {
      setState(() {
        var productDetail = jsonDecode(response.body);
        productData = productDetail['data'];
        productLength = productData.toList().length;
        print("==============");
        print(productData);
        print("==============");
        // products = jsonDecode(response.body);
      });
    }
  }
}
