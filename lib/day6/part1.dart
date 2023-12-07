import 'package:aoc_2023/day6/shared.dart';
import 'package:aoc_2023/utils.dart';

void main() {
  final [timeString, distanceString] = readInputAsLines(6);
  final input = (timeString, distanceString);
  final raceInformation = input.allRaceInformation;
  print(raceInformation.productOfNumberOfRecordBreakingTimes);
}
