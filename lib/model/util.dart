enum SortOrder {
  ascending,
  descending,
}

class Util {
  static int hcf(List<int> values) {
    return values.reduce((value, element) => _findGCD(value, element));
  }

  static int _findGCD(int x, int y) {
    if (x == 0) {
      return y;
    }
    return _findGCD(y % x, x);
  }

  static String ratio(int first, int second) {
    for (int ar = 2; ar <= first && ar <= second; ar++) {
      while (first % ar == 0 && second % ar == 0) {
        first ~/= ar;
        second ~/= ar;
      }
    }
    return '$first : $second';
  }

  // [2, 5, 9, 10] sortOrder = ascending => [9, 2, 5, 10] = 92510
  static int reduceList(
      {required List<int> values, SortOrder sortOrder = SortOrder.ascending}) {
    List<int> sortedList = sortOrder == SortOrder.descending
        ? _sortListInDescendingOrder(values)
        : _sortListInAscendingOrder(values);
    /// why are we multiplying this previousValue by 10

    return sortedList
        .reduce((previousValue, element) => previousValue * 10 + element);
  }

  static List<int> _sortListInAscendingOrder(List<int> values) {
    return values..sort();
  }

  static List<int> _sortListInDescendingOrder(List<int> values) {
    return _sortListInAscendingOrder(values).reversed.toList();
  }

  static int lcm(List<int> values) {
    return values.reduce((a, b) => (a * b) ~/ _findGCD(a, b));
  }
}
