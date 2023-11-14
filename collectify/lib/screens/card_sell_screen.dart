import 'package:flutter/material.dart';

class CardSellPage extends StatefulWidget {
  @override
  State<CardSellPage> createState() => _CardSellPageState();
}

class _CardSellPageState extends State<CardSellPage>
    with TickerProviderStateMixin {
  double _sliderValue = 50.0;

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 2, vsync: this);

    return Column(
      children: [
      Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: Colors.amber),
        padding: EdgeInsets.all(16.0),
        child: Align(
          alignment: Alignment.center,
          child: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            tabs: [Text('Auction'), Text('Quick Sell')],
            controller: _tabController,
          ),
        ),
      ),
      Container(
        width: double.maxFinite,
        height: 300,
        child: TabBarView(controller: _tabController, children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Satışa Çıkar',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.lightBlueAccent,
                ),
              ),
              SizedBox(height: 20),
              Slider(
                value: _sliderValue,
                min: 0,
                max: 100,
                onChanged: (value) {
                  setState(() {
                    _sliderValue = value;
                  });
                },
              ),
              SizedBox(height: 20),
              Text(
                'Price: ${_sliderValue.toStringAsFixed(1)}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Butona tıklandığında yapılacak işlemler
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlueAccent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      elevation: 3,
                    ),
                    child: Text('Satışı Tamamla'),
                  ),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Satışa Çıkar',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.lightBlueAccent,
                ),
              ),
              SizedBox(height: 20),
              Slider(
                value: _sliderValue,
                min: 0,
                max: 100,
                onChanged: (value) {
                  setState(() {
                    _sliderValue = value;
                  });
                },
              ),
              SizedBox(height: 20),
              Text(
                'Price: ${_sliderValue.toStringAsFixed(1)}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Butona tıklandığında yapılacak işlemler
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlueAccent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      elevation: 3,
                    ),
                    child: Text('Satışı Tamamla'),
                  ),
                ),
              ),
            ],
          ),
        ]),
      )
    ]);
  }
}
