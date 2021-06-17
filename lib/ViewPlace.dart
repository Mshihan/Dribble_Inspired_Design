import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelui1/Animations/FadeAnimation.dart';
import 'package:travelui1/Animations/FadeAnimationCross.dart';
import 'package:travelui1/parameters.dart';

class ViewPlace extends StatefulWidget {
  ViewPlace({this.imageUrl});

  final String imageUrl;

  @override
  _ViewPlaceState createState() => _ViewPlaceState();
}

class _ViewPlaceState extends State<ViewPlace> with TickerProviderStateMixin {
  //Scale Animation Controller and animation
  AnimationController _controller;
  Animation<double> _animation;

  //BackImage Filter Property Animation Parameter
  double backfilter;

  //Content View Triger
  bool viewContent = false;

  //Page Number
  int pageNumber = 1;

  //Background Image Animation Height Parameter
  double backImageHeight;

  //Details page Opacity Changer
  double pageApearOpacity = 1.0;

  //Days Tag Animation Positions
  double daysTagTopPadding;
  double daysTagLeftPadding;

  //Distance Tag Animation Positions
  double distanceTagTopPadding;
  double distanceTagLeftPadding;

  //Bottom Sheet Animation Height Parameter
  double bottomSheetHeight;
  IconData loveIcon = FontAwesomeIcons.heart;
  Color loveIconColor = Colors.black54;

  //Activate page State after Delaying 200 milliseconds
  Future<void> sleep1() {
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        viewContent = true;
        backfilter = 1.0;
        _controller.forward();
      });
    });
  }

  //Back Button Manipulaion
  Future<bool> _willPopScope() async {
    if (pageNumber == 2) {
      setState(() {
        pageNumber = 1;
      });
      return false;
    } else {
      return true;
    }
  }

  @override
  void initState() {
    super.initState();
    sleep1();
    backfilter = 0.0;
    _controller = AnimationController(
        duration: Duration(milliseconds: 600), vsync: this, value: 0.2);
    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.bounceInOut);
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery
        .of(context)
        .size
        .height;
    double width = MediaQuery
        .of(context)
        .size
        .width;

    //Manipulating Parameters Related To Page Number
    switch (pageNumber) {
      case 1:
        backImageHeight = height;
        pageApearOpacity = 1.0;
        daysTagLeftPadding = 30;
        daysTagTopPadding = 340;
        distanceTagTopPadding = 340;
        distanceTagLeftPadding = 150;
        bottomSheetHeight = height;
        break;
      case 2:
        backImageHeight = 350;
        pageApearOpacity = 0.0;
        daysTagLeftPadding = 30;
        daysTagTopPadding = 200;
        distanceTagTopPadding = 240;
        distanceTagLeftPadding = 30;
        bottomSheetHeight = 280;
        break;
    }

    return WillPopScope(
      onWillPop: _willPopScope,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            //Background Image
            AnimatedContainer(
              duration: Duration(milliseconds: 700),
              curve: Curves.fastOutSlowIn,
              height: backImageHeight,
              width: width,
              child: Hero(
                tag: widget.imageUrl,
                child: Image.asset(
                  widget.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            //BackFilter
            AnimatedOpacity(
              opacity: backfilter,
              curve: Curves.easeIn,
              duration: Duration(milliseconds: 1000),
              child: Container(
                height: height,
                width: width,
                color: widget.imageUrl == screenOneUrl
                    ? Colors.black38
                    : Colors.black26,
              ),
            ),
            //Top Bar
            Positioned(
              top: 50,
              child: Container(
                width: width,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        if (pageNumber == 2) {
                          setState(() {
                            pageNumber = 1;
                            backfilter = 1.0;
                          });
                        } else {
                          Navigator.pop(context);
                        }
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: widget.imageUrl != screenThreeUrl
                              ? Color(0xFF0245FF).withOpacity(0.5)
                              : Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0, 3),
                                blurRadius: 5)
                          ],
                        ),
                        child: Icon(
                          Icons.keyboard_backspace,
                          color: widget.imageUrl != screenThreeUrl
                              ? Colors.white
                              : Colors.black54,
                          size: 20,
                        ),
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: widget.imageUrl != screenThreeUrl
                            ? Color(0xFF0245FF).withOpacity(0.5)
                            : Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0, 3),
                              blurRadius: 5)
                        ],
                      ),
                      child: Icon(
                        Icons.more_vert,
                        color: widget.imageUrl != screenThreeUrl
                            ? Colors.white
                            : Colors.black54,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //Title
            FadeAnimation(
              delay: 0.1,
              child: AnimatedOpacity(
                opacity: pageApearOpacity,
                duration: Duration(milliseconds: 200),
                curve: Curves.easeIn,
                child: Container(
                  margin: EdgeInsets.only(top: 210, left: 30),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  width: 200,
                  child: ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                      child: Text(
                        getTitle(),
                        textAlign: TextAlign.left,
                        style: GoogleFonts.sriracha(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          height: 1.2,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            //Days Tag
            FadeAnimation(
              delay: 0.3,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 450),
                curve: Curves.easeInOut,
                margin: EdgeInsets.only(
                    top: daysTagTopPadding, left: daysTagLeftPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.access_time,
                      color: Colors.white,
                      size: 25,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      getDays(),
                      style: GoogleFonts.sriracha(
                          color: Colors.white, fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
            //Distance Tag
            FadeAnimation(
              delay: 0.4,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 450),
                curve: Curves.easeInOut,
                margin: EdgeInsets.only(
                    top: distanceTagTopPadding, left: distanceTagLeftPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.outlined_flag,
                      color: Colors.white,
                      size: 25,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      getDistance(),
                      style: GoogleFonts.sriracha(
                          color: Colors.white, fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
            //Description
            GestureDetector(
              onTap: () {
                setState(() {
                  pageNumber = 2;
                  backfilter = 0.0;
                });
              },
              child: FadeAnimation(
                delay: 0.7,
                child: AnimatedOpacity(
                  opacity: pageApearOpacity,
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeIn,
                  child: Container(
                    margin: EdgeInsets.only(top: 390, left: 30),
                    width: 300,
                    child: Text(
                      getParagraph(),
                      style: GoogleFonts.sriracha(
                        color: Colors.white,
                        fontSize: 16,
                        height: 1.2,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            //Tags - DeepDive
            widget.imageUrl == screenTwoUrl
                ? ScaleTransition(
              scale: _animation,
              alignment: Alignment.center,
              child: AnimatedOpacity(
                opacity: pageApearOpacity,
                duration: Duration(milliseconds: 200),
                curve: Curves.easeIn,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 550, left: 290),
                      child: Text(
                        'Deep dive',
                        style: GoogleFonts.sriracha(
                            color: Colors.white, fontSize: 20),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 290),
                        padding: EdgeInsets.symmetric(
                            horizontal: 2, vertical: 4),
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: BackdropFilter(
                            filter:
                            ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.favorite_border,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '151',
                                  style: GoogleFonts.sriracha(
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            )
                : Container(),
            //Tags - Beach
            widget.imageUrl == screenTwoUrl
                ? ScaleTransition(
              scale: _animation,
              child: AnimatedOpacity(
                opacity: pageApearOpacity,
                duration: Duration(milliseconds: 200),
                curve: Curves.easeIn,
                child: Column(
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(top: 80, left: 170),
                        padding: EdgeInsets.symmetric(
                            horizontal: 2, vertical: 4),
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: BackdropFilter(
                            filter:
                            ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.favorite_border,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '290',
                                  style: GoogleFonts.sriracha(
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        )),
                    Container(
                      margin: EdgeInsets.only(left: 170),
                      child: Text(
                        'Beach View',
                        style: GoogleFonts.sriracha(
                            color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            )
                : Container(),
            //Tags - BeachResort
            widget.imageUrl == screenOneUrl
                ? ScaleTransition(
              scale: _animation,
              child: AnimatedOpacity(
                opacity: pageApearOpacity,
                duration: Duration(milliseconds: 200),
                curve: Curves.easeIn,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                        left: 290,
                        top: 210,
                      ),
                      child: Text(
                        'Beach Resort',
                        style: GoogleFonts.sriracha(
                            color: Colors.white, fontSize: 20),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 290),
                        padding: EdgeInsets.symmetric(
                            horizontal: 2, vertical: 4),
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: BackdropFilter(
                            filter:
                            ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.favorite_border,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '1150',
                                  style: GoogleFonts.sriracha(
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            )
                : Container(),
            //Tags - Deep Dive
            widget.imageUrl == screenOneUrl
                ? ScaleTransition(
              scale: _animation,
              alignment: Alignment.center,
              child: AnimatedOpacity(
                opacity: pageApearOpacity,
                duration: Duration(milliseconds: 200),
                curve: Curves.easeIn,
                child: Column(
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(
                          left: 290,
                          top: 550,
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 2, vertical: 4),
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: BackdropFilter(
                            filter:
                            ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.favorite_border,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '151',
                                  style: GoogleFonts.sriracha(
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        )),
                    Container(
                      margin: EdgeInsets.only(left: 290),
                      child: Text(
                        'Deep dive',
                        style: GoogleFonts.sriracha(
                            color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            )
                : Container(),
            //ListView
            AnimatedOpacity(
              opacity: pageApearOpacity,
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              child: Container(
                margin: EdgeInsets.only(top: 650),
                height: 220,
                width: width,
                child: getListView(),
              ),
            ),

            //Bottom Sheet
            AnimatedContainer(
              curve: Curves.fastOutSlowIn,
              transform: Matrix4.translationValues(0, bottomSheetHeight, 1),
              duration: Duration(milliseconds: 700),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  )),
              width: width,
              child: pageNumber == 2
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeAnimationCross(
                    delay: 0.5,
                    child: Container(
                      width: width,
                      margin: EdgeInsets.only(
                        left: 30,
                        top: 20,
                      ),
                      child: Container(
                        child: Text(
                          getTitle(),
                          style: GoogleFonts.sriracha(
                              color: Colors.black54,
                              fontSize: 40,
                              height: 1.2),
                        ),
                      ),
                    ),
                  ),
                  FadeAnimationCross(
                    delay: 0.6,
                    child: Container(
                      margin:
                      EdgeInsets.only(left: 30, top: 10, right: 30),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        getParagraph(),
                        style: GoogleFonts.sriracha(
                          color: Colors.black45,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        //Comment Tag
                        FadeAnimationCross(
                          delay: 0.7,
                          child: Container(
                            width: 80,
                            padding: EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.black.withOpacity(0.05)),
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    FontAwesomeIcons.comment,
                                    color: Colors.black54,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '24',
                                    style: GoogleFonts.sriracha(
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        //Love Tag
                        FadeAnimationCross(
                          delay: 0.75,
                          child: GestureDetector(
                            onTap: (){
                              if(loveIcon == FontAwesomeIcons.heart){
                                setState(() {
                                  loveIcon = FontAwesomeIcons.solidHeart;
                                  loveIconColor = Colors.red;
                                });
                              }else{
                                setState(() {
                                  loveIcon = FontAwesomeIcons.heart;
                                  loveIconColor = Colors.black54;
                                });
                              }
                            },
                            child: Container(
                              width: 80,
                              padding: EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.black.withOpacity(0.05)),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      loveIcon,
                                      color: loveIconColor,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '24',
                                      style: GoogleFonts.sriracha(
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        //Star Tag
                        FadeAnimationCross(
                          delay: 0.9,
                          child: Container(
                            width: 80,
                            padding: EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.black.withOpacity(0.05)),
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.star_border,
                                    color: Colors.black54,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '24',
                                    style: GoogleFonts.sriracha(
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        //CircleDot Icon
                        FadeAnimationCross(
                          delay: 1.1,
                          child: Container(
                            width: 80,
                            padding: EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.black.withOpacity(0.05)),
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.adjust,
                                    color: Colors.black54,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '24',
                                    style: GoogleFonts.sriracha(
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //Profile Pictures Row
                  Container(
                    height: 60,
                    width: width,
                    margin: EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 5,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            FadeAnimationCross(
                              delay: 0.85,
                              child: Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black38,
                                        offset: Offset(0, 3),
                                        blurRadius: 5),
                                  ],
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      image: AssetImage(
                                        'assets/images/propics/profilePic1.jpg',
                                      ),
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            FadeAnimationCross(
                              delay: 0.9,
                              child: Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black38,
                                        offset: Offset(0, 3),
                                        blurRadius: 5),
                                  ],
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      image: AssetImage(
                                        'assets/images/propics/profileP'
                                            'ic2.jpg',
                                      ),
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            FadeAnimationCross(
                              delay: 1.0,
                              child: Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black38,
                                        offset: Offset(0, 3),
                                        blurRadius: 5),
                                  ],
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      image: AssetImage(
                                        'assets/images/propics/profileP'
                                            'ic3.jpg',
                                      ),
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ),
                          ],
                        ),
                        FadeAnimationCross(
                          delay: 1.0,
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                color: widget.imageUrl != screenThreeUrl
                                    ? Colors.lightBlueAccent
                                    .withOpacity(0.1)
                                    : Colors.lightGreenAccent
                                    .withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color:
                                    widget.imageUrl != screenThreeUrl
                                        ? Colors.lightBlueAccent
                                        .withOpacity(0.2)
                                        : Colors.lightGreenAccent
                                        .withOpacity(0.2),
                                    width: 1)),
                            child: Icon(
                              Icons.more_horiz,
                              size: 35,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //Tour Conformation and Destination Tags
                  Container(
                    height: 250,
                    margin: EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                      color: widget.imageUrl != screenThreeUrl
                          ? Colors.lightBlueAccent.withOpacity(0.3)
                          : Colors.lightGreenAccent.withOpacity(0.3),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        //Title Location Container
                        FadeAnimationCross(
                          delay: 1.3,
                          child: Container(
                            height: 100,
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 13),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: <Widget>[
                                //From Title And Icon
                                Container(
                                  margin: EdgeInsets.only(left: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        height: 70,
                                        width: 70,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(100),
                                          color: widget.imageUrl !=
                                              screenThreeUrl
                                              ? Colors.lightBlueAccent
                                              .withOpacity(0.3)
                                              : Colors.lightGreenAccent
                                              .withOpacity(0.3),
                                        ),
                                        child: Icon(
                                          Icons.location_on,
                                          color: Colors.black38,
                                          size: 30,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 13,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            'From',
                                            style: GoogleFonts.sriracha(
                                                color: Colors.black45,
                                                fontSize: 16),
                                          ),
                                          Text(
                                            'Srilanka',
                                            style: GoogleFonts.sriracha(
                                              color: Colors.black54,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                //Middle Bar
                                Container(
                                  height: 80,
                                  width: 5,
                                  decoration: BoxDecoration(
                                    color: Colors.black26,
                                    borderRadius:
                                    BorderRadius.circular(20),
                                  ),
                                ),
                                //To Title Bar
                                Container(
                                  margin: EdgeInsets.only(right: 30),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'From',
                                        style: GoogleFonts.sriracha(
                                            color: Colors.black45,
                                            fontSize: 16),
                                      ),
                                      Text(
                                        getTitle().substring(
                                            0, getTitle().indexOf(' ')),
                                        style: GoogleFonts.sriracha(
                                          color: Colors.black54,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        //Tour Conformation Button
                        FadeAnimationCross(
                          delay: 1.5,
                          child: Container(
                            height: widget.imageUrl == screenThreeUrl
                                ? 55
                                : 80,
                            width: width,
                            margin: EdgeInsets.only(
                                top: 3, left: 10, right: 10, bottom: 3),
                            decoration: BoxDecoration(
                              color: widget.imageUrl != screenThreeUrl
                                  ? Colors.blue.withOpacity(0.5)
                                  : Colors.black.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                'Commence The '
                                    'Tour',
                                style: GoogleFonts.sriracha(
                                    color: Colors.white, fontSize: 25),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
                  : Container(),
            ),

            //Telegram Icon
            pageNumber == 2 ? FadeAnimationCross(
              delay: 0.15,
              child: Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      blurRadius: 10,
                      spreadRadius: 3
                    )
                  ],
                  color: Colors.white,
                ),
                margin: EdgeInsets.only(top: 260, left: 320),
                child: Icon(FontAwesomeIcons.telegramPlane, size: 30, color:
                    widget.imageUrl != screenThreeUrl ?
                Colors.blueAccent : Colors.green[900],),
              ),
            ) : Container(),
          ],
        ),
      ),
    );
  }

  ListView getListView() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, position) {
        if (widget.imageUrl == screenOneUrl) {
          return FadeAnimation(
            delay: 1.0 + (position * 0.1),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                    image: AssetImage(indonesiaImageList[position]),
                    fit: BoxFit.cover,
                  )),
              height: 210,
              width: 150,
            ),
          );
        } else if (widget.imageUrl == screenTwoUrl) {
          return FadeAnimation(
            delay: 1.0 + (position * 0.1),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                    image: AssetImage(maldivesImageList[position]),
                    fit: BoxFit.cover,
                  )),
              height: 210,
              width: 150,
            ),
          );
        } else {
          return FadeAnimation(
            delay: 1.0 + (position * 0.1),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                image: DecorationImage(
                  image: AssetImage(kashmir[position]),
                  fit: BoxFit.cover,
                ),
              ),
              height: 210,
              width: 150,
            ),
          );
        }
      },
      itemCount: 6,
    );
  }

  String getTitle() {
    if (widget.imageUrl == screenOneUrl) {
      return screenOneTitle;
    } else if (widget.imageUrl == screenTwoUrl) {
      return screenSecondTitle;
    } else {
      return screenThreeTitle;
    }
  }

  String getDays() {
    if (widget.imageUrl == screenOneUrl) {
      return screenOneDays;
    } else if (widget.imageUrl == screenTwoUrl) {
      return screenSecondDays;
    } else {
      return screenThreeDays;
    }
  }

  String getDistance() {
    if (widget.imageUrl == screenOneUrl) {
      return screenOneDistance;
    } else if (widget.imageUrl == screenTwoUrl) {
      return screenSecondDistance;
    } else {
      return screenThreeDistance;
    }
  }

  String getParagraph() {
    if (widget.imageUrl == screenOneUrl) {
      return screenOneParagraph;
    } else if (widget.imageUrl == screenTwoUrl) {
      return screenSecondParagraph;
    } else {
      return screenThreeParagraph;
    }
  }
}
