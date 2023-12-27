import 'package:collectify/components/round_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CardSellPage extends StatefulWidget {
  @override
  State<CardSellPage> createState() => _CardSellPageState();
}

class _CardSellPageState extends State<CardSellPage>
    with TickerProviderStateMixin {
  double _auctionPrice = 50.0;
  double _quickSellPrice = 50.0;
  int hours = 0;

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 2, vsync: this);

    return Column(children: [
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
                'Start Price:',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.lightBlueAccent,
                ),
              ),
              SizedBox(height: 20),
              Slider(
                value: _auctionPrice,
                min: 0,
                max: 100,
                onChanged: (value) {
                  setState(() {
                    _auctionPrice = value;
                  });
                },
              ),
              SizedBox(height: 10),
              Text(
                '${_auctionPrice.toStringAsFixed(1)}',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 30),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RoundIconButton(
                      iconWidget: FontAwesomeIcons.minus,
                      onPressedButton: () {
                        setState(() {
                          if(hours != 0)
                            hours--;
                          else
                            hours = hours;  
                        });
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    RoundIconButton(
                      iconWidget: FontAwesomeIcons.plus,
                      onPressedButton: () {
                        setState(() {
                          hours++;
                        });
                      },
                    ),
                    SizedBox(width: 50,),
                    Text(
                      '$hours',
                      style:
                          TextStyle(fontSize: 50, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(width: 20,),
                    Text(
                      'Hours',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlueAccent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      elevation: 3,
                    ),
                    child: Text('Sell'),
                  ),
                ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Price',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.lightBlueAccent,
                ),
              ),
              SizedBox(height: 20),
              Slider(
                value: _quickSellPrice,
                min: 0,
                max: 100,
                onChanged: (value) {
                  setState(() {
                    _quickSellPrice = value;
                  });
                },
              ),
              SizedBox(height: 20),
              Text(
                '${_quickSellPrice.toStringAsFixed(1)}',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
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
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlueAccent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      elevation: 3,
                    ),
                    child: Text('Sell'),
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
