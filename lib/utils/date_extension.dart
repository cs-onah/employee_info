import 'package:intl/intl.dart' as intl;

extension DateUtil on DateTime {
  String get dateReadable {
    return intl.DateFormat('d MMM yyyy').format(this);
  }

  String get dateReadableWithComma {
    return intl.DateFormat('d MMM, yyyy').format(this);
  }

  bool isSameDay(DateTime? other) {
    if (other != null) {
      return dateReadable == other.dateReadable;
    }
    return false;
  }
}

extension DateUtil2 on DateTime? {
  String? get dateReadableWithComma {
    if (this == null) return null;
    return intl.DateFormat('d MMM, yyyy').format(this!);
  }
}
