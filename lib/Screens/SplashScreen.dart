import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'WorldStats.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> with TickerProviderStateMixin{
  
  late final AnimationController _controller= AnimationController(
    duration: Duration(seconds: 3),
      vsync: this)..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
  
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>WorldStatesScreen())));

  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
        body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AnimatedBuilder(
                    animation: _controller,
                    child: Container(
                      height: 200,
                      width: 200,
                      child: Container(
                        child: Image(image: AssetImage("assets/images/virus.png")),
                      ),
                    ),
                    builder: (BuildContext context,Widget? child){
                      return Transform.rotate(
                          angle: _controller.value * 2.0 * math.pi,
                        child: child,
                      );
                    } ),
                SizedBox(height: MediaQuery.of(context).size.height*0.08,),
                Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Covid-',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.white,)
                              ),
                              Text('19',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.red,)
                              ),
                            ],
                          ),
                        ),
                        Text('Tracker App',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.white,)
                        ),
                      ],
                    ),
                ),
              ],
            ),
        ),
    );
  }
}
