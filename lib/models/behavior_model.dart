// Model untuk Rekod Sahsiah (perilaku murid)
class BehaviorRecord {
  final String studentName;
  final String act; // Baik atau Buruk
  final String detail; // Deskripsi tingkah laku
  final int mata; // Mata yang ditambah atau dikurangi
  final DateTime timestamp;

  BehaviorRecord({
    required this.studentName,
    required this.act,
    required this.detail,
    required this.mata,
    required this.timestamp,
  });
}

// Model untuk statistik harian
class DailyBehaviorStats {
  final int baik;
  final int buruk;
  final int totalMata;

  DailyBehaviorStats({
    required this.baik,
    required this.buruk,
    required this.totalMata,
  });
}

// Model untuk statistik murid (Carta Kedudukan)
class StudentBehaviorStats {
  final String studentName;
  final String className; // e.g., "6 Amanah"
  final int baik;
  final int buruk;
  final int totalMata;

  StudentBehaviorStats({
    required this.studentName,
    required this.className,
    required this.baik,
    required this.buruk,
    required this.totalMata,
  });

  String get year {
    // Extract year from className (e.g., "6" from "6 Amanah")
    return className.split(' ')[0];
  }
}
