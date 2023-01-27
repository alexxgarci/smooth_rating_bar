import 'package:flutter/material.dart';
import 'package:smooth_rating_bar/smooth_rating_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _rating = 2;

  void _setRating(double rating) {
    setState(() {
      _rating = rating;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: SmoothRatingBar(
          rating: _rating,
          color: Colors.yellow,
          borderColor: Colors.grey[300],
          onRatingCallback: _setRating,
          starCount: 5,
          starPadding: const EdgeInsets.symmetric(horizontal: 10),
          starSize: 15,
        ),
      ),
    );
  }
}
