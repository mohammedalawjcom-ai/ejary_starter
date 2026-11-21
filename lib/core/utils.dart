String newId() => DateTime.now().microsecondsSinceEpoch.toString();
String fmt(DateTime d) =>
    '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
String ymOf(DateTime d) => fmt(d).substring(0, 7);
