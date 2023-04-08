import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pmdc_version_4_client/pmdc_version_4_client.dart';
import 'package:pmdc_version_4_flutter/core/enums/view_state.dart';
import 'package:pmdc_version_4_flutter/core/model/base_view_model.dart';
import 'package:pmdc_version_4_flutter/ui/admin/admin_homepage/admin_home_page.dart';
import 'package:pmdc_version_4_flutter/ui/student/home_page/home_page.dart';
import 'package:pmdc_version_4_flutter/ui/teacher/teacher_home_page/teacher_home_page.dart';
import 'package:pmdc_version_4_flutter/ui/teacher/teacher_home_screen/home_screen_provider.dart';

import 'package:provider/provider.dart';

import '../../../main.dart';

import 'login_screen.dart';

Admin? adminDetail;

class LoginProvider extends BaseViewModal {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Future<void> loginStudent(context) async {
    setState(ViewState.busy);
    notifyListeners();
    try {
      studentDetails = await client.student
          .getStudent(int.parse(emailController.text), passwordController.text);
    } catch (e) {
      print("errorrrrr $e");
    }
    if (studentDetails != null) {
      print("studentnName ${studentDetails?.firstName}");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Invalid Credential")));
    }
    setState(ViewState.idle);
  }

  Future<void> loginTeacher(context) async {
    print(
        "Email: ${emailController.text}  Password: ${passwordController.text}");
    setState(ViewState.busy);
    notifyListeners();
    try {
      teacherDetails = await client.teacher
          .getTeacher(emailController.text, passwordController.text);
    } catch (e) {
      print("errorrrrr $e");
    }
    if (teacherDetails != null) {
      print("Teacher Name: ${teacherDetails?.teacherName}");
      await Provider.of<TeacherHomeScreenProvider>(context, listen: false)
          .init();
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const TeacherHomePage()));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Invalid Credential")));
    }
    setState(ViewState.idle);
  }

  /// Admin Login
  Future adminLogin(context) async {
    setState(ViewState.busy);
    notifyListeners();
    try {
      adminDetail = await client.admin
          .getAdmin(emailController.text, passwordController.text);
    } catch (e) {
      print("errorrrrr $e");
    }
    if (adminDetail != null) {
      print("Admin Name: ${adminDetail?.adminName}");

      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const Admin_homepage()));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Invalid Credential")));
    }
    setState(ViewState.idle);
  }
}
