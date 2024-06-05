import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ArticlePage extends StatelessWidget {
  final int id;
  get localhost =>
      Platform.isAndroid ? 'http://10.0.2.2:5074' : 'http://localhost:5074';

  const ArticlePage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Article>(
      future: fetchArticle(id),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final article = snapshot.data!;
          return Scaffold(
            appBar: buildAppBar(),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  buildTopBar(),
                  const SizedBox(height: 16.0),
                  buildArticleImage(article.imageUrl),
                  const SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      article.title,
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Text(
                          article.date.toIso8601String(),
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        const Spacer(),
                        const Icon(Icons.visibility),
                        const SizedBox(width: 4.0),
                        Text(article.views.toString()),
                        const SizedBox(width: 16.0),
                        const Icon(Icons.comment),
                        const SizedBox(width: 4.0),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      article.content,
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/logoH.png',
            height: 40,
          ),
          const SizedBox(width: 8),
          const Text(
            'Haberto',
            style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal,
              fontSize: 30,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: () {
            // Bildirim ikonu işlemi
          },
        ),
      ],
    );
  }

  Widget buildArticleImage(String imageUrl) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Image.network(
          '$localhost/api/images/$imageUrl',
          height: 200,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Padding buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            icon: const Icon(Icons.bookmark_border, color: Colors.black),
            onPressed: () {
              // Yer imi butonu işlemi
            },
          ),
          IconButton(
            icon: const Icon(Icons.share, color: Colors.black),
            onPressed: () {
              // Paylaşma butonu işlemi
            },
          ),
          IconButton(
            icon: const Icon(Icons.download, color: Colors.black),
            onPressed: () {
              // İndir butonu işlemi
            },
          ),
        ],
      ),
    );
  }

  Future<Article> fetchArticle(int id) async {
    final response =
        await http.get(Uri.parse('$localhost/api/News/GetNewsById/$id'));
    if (response.statusCode == 200) {
      return Article.fromJson(jsonDecode(response.body)[0]);
    } else {
      throw Exception('Failed to fetch article');
    }
  }
}

class Article {
  final int id;
  final String title;
  final String content;
  final String imageUrl;
  final DateTime date;
  final int views;
  final String category;
  final int authorId;
  final String author;

  Article({
    required this.id,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.date,
    required this.views,
    required this.category,
    required this.authorId,
    required this.author,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['articleID'],
      title: json['articleTitle'],
      content: json['articleContent'],
      imageUrl: json['articleImageURL'],
      date: DateTime.parse(json['articlePublishedDate']),
      views: json['articleView'],
      category: json['categoryName'],
      authorId: json['authorID'],
      author: json['author'],
    );
  }
}
/*[
  {
    * "articleID": 1903,
    * "articleTitle": "Okulların açılmasına kaç gün kaldı? Okullar ne zaman açılacak? MEB 2023 -2024 takvimi paylaştı",
    * "articleContent": "MEB (Milli Eğitim Bakanlığı) yeni eğitim öğretim yılına ilişkin önemli tarihleri paylaştı. Buna göre, öğretmenlerin mesleki çalışmaları, yeni eğitim ve öğretim yılında 4 Eylül 2023 Pazartesi başlayacak. Birinci dönem, 11 Eylül 2023 Pazartesi başlayıp 19 Ocak 2024 Cuma sona erec6 Şubat 2023'te Kahramanmaraş'ta meydana gelen ve 11 ili etkileyen deprem sebebiyle afet bölgesi illeri olarak belirlenen Adana, Adıyaman, Diyarbakır, Elazığ, Gaziantep, Hatay, Kahramanmaraş, Kilis, Malatya, Osmaniye ve Şanlıurfa illerindeki resmi ve özel okullarda 2022-2023 eğitim-öğretim yılının ikinci dönemine yönelik öğrenme kayıplarının giderilmesi amacıyla bakanlıkça hazırlanacak program 11 Eylül ile 6 Ekim arasında eğitim ve öğretim faaliyetleri ile birlikte uygulanacak.2023-2024 eğitim öğretim yılında okul öncesi eğitim ile ilkokul 1. sınıfa başlayacak öğrenciler için 4-8 Eylül 2023'te uyum eğitimleri gerçekleştirilecek.Birinci dönem ara tatili, 13 Kasım 2023 Pazartesi başlayacak ve 17 Kasım 2023 Cuma sona erecek.<br><br>Yarıyıl tatili, 22 Ocak 2024 Pazartesi başlayıp 2 Şubat 2024 Cuma tamamlanacak.<br><br>İkinci dönem, 5 Şubat 2024 Pazartesi başlayacak ve 14 Haziran 2024 Cuma sona erecek. İkinci dönem ara tatili ise 8 Nisan 2024 Pazartesi ile 12 Nisan 2024 Cuma tarihleri arasında yapılacak.<br><br>Ortaokul ve imam hatip ortaokullarının 5. sınıfları, ortaöğretim kurumlarının hazırlık ve 9. sınıfları ile pansiyonda kalacak öğrencilere yönelik okul hakkında bilgilendirme, akademik ve mesleki gelişimlerini destekleme, yeni girdikleri eğitim ortamına kısa sürede uyum sağlama amacıyla gerekli rehberlik çalışmaları yapılacak.Milli Eğitim Bakanlığı (MEB), 2023-2024 eğitim öğretim yılına ilişkin tedbirleri belirledi. Okul kıyafetlerinde daha önceden belirlenen kıyafetler tercih edilecek ve velilere külfet oluşturmamak için zaruret hali dışında değişikliğe gidilmeyecek.<strong>Rehberlik ve uyum çalışmaları yapılacak<br></strong><br>Okul kayıtları, öğretmen seçimi, teknolojik ve fiziki olanaklar ve benzeri hususlar gerekçe gösterilerek resmi okullarda eğitimde fırsat eşitliği ilkesini zedeleyecek uygulamalardan kaçınılacak.<br><br>Okul öncesi eğitim kurumlarına öncelikle 5 yaş çocukların kaydı yapılacak. Okul öncesi eğitime, ilkokul 1'inci sınıfa, mesleki ve teknik Anadolu liselerinde 9'uncu sınıfa başlayacak öğrenciler için 4-8 Eylül 2023'te uyum eğitimleri yapılacak, ortaokul ve imam hatip ortaokullarının 5'inci sınıfları ile ortaöğretim kurumlarının hazırlık ve 9'uncu sınıflarına yönelik rehberlik ve uyum çalışmaları ise 11-15 Eylül'de gerçekleştirilecek.<br><br>Velilerin okul ziyaretleri ve öğretmenlerle görüşmelerinin daha nitelikli, düzenli ve sağlıklı olması için okullar tarafından planlamalar yapılacak, ziyaretler için eğitim öğretim faaliyetlerini aksatmayacak şekilde zaman çizelgesi oluşturulacak. Görüşme ve toplantılar dışında velilerin okul içinde bulunmalarının pedagojik olarak doğru olmadığı göz önünde bulundurularak gerekli tedbirler alınacak.<br><br>Öğrencile",
    * "articleImageURL": "bAuBfrpSWkSAxH8m9mVRrA.webp",
    * "articlePublishedDate": "2023-05-28T12:40:52.347",
    * "articleView": 1000,
    * "categoryName": "Egitim",
    "authorID": 4,
    "author": "Ava Lopez"
  }
] */