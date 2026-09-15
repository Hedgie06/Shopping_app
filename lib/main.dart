import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Stack(children: [
            Text(
            'Shopping App',
            style: GoogleFonts.poppins(
              fontSize: 35,
              fontWeight: FontWeight.bold,
              foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 3
              ..color = Colors.white,
            ),  
            ),
            Text(
            'Shopping App',
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 35,
              fontWeight: FontWeight.bold
            ),  
            ),
          ],) ,
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        body: const Center(
          child: Text('HelloWorld'),
        ),
      ),
    );
  }
}