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
        Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: CarouselSlider(
              items: images,
              options: CarouselOptions(
                height: 200,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 0.7
              )),
        ),
      ]),
    );
  }
}
