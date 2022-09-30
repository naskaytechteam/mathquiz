class Util{
  static int hcf(int firstValue,int secondValue){
    if (firstValue == 0) {
      return secondValue;
    }
    return hcf(secondValue % firstValue, firstValue);
  }
}