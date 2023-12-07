import 'dart:math';

import 'package:collection/collection.dart';

typedef RangeMapping = ({
  int sourceStart,
  int destinationStart,
  int range,
});

typedef DestinationRangeMapping = ({
  String destination,
  List<RangeMapping> rangeMappings,
});

typedef MappingSet = Map<String, DestinationRangeMapping>;

typedef InputSet = ({
  List<int> seeds,
  MappingSet mappingSets,
});

extension CreateInputSet on String {
  InputSet inputSet({bool seedRanges = false}) {
    final [seedsString, ...rawMappings] = split('\n' * 2);
    var seeds = seedsString
        .replaceFirst(RegExp(r'\w+: '), '')
        .split(' ')
        .map(int.parse)
        .toList();

    if (seedRanges) {
      seeds = seeds
          .fold<List<List<int>>>([], (pairs, e) {
            final last = pairs.lastOrNull;
            if (last?.length == 1) {
              last!.add(e);
              return pairs;
            }

            pairs.add([e]);
            return pairs;
          })
          .map((e) => List.generate(e[1], (index) => e.first + index))
          .flattened
          .toList();
    }

    MappingSet mappingSets = {};
    for (final mappingSet in rawMappings) {
      final [header, ...mappings] = mappingSet.split('\n');
      final [source, destination] =
          header.replaceFirst(' map:', '').split('-to-');

      final rangeMapping = mappings
          .map(
            (e) =>
                e.split(' ').where((e) => e.isNotEmpty).map(int.parse).toList(),
          )
          .where((e) => e.isNotEmpty)
          .map(
            (e) => (
              sourceStart: e[1],
              destinationStart: e.first,
              range: e.last,
            ),
          )
          .toList();
      mappingSets.addAll({
        source: (destination: destination, rangeMappings: rangeMapping),
      });
    }

    return (seeds: seeds, mappingSets: mappingSets);
  }
}

extension on MappingSet {
  int getMappingForLast(int value, String start, String end) {
    if (start == end) {
      return value;
    }

    final startMapping = this[start]!;

    int? newValue;
    for (final range in startMapping.rangeMappings) {
      if (value >= range.sourceStart &&
          value < range.sourceStart + range.range) {
        newValue = value - range.sourceStart + range.destinationStart;
        break;
      }
    }

    newValue ??= value;

    return getMappingForLast(newValue, startMapping.destination, end);
  }
}

extension InputSetSolution on InputSet {
  int lowestOf(String start, String end) {
    int? lowest = null;

    for (final seed in seeds) {
      final l = mappingSets.getMappingForLast(seed, start, end);
      lowest = lowest == null ? l : min(lowest, l);
    }

    return lowest!;
  }
}
// 100165128
