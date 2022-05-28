abstract class DTFM {
  static maker(int? milliseconds) {
    if (milliseconds != null) {
      DateTime date = DateTime.fromMillisecondsSinceEpoch(milliseconds);
      return "${(date.day < 10) ? "0${date.day}" : date.day}.${(date.month < 10) ? "0${date.month}" : date.month}.${date.year}";
    } else {
      return "--,--,----";
    }
  }
   static makerFromStr(String? milliseconds) {
    if (!(milliseconds == "null"||milliseconds == null)) {
      DateTime date =
          DateTime.fromMillisecondsSinceEpoch(int.parse(milliseconds));
      return "${(date.day < 10) ? "0${date.day}" : date.day}.${(date.month < 10) ? "0${date.month}" : date.month}.${date.year}";
    } else {
      return "--,--,----";
    }
  }
}
