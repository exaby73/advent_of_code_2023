typedef Cell = (int, int);
typedef InputMatrix = List<List<String>>;
typedef OutputMatrixOfSurroundingNumbers = List<List<int>>;

extension SumOfNumbers on List<int> {
  int get sum => fold(0, (sum, e) => sum + e);

  int get product => fold(1, (product, e) => product * e);
}

extension SumOfMatix on OutputMatrixOfSurroundingNumbers {
  int get sum => fold(0, (sum, e) => sum + e.sum);

  int sumOfAllProductsOfExactly(int length) =>
      fold(0, (sum, e) => sum + (e.length == length ? e.product : 0));
}

extension InputMatrixX on InputMatrix {
  static const _digits = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9'};
  static const _invalidChars = {..._digits, '.'};

  int get rowLength => length;

  int get colLength => first.length;

  String getCharAtCell(Cell cell) => this[cell.$1][cell.$2];

  OutputMatrixOfSurroundingNumbers getSurroundingNumbersSymbols() {
    return _getSurroundingNumbers();
  }
  
  OutputMatrixOfSurroundingNumbers getSurroundingNumbersAroundFilter(Set<String> filter) {
    return _getSurroundingNumbers(filter);
  }
  
  OutputMatrixOfSurroundingNumbers _getSurroundingNumbers([Set<String>? filter]) {
    final Set<Cell> cellsCheckedForNumbers = {};

    final OutputMatrixOfSurroundingNumbers numbers = [];
    for (int row = 0; row < rowLength; row++) {
      for (int col = 0; col < colLength; col++) {
        final char = getCharAtCell((row, col));
        if (filter != null && !filter.contains(char)) continue;
        if (_invalidChars.contains(char)) continue;
        final validCells = _getValidSurroundingCells(
          row,
          col,
          cellsCheckedForNumbers,
        );
        numbers.add(
          _parseNumbersAtIndices(validCells, cellsCheckedForNumbers),
        );
      }
    }
    return numbers;
  }

  List<Cell> _getValidSurroundingCells(
    int row,
    int col,
    Set<Cell> cellsCheckedForNumbers,
  ) {
    final List<Cell> cells = [];

    for (int i = row - 1; i <= row + 1; i++) {
      for (int j = col - 1; j <= col + 1; j++) {
        if (i < 0 || i >= rowLength || j < 0 || j >= colLength) {
          continue;
        }
        if (i == row && j == col) continue;
        cells.add((i, j));
      }
    }

    return cells;
  }

  List<int> _parseNumbersAtIndices(
    List<Cell> validCells,
    Set<Cell> cellsCheckedForNumbers,
  ) {
    final List<int> numbers = [];
    for (final cell in validCells) {
      if (cellsCheckedForNumbers.contains(cell)) continue;
      final char = getCharAtCell(cell);
      if (!_digits.contains(char)) continue;
      final (:checkedCells, :number) = _parseNumber(cell);
      cellsCheckedForNumbers.addAll(checkedCells);
      numbers.add(number);
    }
    return numbers;
  }

  ({List<Cell> checkedCells, int number}) _parseNumber(Cell cell) {
    final List<Cell> checkedCells = [];
    String numberString = getCharAtCell(cell);

    for (int colIndex = cell.$2 - 1; colIndex >= 0; colIndex--) {
      final cellToCheck = (cell.$1, colIndex);
      final char = getCharAtCell(cellToCheck);
      checkedCells.add(cellToCheck);
      if (!_digits.contains(char)) break;
      numberString = char + numberString;
    }

    for (int rowIndex = cell.$2 + 1; rowIndex < colLength; rowIndex++) {
      final cellToCheck = (cell.$1, rowIndex);
      final char = getCharAtCell(cellToCheck);
      checkedCells.add(cellToCheck);
      if (!_digits.contains(char)) break;
      numberString += char;
    }

    return (checkedCells: checkedCells, number: int.parse(numberString));
  }
}
