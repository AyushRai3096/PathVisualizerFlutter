import 'package:flutter/material.dart';

class AlgorithmsDropdownmenu extends StatefulWidget {
  @override
  _AlgorithmsDropdownmenuState createState() => _AlgorithmsDropdownmenuState();
}

enum Algorithms { Dijkstra, DFS, BFS, Astar, Prims }

class _AlgorithmsDropdownmenuState extends State<AlgorithmsDropdownmenu> {
  int _initValue = 0;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
          child: DropdownButton(icon: Icon(Icons.more_vert),
        iconEnabledColor: Colors.white,
        items: [
          DropdownMenuItem(
            child: Text(
              "Dijkstra",
              style: TextStyle(color: Colors.white),
            ),
            value: Algorithms.Dijkstra.index,
          ),
          DropdownMenuItem(
            child: Text("DFS", style: TextStyle(color: Colors.white)),
            value: Algorithms.DFS.index,
          ),
          DropdownMenuItem(
            child: Text("BFS", style: TextStyle(color: Colors.white)),
            value: Algorithms.BFS.index,
          ),
          DropdownMenuItem(
            child: Text("Astar", style: TextStyle(color: Colors.white)),
            value: Algorithms.Astar.index,
          )
        ],
        onChanged: (value) => setState(() {
          _initValue = value;
        }),
        isDense: true,
        
        // value: _initValue,
      ),
    );
  }
}
