import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_teacher_screen.dart';
import 'screens/dashboard_parent.dart';
import 'screens/select_child.dart';

void main() {
  runApp(const EduPulseApp());
}

class EduPulseApp extends StatelessWidget {
  const EduPulseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EduPulse QR',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),

        // Dashboard untuk guru
        '/teacher_dashboard': (context) => const DashboardPage(),

        // Skrin pemilihan anak untuk ibu bapa
        '/select_child_screen': (context) => const SelectChildScreen(),

        // Dashboard untuk ibu bapa
        '/parent_dashboard': (context) => const ParentDashboardScreen(),
      },
    );
  }
}
