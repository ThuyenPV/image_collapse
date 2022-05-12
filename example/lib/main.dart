import 'package:flutter/material.dart';
import 'package:image_collapse/image_collapse.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gallery Collapse',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Gallery Collapse'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const List<String> listOfUrls = [
    "https://img.pikbest.com/png-images/plane-flying-on-location-and-map-with-forest-element_1493374.png!bw340",
    "https://img.pikbest.com/05/81/63/10VpIkbEsT5s3.jpg-0.jpg!bw340",
    "https://img.pikbest.com/01/42/43/44apIkbEsT5gu.jpg-0.jpg!bw340",
    "https://img.pikbest.com/pikbest/pic/00/32/88/08I888piCYQN.jpg-0.jpg!bw340",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xff374056),
        title: Text(widget.title),
      ),
      body: const Center(
        child: ImageCollapse(
          imageUrls: listOfUrls,
        ),
      ),
    );
  }
}
