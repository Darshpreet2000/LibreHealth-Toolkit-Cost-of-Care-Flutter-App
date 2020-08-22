import 'package:curativecare/main.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';

class IntroScreen extends StatefulWidget {
  IntroScreen({Key key}) : super(key: key);

  @override
  IntroScreenState createState() => new IntroScreenState();
}

class IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = new List();

  @override
  void initState() {
    super.initState();

    slides.add(
      new Slide(
        title: "Welcome \n To \n Cost Of Care",
        maxLineTitle: 3,
        styleTitle: TextStyle(
            color: Color(0xffD02090),
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        description:
            "We care for you by providing cost estimates for medical procedures of your nearby hospitals in US",
        styleDescription: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'Raleway'),
        pathImage: "assets/app_icon_ideas.png",
        colorBegin: Colors.white,
        colorEnd: Colors.orange,
        directionColorBegin: Alignment.topCenter,
        directionColorEnd: Alignment.bottomCenter,
        maxLineTextDescription: 5,
      ),
    );
    slides.add(
      new Slide(
        title: "Compare Price Of Medical Procedures",
        maxLineTitle: 3,
        styleTitle: TextStyle(
            color: Color(0xffD02090),
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        description:
            "Either view CDM of a hospital or compare prices from lots of different hospitals, this App handles everything perfectly",
        styleDescription: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'Raleway'),
        pathImage: "assets/intro2.jpg",
        colorBegin: Colors.white,
        colorEnd: Colors.indigo,
        directionColorBegin: Alignment.topRight,
        directionColorEnd: Alignment.bottomLeft,
        maxLineTextDescription: 5,
      ),
    );
    slides.add(
      new Slide(
        title: "Compare Hospitals by Ratings & Patient Experience",
        maxLineTitle: 3,
        styleTitle: TextStyle(
            color: Color(0xffD02090),
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        description:
            "With medicare data, we provide functionality to compare hospitals by general information & patient reviews",
        styleDescription: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'Raleway'),
        pathImage: "assets/hospital_compare.jpg",
        colorBegin: Colors.white,
        colorEnd: Colors.pinkAccent,
        directionColorBegin: Alignment.topCenter,
        directionColorEnd: Alignment.bottomCenter,
        maxLineTextDescription: 5,
      ),
    );
  }

  void onDonePress() {
    box.put('introDisplayed', true);
    Navigator.popAndPushNamed(context, '/BaseClass');
  }

  Widget renderNextBtn() {
    return Text(
      'Next',
      style: TextStyle(
        color: Colors.white,
      ),
    );
  }

  Widget renderDoneBtn() {
    return Text(
      'Let\'s Go',
      style: TextStyle(
        color: Colors.white,
      ),
    );
  }

  Widget renderSkipBtn() {
    return Text(
      'Skip',
      style: TextStyle(
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      // List slides
      slides: this.slides,

      // Skip button
      renderSkipBtn: this.renderSkipBtn(),
      colorSkipBtn: Color(0x33000000),
      highlightColorSkipBtn: Color(0xff000000),

      // Next button
      renderNextBtn: this.renderNextBtn(),

      // Done button
      renderDoneBtn: this.renderDoneBtn(),
      onDonePress: this.onDonePress,
      colorDoneBtn: Color(0x33000000),
      highlightColorDoneBtn: Color(0xff000000),

      // Dot indicator
      colorDot: Colors.black,
      colorActiveDot: Colors.white,
      sizeDot: 13.0,

      // Show or hide status bar
      backgroundColorAllSlides: Colors.grey,
    );
  }
}
