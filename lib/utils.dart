import 'dart:io';

List<String> readInputAsLines(int day, {bool test = false}) {
  final ext = test ? '.test.txt' : '.txt';
  return File('inputs/day$day$ext').readAsLinesSync();
}

List<List<String>> readInputAsMatrix(int day, {bool test = false}) {
  return readInputAsLines(day, test: test).map((e) => e.split('')).toList();
}
