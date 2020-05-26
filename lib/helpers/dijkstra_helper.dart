import 'package:path_visualizer/providers/cell_class_provider.dart';
import 'package:tuple/tuple.dart';

class DijkstraHelper {
  Tuple2<int, int> startNode = ((Cell.isSet["startNode"]) as List)[1];
  Tuple2<int, int> targetNode = ((Cell.isSet["targetNode"]) as List)[1];

  Cell getMinimum() {
    double minimum = double.infinity;
    Cell resultingMinimumObj;
    for (var i = 0; i < CellProvider.mainGrid.length; i++) {
      for (var j = 0; j < CellProvider.mainGrid[i].length; j++) {
        if (CellProvider.mainGrid[i][j].distance == null) {
          continue;
        }
        if (CellProvider.mainGrid[i][j].distance < minimum) {
          minimum = CellProvider.mainGrid[i][j].distance;
          resultingMinimumObj = CellProvider.mainGrid[i][j];
        }
      }
    }

    return resultingMinimumObj;
  }

  Map<String, Object> startAlgorithm() {
    bool pathFound = false;
    print(startNode);
    print(targetNode);

    List<Cell> visitedPath = [];
    Map<Tuple2<int, int>, Tuple2<int, int>> shortestPath = {};

    Cell currentNode;
    CellProvider.mainGrid[startNode.item1][startNode.item2].distance = 0;
    currentNode = CellProvider.mainGrid[startNode.item1][startNode.item2];
    while (currentNode !=
        CellProvider.mainGrid[targetNode.item1][targetNode.item2]) {
      print("while running");

      currentNode = getMinimum();
      if (currentNode == null) {
        print("No path found !");
        return {"pathFound": pathFound, "visitedPath": visitedPath};
      }
      visitedPath.add(currentNode);

      for (var i = 0; i < 4; i++) {
        Tuple2<int, int> next = Tuple2<int, int>(
            currentNode.index.item1 + Cell.nextCell[i].item1,
            currentNode.index.item2 + Cell.nextCell[i].item2);

        if (next.item1 < 0 ||
            next.item1 >= 18 ||
            next.item2 < 0 ||
            next.item2 >= 10) {
          continue;
        }
        if (CellProvider.mainGrid[next.item1][next.item2].isBlocked) {
          continue;
        }
        if (CellProvider.mainGrid[next.item1][next.item2].distance == null) {
          continue;
        }
        if (CellProvider.mainGrid[next.item1][next.item2].distance >
            (currentNode.distance + 1)) {
          CellProvider.mainGrid[next.item1][next.item2].distance =
              currentNode.distance + 1;
          shortestPath[next] = currentNode.index;
        }
      }

      currentNode.distance = null;
    }

    pathFound = true;
    print("returning true");
    return {
      "pathFound": pathFound,
      "visitedPath": visitedPath,
      "shortestPath": shortestPath
    };
  }
}
