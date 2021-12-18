import 'package:flutter/material.dart';
import '../admin/admin_home.dart';
import '../admin/register.dart';
import '../auth/login.dart';
import '../auth/root_page.dart';
import '../pages/profile.dart';
import '../pages/students_data.dart';
import '../teacher/qr_code.dart';
import '../teacher/students_attendance.dart';
import '../teacher/teacher_data.dart';

class RouteGenerator {

  static Route<dynamic> generateRoute(RouteSettings settings) {

    final args = settings.arguments;

    switch (settings.name) {

      case RootPage.id:
        return MaterialPageRoute(builder: (_) => const RootPage());
        break;

      case Login.id:
        return MaterialPageRoute(builder: (_) => const RootPage());
        break;

      case Profile.id:
        return MaterialPageRoute(builder: (_) => Profile(currentUserId: args,));
        break;

      case AdminHome.id:
        return MaterialPageRoute(builder: (_) => const AdminHome());
        break;

      case StudentsData.id:
        return MaterialPageRoute(builder: (_) => const StudentsData());
        break;

      case TeacherData.id:
        return MaterialPageRoute(builder: (_) => const TeacherData());
        break;

      case QRCode.id:
        return MaterialPageRoute(builder: (_) => QRCode());
        break;

      case StudentsAttendance.id:
        return MaterialPageRoute(builder: (_) => const StudentsAttendance());
        break;

      case Register.id:
        return MaterialPageRoute(builder: (_) => const Register());
        break;

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}