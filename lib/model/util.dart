class Util {
  static int hcf(int firstValue, int secondValue) {
    if (firstValue == 0) {
      return secondValue;
    }
    return hcf(secondValue % firstValue, firstValue);
  }

  static String ratio(int first,int second) {
    for(int ar=2;ar<=first &&ar<=second;ar++){
      while (first%ar==0&&second%ar==0){
        first~/=ar;
        second~/=ar;
      }
    }
    return '$first : $second';
  }

  static int lcm(int a, int b)
  {
    return (a ~/ hcf(a, b)) * b;
  }
}
