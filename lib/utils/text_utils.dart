class TextUtils {

  TextUtils._();

  static bool isEmpty(String? str) {
    return str != null && str.isEmpty;
  }

  static bool isNotEmpty(String? str) {
    return str != null && str.isNotEmpty;
  }
}