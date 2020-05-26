import 'package:flutter/material.dart';
import 'package:path_visualizer/helpers/dijkstra_helper.dart';
import 'package:path_visualizer/providers/cell_class_provider.dart';
import 'package:path_visualizer/widgets/algorithms_dropdownmenu.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class HomePageScreen extends StatefulWidget {
  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  CellProvider cellProvider;
  Map<String, Object> visitedPathByAlgorithm;
  PreferredSizeWidget get appbar {
    return AppBar(
      title: Text("Path Visualizer"),
      actions: <Widget>[
        AlgorithmsDropdownmenu(),
      ],
      bottom: PreferredSize(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Builder(
                  builder: (context) => RaisedButton(
                      onPressed: () async {
                        List<Cell> actualPath = [];
                        visitedPathByAlgorithm =
                            DijkstraHelper().startAlgorithm();
                        print("Got list from algo $visitedPathByAlgorithm");

                        for (var i = 0;
                            i <
                                ((visitedPathByAlgorithm["visitedPath"])
                                        as List)
                                    .length;
                            i++) {
                          cellProvider.changeColorOnVisited(
                              ((visitedPathByAlgorithm["visitedPath"])
                                      as List)[i]
                                  .index,
                              Colors.blue);
                          await Future.delayed(
                              const Duration(milliseconds: 200));
                        }
                        if (visitedPathByAlgorithm["pathFound"] == false) {
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text("No Path Found !"),
                            backgroundColor: Theme.of(context).primaryColor,
                            duration: Duration(seconds: 2),
                            action: SnackBarAction(
                                label: "OKAY",
                                onPressed: () =>
                                    Scaffold.of(context).hideCurrentSnackBar()),
                          ));
                        } else {
                          print("inside else");
                          print(
                              "Got shortest path ${visitedPathByAlgorithm["shortestPath"]}");
                          Tuple2<int, int> temp =
                              ((visitedPathByAlgorithm["shortestPath"]) as Map)[
                                  ((Cell.isSet["targetNode"]) as List)[1]];
                          print(temp);
                          while (
                              temp != ((Cell.isSet["startNode"]) as List)[1]) {
                            print("Inside path");
                            actualPath.add(
                                CellProvider.mainGrid[temp.item1][temp.item2]);
                            temp = ((visitedPathByAlgorithm["shortestPath"])
                                    as Map)[
                                CellProvider
                                    .mainGrid[temp.item1][temp.item2].index];
                            print("Now temp is $temp");
                          }
                          for (var i = actualPath.length - 1; i >= 0; i--) {
                            cellProvider.changeColorOnVisited(
                                actualPath[i].index, Colors.yellow);
                            await Future.delayed(
                                const Duration(milliseconds: 200));
                          }
                        }
                      },
                      child: Text("Start")),
                ),
                RaisedButton(
                    onPressed: () async {
                      for (var i = 0; i < 10; i++) {
                        await Future.delayed(const Duration(milliseconds: 200));
                        cellProvider.simulate(Tuple2<int, int>(i, i));
                      }
                    },
                    child: Text("Add Blocker")),
                RaisedButton(
                    onPressed: () => cellProvider.clearAllCells(),
                    child: Text("Clear")),
              ],
            ),
          ),
          preferredSize: const Size.fromHeight(30)),
    );
  }

  Color concolor = Colors.blue;

  @override
  void initState() {
    super.initState();

    print("init state called");
    // double screenHeight =
    //     MediaQuery.of(context).size.height - appbar.preferredSize.height - 60;
    // double screenWidth = MediaQuery.of(context).size.width - 20;

    // int numberOfCellInRow = (screenWidth / (CellProvider.width + 6)).floor();
    // int numberOfCellsInColumn =
    //     (screenHeight / (CellProvider.width + 6)).floor();

    CellProvider.width = 25.0;
    //we can give the num of cells in future when the creen height and width will be calculated in previous screen
    CellProvider.fillGrid();
  }

  @override
  Widget build(BuildContext context) {
    // print("Build called");
    cellProvider = Provider.of<CellProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: CellProvider.mainGrid.map((e) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: e.map((f) {
                  return GestureDetector(
                    onTap: () =>
                        cellProvider.changeColor(f.index, Colors.green),
                    child: f.cell,
                  );
                }).toList(),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
