import 'dart:io';

List<String> readInputAsLines(int day) {
  return File('inputs/day$day.txt').readAsLinesSync();
}
