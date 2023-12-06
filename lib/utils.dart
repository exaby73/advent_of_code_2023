import 'dart:io';

typedef InputList = List<String>;
typedef InputMatrix = List<List<String>>;

InputList readInputAsLines(int day, {bool test = false}) {
  final ext = test ? '.test.txt' : '.txt';
  return File('inputs/day$day$ext').readAsLinesSync();
}

InputMatrix readInputAsMatrix(int day, {bool test = false}) {
  return readInputAsLines(day, test: test).map((e) => e.split('')).toList();
}
