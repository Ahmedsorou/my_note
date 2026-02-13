import 'package:flutter/material.dart';
import 'package:my_note/note_app/note_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState(){
    super.initState();
    goToHome();
  }
  void goToHome(){
    Future.delayed(Duration(seconds: 3),(){
      Navigator.pushReplacement(
          context,MaterialPageRoute(builder: (c)=>NoteScreen(),
      ));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade400,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Image.asset("assets/image/1024824.png"))
        ],
      ),

    );
  }
}
