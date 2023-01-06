import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_23_12_2022/models/news.model.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  void initState() {
    super.initState();
    _getNews();
  }

  List<Articles> news = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('หน้าข่าววันนี้'),
      ),
      body: ListView.separated(
        itemCount: news.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                      image: NetworkImage('${news[index].urlToImage}'))),
            ),
            title: Text('${news[index].title}'),
            subtitle: Text('${news[index].description}'),
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

  _getNews() async {
    var queryParam = {
      "country": "th",
      "apiKey": "your-api-key"
    };
    var urlNews = Uri.http('newsapi.org', '/v2/top-headlines', queryParam);

    final response = await http.get(urlNews);

    if (response.statusCode == 200) {
      // NewsModel newsData2 = jsonDecode(response.body);
      // print("================== response ==========================");
      // print(newsData2);
      // print("============================================");
      Newsmodel newsData = Newsmodel.fromJson(jsonDecode(response.body));
      // print("==================== jsonDecode ========================");
      // print(newsData.articles);
      // print("============================================");

      // NewsModel newsData = jsonDecode(response.body);

      setState(() {
        news = newsData.articles!;
        // news = jsonDecode(response.body)?.articles!;
      });
    }
  }
}
