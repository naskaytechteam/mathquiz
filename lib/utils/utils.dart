import 'package:flutter/services.dart';

enum SortOrder {
  ascending,
  descending,
}

class Utils {
  static const List _placeHolder = [
    'ones',
    'tens',
    'hundreds',
    'thousands',
    'ten thousands',
    'hundred thousands',
    'millions',
    'ten millions',
    'billions',
    'ten billions',
  ];
  static const List oneToNineTeen = [
    'one',
    'two',
    'three',
    'four',
    'five',
    'six',
    'seven',
    'eight',
    'nine',
    'ten',
    'eleven',
    'twelve',
    'thirteen',
    'fourteen',
    'fifteen',
    'sixteen',
    'seventeen',
    'eighteen',
    'nineteen'
  ];
  static const List tenToMax = [
    'ten',
    'twenty',
    'thirty',
    'forty',
    'fifty',
    'sixty',
    'seventy',
    'eighty',
    'ninety',
    'hundred',
    'thousand',
    'lakh',
    'crore'
  ];

  Utils._();

  static Future<void> hideSystemNavBar() async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
        overlays: [SystemUiOverlay.top]);
  }

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

  static int reduceList(
      {required List<int> values, SortOrder sortOrder = SortOrder.ascending}) {
    List<int> sortedList = sortOrder == SortOrder.descending
        ? _sortListInDescendingOrder(values)
        : _sortListInAscendingOrder(values);

    return sortedList.reduce(
            (previousValue, element) => int.parse('$previousValue$element'));
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

  static String changeNumbersToWords(int value) {
    if (value >= 100000) {
      return '${changeNumbersToWords(
          value ~/ 100000)} lakh ${changeNumbersToWords(value % 100000)}';
    } else if (value >= 1000) {
      return '${changeNumbersToWords(
          value ~/ 1000)} Thousand ${changeNumbersToWords(value % 1000)}';
    } else if (value >= 100) {
      return "${changeNumbersToWords(
          value ~/ 100)} Hundred ${changeNumbersToWords(value % 100)}";
    } else {
      return _oneToNinetyNine(value);
    }
  }

  static String _oneToNinetyNine(int value) {
    if (value == 0) {
      return '';
    } else if (value <= 19) {
      return _getOneToNineteen(value);
    }
    return '${_getTenToMax(value ~/ 10)} ${_oneToNinetyNine(value % 10)}';
  }

  static String _getOneToNineteen(int value) {
    return oneToNineTeen[value - 1];
  }

  static String _getTenToMax(int value) {
    return '${tenToMax[value - 1]}';
  }

  static String getPlaceHolder(int index) {
    return _placeHolder[index];
  }
}
