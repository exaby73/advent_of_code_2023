import 'package:aoc_2023/utils.dart';

typedef Node = ({String left, String right});

extension GetNodeDirection on Node {
  String getNodeFrom(Direction direction) {
    return direction == Direction.left ? left : right;
  }
}

typedef Nodes = Map<String, Node>;

enum Direction { left, right }

typedef NodesWithDirections = ({List<Direction> directions, Nodes nodes});

extension ParseInput on InputList {
  NodesWithDirections get nodesWithDirections {
    final [directionsString, ...nodesStrings] = this;
    final directions = directionsString
        .split('')
        .map((e) => e == 'L' ? Direction.left : Direction.right)
        .toList();
    final nodes = Map.fromEntries(
      nodesStrings.map((e) => e.split('=')).map(
            (e) => MapEntry(
              e.first.trim(),
              e[1].replaceAll(RegExp(r'([()])'), '').split(', ').fold<Node>(
                (left: '', right: ''),
                (r, e) => r.left.isEmpty
                    ? (left: e.trim(), right: '')
                    : (left: r.left, right: e.trim()),
              ),
            ),
          ),
    );
    return (directions: directions, nodes: nodes);
  }
}

extension Part1Solution on NodesWithDirections {
  int steps({required String start, required String end}) {
    String currentCheckingNode = start;
    int step = 0;
    while (true) {
      final node = nodes[currentCheckingNode]!;
      final direction = directions[step++ % directions.length];
      final nextNode = node.getNodeFrom(direction);
      if (nextNode == end) {
        return step;
      }
      currentCheckingNode = nextNode;
    }
  }
}
