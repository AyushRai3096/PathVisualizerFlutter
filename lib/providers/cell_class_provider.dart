import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tuple/tuple.dart';

class Cell {
  static Map<String, Object> isSet = {
    "startNode": [false, Tuple2<int, int>(null, null)],
    "targetNode": [false, Tuple2<int, int>(null, null)]
  };
  static List<Tuple2<int, int>> nextCell = [
    Tuple2<int, int>(0, -1), //left
    Tuple2<int, int>(-1, 0), //top
    Tuple2<int, int>(0, 1), //right
    Tuple2<int, int>(1, 0) //bottom
  ];
  Tuple2<int, int> index;
  bool isBlocked;
  bool isSelected;
  double width;
  Container container;
  Color colorOfContainer;
  double distance;

  Cell(
      {this.index,
      this.width,
      this.colorOfContainer,
      this.isSelected,
      this.isBlocked,
      this.distance});

  Container get cell {
    this.container = Container(
      margin: EdgeInsets.all(3),
      decoration:
          BoxDecoration(border: Border.all(), color: this.colorOfContainer),
      height: this.width,
      width: this.width,
    );
    return this.container;
  }
}

class CellProvider with ChangeNotifier {
  List<Tuple2<int, int>> cellsColored = [];
  static double width;
  static List<List<Cell>> mainGrid = [];

  static fillGrid() {
    print("Fill grid called");
    for (var i = 0; i < 18; i++) {
      List<Cell> temp = [];
      for (var j = 0; j < 10; j++) {
        temp.add(Cell(
            isBlocked: false,
            index: Tuple2<int, int>(i, j),
            width: CellProvider.width,
            colorOfContainer: Colors.white,
            distance: double.infinity,
            isSelected: false));
      }
      CellProvider.mainGrid.add(temp);
    }
  }

  void changeColor(Tuple2<int, int> index, Color color) {
    if (((Cell.isSet["startNode"]) as List)[0] == false) {
      ((Cell.isSet["startNode"]) as List)[0] = true;
      color = Colors.green;
      ((Cell.isSet["startNode"]) as List)[1] = index;
    } else {
      if (((Cell.isSet["targetNode"]) as List)[0] == false) {
        ((Cell.isSet["targetNode"]) as List)[0] = true;
        color = Colors.red;
        ((Cell.isSet["targetNode"]) as List)[1] = index;
      } else {
        color = Colors.black;
      }
    }
    bool isSelected =
        CellProvider.mainGrid[index.item1][index.item2].isSelected;
    if (isSelected) {
      if (index == ((Cell.isSet["startNode"]) as List)[1]) {
        ((Cell.isSet["startNode"]) as List)[0] = false;
      }
      if (index == ((Cell.isSet["targetNode"]) as List)[1]) {
        ((Cell.isSet["targetNode"]) as List)[0] = false;
      }
      cellsColored.remove(index);
    } else {
      cellsColored.add(index);
    }
    isSelected = !isSelected;
    //Changing the isSlected property on tapping a cell

    CellProvider.mainGrid[index.item1][index.item2].isSelected =
        !CellProvider.mainGrid[index.item1][index.item2].isSelected;
//Changing the isBlocked property on tapping a cell
    if (color == Colors.black) {
      print("inside if condition ");
      CellProvider.mainGrid[index.item1][index.item2].isBlocked =
          !CellProvider.mainGrid[index.item1][index.item2].isBlocked;
    }

    CellProvider.mainGrid[index.item1][index.item2].colorOfContainer =
        isSelected ? color : Colors.white;
    print(cellsColored);
    notifyListeners();
  }

  void changeColorOnVisited(Tuple2<int, int> index, Color color) {
    // print("ChangeColorOnVisited called");
    CellProvider.mainGrid[index.item1][index.item2].isBlocked = true;
    CellProvider.mainGrid[index.item1][index.item2].colorOfContainer = color;
    notifyListeners();
  }

  void clearAllCells() {
    List<Tuple2<int, int>> temp = [];
    cellsColored.forEach((element) {
      temp.add(element);
    });
    print("clear called");
    temp.forEach((element) {
      print(element);
      changeColor(element, Colors.white);
    });
  }

  void simulate(Tuple2<int, int> temp) {
    changeColor(temp, Colors.white);
  }
}
