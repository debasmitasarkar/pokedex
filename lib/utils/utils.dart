class Utils {
  static String capitalize(String str) =>
      str.isNotEmpty ? str[0].toUpperCase() + str.substring(1) : str;
}

extension IntExtension on int {
  String formatId() {
    if (this < 10) {
      return '#00$this';
    } else if (this < 100) {
      return '#0$this';
    } else {
      return '#$this';
    }
  }
}
