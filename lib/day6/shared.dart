typedef Input = (String timeString, String distance);

typedef RaceInformation = ({int maxTime, int record});

extension InputSolution on Input {
  List<RaceInformation> get allRaceInformation {
    final [_, ...timeStrings] =
        $1.split(' ').where((element) => element.isNotEmpty).toList();
    final times = timeStrings.map(int.parse).toList();
    final [_, ...distanceStrings] =
        $2.split(' ').where((element) => element.isNotEmpty).toList();
    final distances = distanceStrings.map(int.parse).toList();
    return List.generate(
      times.length,
      (index) => (maxTime: times[index], record: distances[index]),
    );
  }
}

extension RecordBreakingRaces on RaceInformation {
  List<int> get recordBreakingTimes {
    return List.generate(maxTime - 2, (index) {
      // time == speed
      final time = index + 1;
      final timeToTravel = maxTime - time;
      if (record >= time * timeToTravel) return null;
      return time;
    }).whereType<int>().toList();
  }
}

extension AllRaceInformationX on List<RaceInformation> {
  int get productOfNumberOfRecordBreakingTimes {
    return map((e) => e.recordBreakingTimes.length)
        .fold(1, (product, e) => product * e);
  }

  RaceInformation get squashTimesAndRecords {
    final squashed = map((e) => (e.maxTime.toString(), e.record.toString()))
        .fold(('', ''), (str, e) => (str.$1 + e.$1, str.$2 + e.$2));
    return (maxTime: int.parse(squashed.$1), record: int.parse(squashed.$2));
  }
}
