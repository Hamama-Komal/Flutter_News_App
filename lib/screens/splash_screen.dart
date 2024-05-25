
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(Duration(seconds: 2), (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/news.png",
            height: height * 0.2,
            // width: width * 0.32,
            fit: BoxFit.cover,
          ),
          SizedBox(height: height * 0.04,),
          Text("Top headlines", style: GoogleFonts.anton(letterSpacing: 0.6,color: Colors.grey.shade700, fontSize:25),),
          SizedBox(height: height * 0.04,),
          const SpinKitRipple(
            color: Colors.blue,
            size: 50,
          )
        ],
      ),
    );
  }
}
