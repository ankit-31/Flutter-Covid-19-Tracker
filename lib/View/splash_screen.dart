import 'dart:async';

import 'package:flutter/material.dart';

import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
    vsync: this,
    duration: Duration(seconds: 3),



  );

  @override
  void initState() {

    // TODO: implement initState
    super.initState();

    controller.repeat();//to start animation
    Future.delayed(Duration(seconds: 3)).then((value){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   //   appBar: AppBar(),
      backgroundColor: Color(0xFFF8F9FA),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [

          AnimatedBuilder(
            animation: controller,

            builder: (BuildContext context, Widget? child) {
              return Transform.rotate(angle: controller.value*3.14*2, child: child);
            },
            child: Container(
              color: Color(0xFFF8F9FA),
             // height: double.infinity,

              child: Image.asset('assets/images/corona.png',fit: BoxFit.fitWidth,),



            ),
          ),
          SizedBox(height: 30,),
          Text('Covid -19\nTracker App',style: TextStyle(color: Colors.black,fontSize: 24,fontWeight: FontWeight.w600),)

        ],
      ),
    );
  }
}
