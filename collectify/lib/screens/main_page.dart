import 'package:collectify/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MainPage extends StatefulWidget {
  static String id = 'main_page_screen';

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Image> images = [
    Image.asset('images/seb1.jpeg'),
    Image.asset('images/seb2.jpeg'),
    Image.asset('images/seb3.jpeg'),
    Image.asset('images/seb4.jpeg'),
    Image.asset('images/seb5.jpeg'),
    Image.asset('images/seb6.jpeg'),
    Image.asset('images/seb7.jpeg'),
    Image.asset('images/seb8.jpeg')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text('Collectify'),
      ),
      backgroundColor: Colors.blue,
      bottomNavigationBar: myBottomNavigationBar(),
      body: Column(children: [
        Expanded(
          child: Container(
            child: Text('Favoriler',style: TextStyle(color: Colors.white),),
            height: 10,
          ),
          flex: 1,
        ),
        Expanded(
          flex: 7,
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0,bottom: 10),
            child: CarouselSlider(
                items: images,
                options: CarouselOptions(
                    height: 200,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction: 0.7)),
          ),
        ),
        Expanded(
          child: Container(
            child: Text('Fırından Yeni Çıktı',style: TextStyle(color: Colors.white)),
            height: 10,
          ),
          flex: 1,
        ),
        Expanded(
          flex: 7,
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0,bottom: 10),
            child: CarouselSlider(
                items: images,
                options: CarouselOptions(
                    height: 200,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction: 0.7)),
          ),
        ),
        Expanded(
          child: Container(
            child: Text('Son Görüntülenenler',style: TextStyle(color: Colors.white)),
            height: 10,
          ),
          flex: 1,
        ),
        Expanded(
          flex: 7,
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0,bottom: 15),
            child: CarouselSlider(
                items: images,
                options: CarouselOptions(
                    height: 200,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction: 0.7)),
          ),
        ),
      ]),
    );
  }
}
