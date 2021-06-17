import 'dart:ui' as ui;

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:travelui1/ViewPlace.dart';
import 'package:travelui1/parameters.dart';

void main() {
  runApp(MyApp());
}

int _selectedListItem = 0;
double detailsOpacity = 1.0;
String imageUrl;
double pageOneOpacity = 1.0;
double pageTwoOpacity = 1.0;
double pageThreeOpacity = 1.0;
double opacityScreenOneContent = 1.0;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LandingPage(),
    );
  }
}

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with TickerProviderStateMixin {
  double height;
  double width;
  double positionImageTop = 240;
  double positionImageLeftRight = 42;
  double imageHeight;
  double imageWidth;
  double imageBottom;

  Future<bool> _willPopScope() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopScope,
      child: Scaffold(
        body: Column(
          children: <Widget>[
            //App Bar
            AppBarTravelling(),
            //List Bar
            Container(
              height: 60,
              margin: EdgeInsets.only(bottom: 30),
              child: ListView.builder(
                itemCount: 4,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, position) {
                  return ListViewItem(
                      function: () {
                        setState(() {});
                      },
                      position: position);
                },
              ),
            ),
            //Carousel view
            CarouselWidget(function: () {
              setState(() {});
            }),
            BottomBar(width: width),
          ],
        ),
      ),
    );
  }
}

//Bottom Bar
class BottomBar extends StatelessWidget {
  const BottomBar({
    Key key,
    @required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 99,
      width: width,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.05),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'World',
                style: GoogleFonts.sriracha(
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                height: 5,
                width: 5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.black54,
                ),
              )
            ],
          ),
          Icon(
            Icons.access_time,
            color: Colors.black54,
          ),
          Icon(
            Icons.account_balance_wallet,
            color: Colors.black54,
          ),
          Icon(
            Icons.person_outline,
            color: Colors.black54,
          ),
        ],
      ),
    );
  }
}

//Carousel widget
class CarouselWidget extends StatelessWidget {
  CarouselWidget({this.function});

  final Function function;


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return CarouselSlider(
      items: <Widget>[
        //Page One - indonesia
        AnimatedOpacity(
          opacity: pageOneOpacity,
          duration: Duration(milliseconds: 200),
          child: Stack(
            children: [
              Positioned(
                bottom: 5,
                left: 40,
                child: Container(
                  margin: EdgeInsets.only(bottom: 80),
                  height: 80,
                  width: 250,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF0A2538).withOpacity(0.5),
                        offset: Offset(0, 20),
                        blurRadius: 30,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInCirc,
                      child: ViewPlace(
                        imageUrl: screenOneUrl,
                      ),
                    ),
                  );
                },
                child: Stack(
                  children: [
                    Container(
                      height: height,
                      margin: EdgeInsets.only(top: 20, bottom: 80),
                      child: Hero(
                        tag: screenOneUrl,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.asset(
                            screenOneUrl,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 40,
                      left: 20,
                      child: AnimatedOpacity(
                        opacity: opacityScreenOneContent,
                        duration: Duration(milliseconds: 500),
                        child: Container(
                          margin: EdgeInsets.only(bottom: 80),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                'Indonesia',
                                style: GoogleFonts.pacifico(
                                  fontSize: 35,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 40),
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    Icon(
                                      Icons.star_half,
                                      color: Colors.amber,
                                    ),
                                    Icon(
                                      Icons.star_border,
                                      color: Colors.amber,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 20,
                      right: 0,
                      child: Container(
                        height: 60,
                        width: 60,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 4.0, left: 4),
                          child: Icon(
                            Icons.star_border,
                            color: Colors.white,
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black45,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            bottomLeft: Radius.circular(40),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        //Page Two - Maldives
        AnimatedOpacity(
          opacity: pageTwoOpacity,
          duration: Duration(milliseconds: 200),
          child: Stack(
            children: [
              Positioned(
                bottom: 5,
                left: 40,
                child: Container(
                  margin: EdgeInsets.only(bottom: 80),
                  height: 80,
                  width: 250,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF004058).withOpacity(0.5),
                        offset: Offset(0, 20),
                        blurRadius: 30,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInCirc,
                          child: ViewPlace(
                            imageUrl: screenTwoUrl,
                          )));
                },
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: height,
                      margin: EdgeInsets.only(top: 20, bottom: 80),
                      child: Hero(
                        tag: screenTwoUrl,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.asset(
                            screenTwoUrl,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 40,
                      left: 20,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 80),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              'Maldives',
                              style: GoogleFonts.pacifico(
                                fontSize: 35,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 40),
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                        top: 20,
                        right: 0,
                        child: Container(
                          height: 60,
                          width: 60,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 4.0, left: 4),
                            child: Icon(
                              Icons.star_border,
                              color: Colors.white,
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black45,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              bottomLeft: Radius.circular(40),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
        //Page Three - kashmir
        AnimatedOpacity(
          opacity: pageThreeOpacity,
          duration: Duration(milliseconds: 200),
          child: Stack(
            children: [
              Positioned(
                bottom: 5,
                left: 40,
                child: Container(
                  margin: EdgeInsets.only(bottom: 80),
                  height: 80,
                  width: 250,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF2A300A).withOpacity(0.5),
                        offset: Offset(0, 20),
                        blurRadius: 30,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInCirc,
                          child: ViewPlace(
                            imageUrl: screenThreeUrl,
                          )));
                },
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: height,
                      margin: EdgeInsets.only(top: 20, bottom: 80),
                      child: Hero(
                        tag: screenThreeUrl,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.asset(
                            screenThreeUrl,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 40,
                      left: 20,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 80),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              'Kashmir',
                              style: GoogleFonts.pacifico(
                                fontSize: 35,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 40),
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  Icon(
                                    Icons.star_half,
                                    color: Colors.amber,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                        top: 20,
                        right: 0,
                        child: Container(
                          height: 60,
                          width: 60,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 4.0, left: 4),
                            child: Icon(
                              Icons.star_border,
                              color: Colors.white,
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black45,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              bottomLeft: Radius.circular(40),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
      options: CarouselOptions(
        height: 550,
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: false,
        autoPlayAnimationDuration: Duration(milliseconds: 1000),
        viewportFraction: 0.8,
        onPageChanged: onPageChange,
      ),
    );
  }

  onPageChange(int index, CarouselPageChangedReason changeReason) {
    if (index == 0) {
      pageTwoOpacity = 0.5;
      pageThreeOpacity = 0.5;
      pageOneOpacity = 1.0;
    } else if (index == 1) {
      pageOneOpacity = 0.5;
      pageThreeOpacity = 0.5;
      pageTwoOpacity = 1.0;
    } else {
      pageOneOpacity = 0.5;
      pageTwoOpacity = 0.5;
      pageThreeOpacity = 1.0;
    }
    function();
  }
}

//List View Item
class ListViewItem extends StatelessWidget {
  ListViewItem({this.function, this.position});

  final int position;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _selectedListItem = position;
        function();
      },
      child: Container(
        height: 60,
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 3),
        margin: EdgeInsets.only(top: 10, bottom: 10, left: 25),
        decoration: BoxDecoration(
          color: _selectedListItem == position
              ? Color(0xFF0245FF)
              : Color(0xFFDEE7FA),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            locations[position],
            style: GoogleFonts.sriracha(
              fontSize: 20,
              color:
                  _selectedListItem == position ? Colors.white : Colors.black54,
            ),
          ),
        ),
      ),
    );
  }
}

//App Bar
class AppBarTravelling extends StatelessWidget {
  const AppBarTravelling({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 30, right: 30, top: 60, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 20),
            child: ShadowText(
              'Asia',
              style: GoogleFonts.lobster(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  letterSpacing: 1.5),
            ),
          ),
          Icon(
            Icons.apps,
            color: Colors.black,
            size: 35,
          ),
        ],
      ),
    );
  }
}

//Shadow Text
class ShadowText extends StatelessWidget {
  ShadowText(this.data, {this.style}) : assert(data != null);

  final String data;
  final TextStyle style;

  Widget build(BuildContext context) {
    return new ClipRect(
      child: new Stack(
        children: [
          new Positioned(
            top: 3.0,
            child: new Text(
              data,
              style: style.copyWith(
                color: Colors.black.withOpacity(0.2),
              ),
            ),
          ),
          new BackdropFilter(
            filter: new ui.ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: new Text(data, style: style),
          ),
        ],
      ),
    );
  }
}
