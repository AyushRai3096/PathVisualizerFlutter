import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:path_visualizer/providers/cell_class_provider.dart';
import 'package:path_visualizer/screens/home_page_screen.dart';
import 'package:provider/provider.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CellProvider(),
      child: MaterialApp(
        theme: ThemeData(
          canvasColor: Color.fromRGBO(48, 52, 56, 1),
          primaryColor: Color.fromRGBO(48, 52, 56, 1),
        ),
        home: HomePageScreen(),
      ),
    );
  }
}
