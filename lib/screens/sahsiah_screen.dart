import 'package:flutter/material.dart';
import '../models/behavior_model.dart';

class SahsiahScreen extends StatefulWidget {
  const SahsiahScreen({super.key});

  @override
  State<SahsiahScreen> createState() => _SahsiahScreenState();
}

class _SahsiahScreenState extends State<SahsiahScreen> {
  // Sample data - in production this would come from a database/API
  late DailyBehaviorStats stats;
  late List<BehaviorRecord> records;
  late List<StudentBehaviorStats> studentStats;

  int _selectedTabIndex = 0; // 0 for Rekod, 1 for Carta Kedudukan
  int _selectedCartaSubsection = 0; // 0 for Semua, 1 for Kelas, 2 for Tahun
  String? _selectedClass;
  String? _selectedYear;

  @override
  void initState() {
    super.initState();
    _initializeSampleData();
  }

  void _initializeSampleData() {
    // Sample statistics for today
    stats = DailyBehaviorStats(baik: 5, buruk: 2, totalMata: 12);

    // Sample behavior records for today
    records = [
      BehaviorRecord(
        studentName: 'Ali bin Ahmad',
        act: 'Baik',
        detail: 'Membantu rakan membersihkan kelas',
        mata: 3,
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      BehaviorRecord(
        studentName: 'Fatimah binti Hassan',
        act: 'Baik',
        detail: 'Menghantar kerja rumah tepat pada waktu',
        mata: 2,
        timestamp: DateTime.now().subtract(const Duration(hours: 1)),
      ),
      BehaviorRecord(
        studentName: 'Mohamed Rizk',
        act: 'Buruk',
        detail: 'Berbuat ribut di dalam kelas',
        mata: -2,
        timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
      ),
      BehaviorRecord(
        studentName: 'Siti Zahra',
        act: 'Baik',
        detail: 'Bersemangat dalam aktiviti kelas',
        mata: 3,
        timestamp: DateTime.now().subtract(const Duration(minutes: 20)),
      ),
      BehaviorRecord(
        studentName: 'Amir Hassan',
        act: 'Baik',
        detail: 'Memberi bantuan kepada pelajar lain',
        mata: 2,
        timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
      ),
      BehaviorRecord(
        studentName: 'Nur Azizah',
        act: 'Buruk',
        detail: 'Tidak membawa buku teks',
        mata: -1,
        timestamp: DateTime.now(),
      ),
    ];

    // Sample student behavior statistics
    studentStats = [
      StudentBehaviorStats(
        studentName: 'Ali bin Ahmad',
        className: '6 Amanah',
        baik: 12,
        buruk: 2,
        totalMata: 45,
      ),
      StudentBehaviorStats(
        studentName: 'Fatimah binti Hassan',
        className: '6 Amanah',
        baik: 15,
        buruk: 1,
        totalMata: 52,
      ),
      StudentBehaviorStats(
        studentName: 'Mohamed Rizk',
        className: '6 Bijak',
        baik: 8,
        buruk: 5,
        totalMata: 28,
      ),
      StudentBehaviorStats(
        studentName: 'Siti Zahra',
        className: '6 Bijak',
        baik: 14,
        buruk: 2,
        totalMata: 48,
      ),
      StudentBehaviorStats(
        studentName: 'Amir Hassan',
        className: '5 Murni',
        baik: 11,
        buruk: 3,
        totalMata: 42,
      ),
      StudentBehaviorStats(
        studentName: 'Nur Azizah',
        className: '5 Murni',
        baik: 13,
        buruk: 1,
        totalMata: 50,
      ),
    ];

    // default selections for filters
    if (studentStats.isNotEmpty) {
      _selectedClass = studentStats.first.className;
      _selectedYear = studentStats.first.year;
    }
  }

  List<StudentBehaviorStats> _getFilteredStudents() {
    final List<StudentBehaviorStats> copy = List<StudentBehaviorStats>.from(
      studentStats,
    );

    // Apply subsection-specific filters
    if (_selectedCartaSubsection == 1 && _selectedClass != null) {
      // filter by selected class
      copy.retainWhere((s) => s.className == _selectedClass);
    } else if (_selectedCartaSubsection == 2 && _selectedYear != null) {
      // filter by selected year
      copy.retainWhere((s) => s.year == _selectedYear);
    }

    // Default sorting: by totalMata desc
    copy.sort((a, b) => b.totalMata.compareTo(a.totalMata));
    return copy;
  }

  List<String> _getGroupLabels() {
    if (_selectedCartaSubsection == 0) {
      return []; // No grouping
    } else if (_selectedCartaSubsection == 1) {
      final classes = studentStats.map((s) => s.className).toSet().toList();
      classes.sort((a, b) => b.compareTo(a));
      return classes;
    } else {
      final years = studentStats.map((s) => s.year).toSet().toList();
      years.sort((a, b) => b.compareTo(a));
      return years;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App Title (left-aligned with QR logo)
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(Icons.qr_code_2, size: 40, color: Colors.indigo),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'EduPulse',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Portal Guru',
                      style: TextStyle(fontSize: 12, color: Colors.indigo),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Main Section Title
            const Text(
              'Sahsiah Diri Murid',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Sistem mata berasaskan tingkah laku',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 20),

            // Tab Selection
            _buildTabSelection(),
            const SizedBox(height: 20),

            // Content based on selected tab
            if (_selectedTabIndex == 0)
              _buildRekodSection()
            else
              _buildCartaSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildTabSelection() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _selectedTabIndex = 0),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: _selectedTabIndex == 0
                        ? Colors.indigo
                        : Colors.transparent,
                    width: 3,
                  ),
                ),
              ),
              child: Text(
                'Rekod',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: _selectedTabIndex == 0 ? Colors.indigo : Colors.grey,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _selectedTabIndex = 1),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: _selectedTabIndex == 1
                        ? Colors.indigo
                        : Colors.transparent,
                    width: 3,
                  ),
                ),
              ),
              child: Text(
                'Carta Kedudukan',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: _selectedTabIndex == 1 ? Colors.indigo : Colors.grey,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRekodSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Statistics Cards
        _buildStatisticsCards(),
        const SizedBox(height: 24),

        // Today's Records
        const Text(
          'Rekod Hari Ini',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),

        // Records List
        records.isEmpty
            ? Container(
                padding: const EdgeInsets.all(32),
                alignment: Alignment.center,
                child: const Text(
                  'Tiada rekod untuk hari ini',
                  style: TextStyle(color: Colors.grey),
                ),
              )
            : ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: records.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  return _buildRecordCard(records[index]);
                },
              ),
      ],
    );
  }

  Widget _buildCartaSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Carta subsection selection
        _buildCartaSubsectionSelection(),
        const SizedBox(height: 20),

        // Student list based on selected subsection
        _buildStudentsList(),
      ],
    );
  }

  Widget _buildCartaSubsectionSelection() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _selectedCartaSubsection = 0),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: _selectedCartaSubsection == 0
                        ? Colors.indigo
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
              child: Text(
                'Semua Pelajar',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: _selectedCartaSubsection == 0
                      ? Colors.indigo
                      : Colors.grey,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _selectedCartaSubsection = 1),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: _selectedCartaSubsection == 1
                        ? Colors.indigo
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
              child: Text(
                'Mengikut Kelas',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: _selectedCartaSubsection == 1
                      ? Colors.indigo
                      : Colors.grey,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _selectedCartaSubsection = 2),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: _selectedCartaSubsection == 2
                        ? Colors.indigo
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
              child: Text(
                'Mengikut Tahun',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: _selectedCartaSubsection == 2
                      ? Colors.indigo
                      : Colors.grey,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStudentsList() {
    final filteredStudents = _getFilteredStudents();

    if (_selectedCartaSubsection == 0) {
      // Semua Pelajar - no grouping
      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: filteredStudents.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          return _buildStudentCard(filteredStudents[index]);
        },
      );
    } else if (_selectedCartaSubsection == 1) {
      // Mengikut Kelas - show class selector then list
      final classes = _getGroupLabels();
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (classes.isNotEmpty) ...[
            DropdownButton<String>(
              value: _selectedClass ?? classes.first,
              items: classes
                  .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
              onChanged: (v) => setState(() => _selectedClass = v),
            ),
            const SizedBox(height: 12),
          ],
          ...filteredStudents.map(
            (student) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildStudentCard(student),
            ),
          ),
        ],
      );
    } else {
      // Mengikut Tahun - show year selector then list
      final years = _getGroupLabels();
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (years.isNotEmpty) ...[
            DropdownButton<String>(
              value: _selectedYear ?? years.first,
              items: years
                  .map(
                    (y) => DropdownMenuItem(value: y, child: Text('Tahun $y')),
                  )
                  .toList(),
              onChanged: (v) => setState(() => _selectedYear = v),
            ),
            const SizedBox(height: 12),
          ],
          ...filteredStudents.map(
            (student) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildStudentCard(student),
            ),
          ),
        ],
      );
    }
  }

  Widget _buildStudentCard(StudentBehaviorStats student) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Student name and class
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        student.studentName,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        student.className,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Stats row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('Baik', student.baik.toString(), Colors.green),
                _buildStatItem('Buruk', student.buruk.toString(), Colors.red),
                _buildStatItem(
                  'Mata',
                  student.totalMata.toString(),
                  Colors.blue,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey)),
      ],
    );
  }

  Widget _buildStatisticsCards() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            title: 'Baik',
            count: stats.baik.toString(),
            backgroundColor: Colors.green.shade50,
            textColor: Colors.green,
            icon: Icons.thumb_up,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            title: 'Buruk',
            count: stats.buruk.toString(),
            backgroundColor: Colors.red.shade50,
            textColor: Colors.red,
            icon: Icons.thumb_down,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            title: 'Mata',
            count: stats.totalMata.toString(),
            backgroundColor: Colors.blue.shade50,
            textColor: Colors.blue,
            icon: Icons.star,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String title,
    required String count,
    required Color backgroundColor,
    required Color textColor,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: textColor.withAlpha((0.3 * 255).round())),
      ),
      child: Column(
        children: [
          Icon(icon, color: textColor, size: 28),
          const SizedBox(height: 8),
          Text(
            count,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: textColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecordCard(BehaviorRecord record) {
    bool isBaik = record.act == 'Baik';
    Color accentColor = isBaik ? Colors.green : Colors.red;

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left side - Record details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Student name
                  Text(
                    record.studentName,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 6),
                  // Act (Baik/Buruk)
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: accentColor.withAlpha((0.2 * 255).round()),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          record.act,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: accentColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  // Detail
                  Text(
                    record.detail,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            // Right side - Mata display
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isBaik ? Colors.green.shade50 : Colors.red.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isBaik ? Colors.green : Colors.red,
                  width: 2,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isBaik ? Icons.add : Icons.remove,
                    color: accentColor,
                    size: 20,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${record.mata.abs()} Mata',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: accentColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
