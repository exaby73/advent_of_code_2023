import 'package:aoc_2023/utils.dart';

extension Part1Solution on InputList {
  int getNextInHistory(List<int> nums) {
    bool hasNonZero = nums.any((element) => element != 0);
    if (!hasNonZero) {
      return 0;
    }
    List<int> newNums = [];
    for (int i = 0; i < nums.length - 1; i++) {
      newNums.add(nums[i + 1] - nums[i]);
    }
    return nums.last + getNextInHistory(newNums);
  }

  int sumOfNextValuesInHistory({bool reversed = false}) {
    int sum = 0;
    for (final line in this) {
      var nums = line.split(' ').map(int.parse).toList();
      if (reversed) nums = nums.reversed.toList();
      sum += getNextInHistory(nums);
    }
    return sum;
  }
}
