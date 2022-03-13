import 'package:flutter/material.dart';
import 'package:image_collapse/image_collapse.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gallery Collapse',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Gallery Collapse'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const List<String> listOfUrls = [
    "https://img.pikbest.com/01/69/01/65WpIkbEsTQfU.jpg-0.jpg!bw340",
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
        backgroundColor: Color(0xff374056),
        title: Text(widget.title),
      ),
      body: Center(
        child: ImageCollapse(
          imageUrls: listOfUrls,
        ),
      ),
    );
  }
}
