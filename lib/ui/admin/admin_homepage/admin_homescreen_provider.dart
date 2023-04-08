import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pmdc_version_4_client/pmdc_version_4_client.dart';
import 'package:pmdc_version_4_flutter/core/enums/view_state.dart';
import 'package:pmdc_version_4_flutter/core/model/base_view_model.dart';
import 'package:pmdc_version_4_flutter/core/services/database_storage_services.dart';
import 'package:pmdc_version_4_flutter/main.dart';
import 'package:pmdc_version_4_flutter/ui/admin/admin_homepage/admin_home_page.dart';
import 'package:pmdc_version_4_flutter/ui/admin/admin_homepage/all_teachers.dart';
import 'package:pmdc_version_4_flutter/ui/admin/admin_homepage/asign_subjects.dart';
import 'package:pmdc_version_4_flutter/ui/admin/all_students.dart';
import 'package:pmdc_version_4_flutter/ui/admin/fee_submission_screen.dart';
import 'package:pmdc_version_4_flutter/ui/auth/forget_password/otp_screen.dart';
import 'package:pmdc_version_4_flutter/ui/auth/forget_password/update_password.dart';
import 'package:pmdc_version_4_flutter/ui/auth/login_screen/login_screen.dart';
import 'package:pmdc_version_4_flutter/ui/splash_screen/splash_screen.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

class AdminHomeScreenProvider extends BaseViewModal {
  final String accountSid = "AC34af0205177fefc595381d7893ed803f";
  final String authToken = "cdf0661c5730b36e5fa9bb413fccab48";
  final String twilioNumber = "+12536525788";
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController fatherName = TextEditingController();
  TextEditingController dateOfBirth = TextEditingController();
  TextEditingController section = TextEditingController();
  TextEditingController studentId = TextEditingController();
  //TextEditingController classNo = TextEditingController();
  TextEditingController program = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phoneNo = TextEditingController();
  final classNo = GlobalKey<FormFieldState>();
  final sectionMen = GlobalKey<FormFieldState>();
  final progremMen = GlobalKey<FormFieldState>();
  final subject = GlobalKey<FormFieldState>();

  TextEditingController teachername = TextEditingController();
  TextEditingController teacherId = TextEditingController();
  TextEditingController teacherDOB = TextEditingController();
  TextEditingController teacherQualification = TextEditingController();
  TextEditingController teacherPassword = TextEditingController();
  TextEditingController teacherPhoneNo = TextEditingController();
  TextEditingController teacherAge = TextEditingController();
  String? imageee;
  List<Subjects> listOfSubjects = [
    Subjects(
      subjectId: '1',
      subjectName: "Math",
      classId: 0,
      programId: 0,
      subjectCode: 'CSC11',
    ),
    Subjects(
      subjectId: '2',
      subjectName: "CSC12",
      classId: 0,
      programId: 0,
      subjectCode: 'CSC13',
    ),
    Subjects(
      subjectId: '3',
      subjectName: "English",
      classId: 0,
      programId: 0,
      subjectCode: 'CSC14',
    ),
    Subjects(
      subjectId: '4',
      subjectName: "Islamic Studies",
      classId: 0,
      programId: 0,
      subjectCode: 'CSC11',
    ),
    Subjects(
      subjectId: '5',
      subjectName: "Introduction To Computing",
      classId: 0,
      programId: 0,
      subjectCode: 'CSC17',
    ),
    Subjects(
      subjectId: '7',
      subjectName: "Stastics",
      classId: 0,
      programId: 0,
      subjectCode: 'CSC100',
    ),
    Subjects(
      subjectId: '8',
      subjectName: "Physics",
      classId: 0,
      programId: 0,
      subjectCode: 'CSC114',
    ),
    Subjects(
      subjectId: '5',
      subjectName: "Fundamental Of Programming",
      classId: 0,
      programId: 0,
      subjectCode: 'CSC1111',
    ),
    Subjects(
      subjectId: '10',
      subjectName: "Pakstudies",
      classId: 0,
      programId: 0,
      subjectCode: 'CSC119',
    ),
    Subjects(
      subjectId: '6',
      subjectName: "Chemistry",
      classId: 0,
      programId: 0,
      subjectCode: 'CSC22',
    ),
    Subjects(
      subjectId: '9',
      subjectName: "Biology",
      classId: 0,
      programId: 0,
      subjectCode: 'CSC29',
    ),
  ];
  AssignSubjects assignSubjects = AssignSubjects(
      subjectName: "subjectName",
      assignDate: "assignDate",
      subjectId: "subjectId",
      programId: 0,
      classId: 0,
      section: "section",
      teacherId: "0");
  Teacher teacher = Teacher(
      teacherid: "teacherId",
      teacherName: "teacherName",
      dateOfBirth: "dateOfBirth",
      qualification: "qualification",
      status: true,
      transport: true,
      busId: true,
      age: 0,
      password: "password",
      subjectId: "subjectId",
      teacherimage: "",
      phonenumber: "");
  Student student = Student(
      studentid: 0,
      firstName: "firstName",
      lastName: "lastName",
      dateOfBirth: "dateOfBirth",
      statue: true,
      fatherName: "fatherName",
      image: "image",
      transport: true,
      busId: 2,
      section: "section",
      scholarship: false,
      admissionDate: "02-03-2023",
      gender: "Male",
      classId: 0,
      password: "password",
      programId: 0,
      phonenumber: "");

  final listOfClasses = ['1st Year', '2nd Year'];
  final listOfPrograms = [
    'Computer Sciences',
    'Pre-Engineering',
    'Pre-Medical'
  ];
  final listOfSection = ['A', 'B'];
  final status = [true, false];

  clearData(context) {
    paidd = 0;
    unPaidd = 0;
    feeRecords = [];

    students = null;

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => SplashScreen()),
        (route) => false);
  }

  // Add Student
  Future addStudent(context) async {
    setState(ViewState.busy);

    student.firstName = firstName.text;
    student.lastName = firstName.text;
    student.fatherName = fatherName.text;
    student.dateOfBirth = dateOfBirth.text;
    student.password = password.text;
    student.phonenumber = phoneNo.text;

    student.studentid = int.parse(studentId.text);
    student.image = imageee.toString();
    var response;
    try {
      response = await client.student.addStudent(student);
      print("Response: ${response}");
      firstName = TextEditingController();
      lastName = TextEditingController();
      fatherName = TextEditingController();
      dateOfBirth = TextEditingController();
      section = TextEditingController();
      studentId = TextEditingController();
      //TextEditingController classNo = TextEditingController();
      program = TextEditingController();
      password = TextEditingController();
      student = Student(
          studentid: 0,
          firstName: "firstName",
          lastName: "lastName",
          dateOfBirth: "dateOfBirth",
          statue: false,
          fatherName: "fatherName",
          image: "image",
          transport: true,
          busId: 0,
          section: "section",
          scholarship: true,
          admissionDate: "admissionDate",
          gender: "gender",
          classId: 1,
          password: "password",
          programId: 1,
          phonenumber: "");
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Admin_homepage()));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Registeration Failed")));
    }
    setState(ViewState.idle);
    notifyListeners();
  }

  // Pick Image
  ImagePicker imagePicker = ImagePicker();
  DatabaseStorageServices _databaseStorageServices = DatabaseStorageServices();
  File? image;
  pickImageCamera() async {
    final img = await imagePicker.pickImage(source: ImageSource.camera);
    if (img != null) {
      image = File(img.path);

      String? ig = await _databaseStorageServices.uploadUserImage(
          image!, DateTime.now().toString());
      imageee = ig;
    }
    print("image: $imageee");
    notifyListeners();
  }

  pickImageGallery() async {
    final img = await imagePicker.pickImage(source: ImageSource.gallery);
    if (img != null) {
      image = File(img.path);

      String? ig = await _databaseStorageServices.uploadUserImage(
          image!, DateTime.now().toString());
      imageee = ig;
    }
    notifyListeners();
  }

  // Add Teacher
  Future addTeacher(context) async {
    setState(ViewState.busy);
    teacher.id = 4;

    teacher.teacherName = teachername.text;
    teacher.teacherid = teacherId.text;
    teacher.password = teacherPassword.text;

    teacher.qualification = teacherQualification.text;
    teacher.subjectId = '0';
    teacher.teacherimage = imageee.toString();
    teacher.phonenumber = teacherPhoneNo.text;

    //student.studentId = studentId.text;
    try {
      await client.teacher.addTeacher(teacher);
      teachername = TextEditingController();
      teacherId = TextEditingController();
      teacherDOB = TextEditingController();
      teacherQualification = TextEditingController();
      teacherPassword = TextEditingController();
      teacherAge = TextEditingController();
      imageee = null;
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => AssignASubject()));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Registeration Failed")));
    }
    setState(ViewState.idle);
  }

  // Assign a Subject to Teacher
  Future assignASubject(context) async {
    setState(ViewState.busy);
    assignSubjects.assignDate =
        DateFormat('dd MMMM yyyy').format(DateTime.now());
    assignSubjects.teacherId = teacher.teacherid;
    //student.studentId = studentId.text;
    try {
      await client.assignSubjects.assignAsubject(assignSubjects);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 5),
          content: Text(
              "${assignSubjects.subjectName} assigned to ${teacher.teacherName}")));
      assignSubjects = AssignSubjects(
          subjectName: 'subjectName',
          assignDate: 'assignDate',
          subjectId: 'subjectId',
          programId: 0,
          classId: 0,
          section: "section",
          teacherId: "0");
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Failed, Try again")));
    }

    setState(ViewState.idle);
  }

  // Add Fee Rocord
  FeeRecord feeRecord = FeeRecord(
      totalFee: 60000,
      paid: 0,
      instalmentDate: "instalmentDate",
      studentId: "studentId");
  TextEditingController studentName = TextEditingController();
  TextEditingController idd = TextEditingController();
  TextEditingController totalFee = TextEditingController(text: '60000');
  TextEditingController paid = TextEditingController();
  TextEditingController unPaid = TextEditingController();

  Future addFeeRecord(context, instalment) async {
    setState(ViewState.busy);
    feeRecord.instalmentDate =
        DateFormat('dd MMMM yyyy').format(DateTime.now());
    feeRecord.studentId = studentOnFeeRecord!.studentid.toString();
    feeRecord.paid = int.parse(instalment);
    try {
      await client.feeRecord.addFeeRecord(feeRecord);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Fee Submitted")));
      studentName = TextEditingController();
      idd = TextEditingController();
      totalFee = TextEditingController(text: '60000');
      paid = TextEditingController();
      unPaid = TextEditingController();
      studentOnFeeRecord = null;
      unPaidd = 0;
      paidd = 0;
      feeRecords = [];
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Admin_homepage()));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Failed, Try again")));
    }
    setState(ViewState.idle);
  }

  /// Get Student
  Student? studentOnFeeRecord;
  Future getStudent(id, context) async {
    setState(ViewState.busy);
    try {
      studentOnFeeRecord = await client.student.getStudentbYiD(
        int.parse(id),
      );
      print("herrrr");
      print("Student Name: ${studentOnFeeRecord?.fatherName}");
      studentName.text = studentOnFeeRecord!.fatherName;
      idd.text = studentOnFeeRecord!.studentid.toString();
      await getFeeRecord();

      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => FeeSubmissionScreen()));
    } catch (e) {
      print("erroe occured $e");
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Cant find a student with this is")));
    }
    setState(ViewState.idle);
  }

  /// Get Student for Forgot Password
  Student? studentForgot;
  Future getStudentForgot(id, context) async {
    setState(ViewState.busy);
    try {
      studentForgot = await client.student.getStudentbYiD(
        int.parse(id),
      );
      print("herrrr");
      print("Student Name: ${studentForgot?.fatherName}");
      final phoneno = studentForgot?.phonenumber.replaceFirst('0', '+92');

      print("Phone No: $phoneno");

      sendSms(
        context,
        name: studentForgot!.firstName,
        dateTime: DateFormat('dd MMMM yyyy').format(DateTime.now()),
        phone: phoneno.toString(),
      );
    } catch (e) {
      print("error occured $e");
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Cant find a student with this id")));
    }
    setState(ViewState.idle);
  }

  /// Get Teacher for Forgot Password
  Teacher? teacherForgot;
  Future getTeacherForgot(String id, context) async {
    setState(ViewState.busy);
    try {
      teacherForgot = await client.teacher.getTeacherbYiD(
        id,
      );
      print("herrrr");
      print("Student Name: ${teacherForgot?.teacherName}");
      final phoneno = teacherForgot?.phonenumber.replaceFirst('0', '+92');

      print("Phone No: $phoneno");

      sendSms(context,
          name: teacherForgot!.teacherName,
          dateTime: DateFormat('dd MMMM yyyy').format(DateTime.now()),
          phone: phoneno.toString());
    } catch (e) {
      print("error occured $e");
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Cant find a teacher with this id")));
    }
    setState(ViewState.idle);
  }

  // comparing otp

  compareOTP(String otp, context) {
    if (otp == otpp.toString()) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => UpdatePassword()));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Wrong OTP")));
    }
  }

  // get Student Fee Record in Installment

  int unPaidd = 0;
  int paidd = 0;
  List<FeeRecord> feeRecords = [];
  feeCalculation() async {
    print("paidddddddddddddd: $paidd");
    feeRecords.forEach((record) async {
      print("ist installment: ${record.paid}");
      paidd += record.paid;
      print("paiddddd: $paidd");
    });
    print("paid: $paidd");
    unPaidd = feeRecords[0].totalFee - paidd;
    print("unpaid: $unPaidd");

    paid.text = paidd.toString();
    unPaid.text = unPaidd.toString();
  }

  Future<void> getFeeRecord() async {
    try {
      feeRecords = await client.feeRecord
          .getFeeRecord(studentOnFeeRecord!.studentid.toString())
          .then((v) {
        if (v.isNotEmpty) {
          print("Fee Record ${v[0].totalFee}");
        }
        return v;
      });
      feeCalculation();
    } catch (e) {
      print("Error Occured: $e");
    }

    print("Fee Record length: ${feeRecords.length}");
    // notifyListeners();
  }

  /// Get All Student
  List<Student?>? students = [];
  Future getAllStudent(context, {repl = false}) async {
    setState(ViewState.busy);
    try {
      students = await client.student.getAllStudents();
      print("herrrr");
      print("Student Name: ${students?.length}");
      if (repl) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => AllStudents()));
      } else {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => AllStudents()));
      }
    } catch (e) {
      print("erroe occured $e");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error Occured")));
    }
    setState(ViewState.idle);
  }

  /// Get All Teachers
  List<Teacher?>? teachers = [];
  Future getAllTeachers(context, {repl = false}) async {
    setState(ViewState.busy);
    try {
      teachers = await client.teacher.getAllTeachers();
      print("herrrr");
      print("teachers Length: ${teachers?.length}");
      if (repl) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => AllTeachers()));
      } else {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => AllTeachers()));
      }
    } catch (e) {
      print("erroe occured $e");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error Occured")));
    }
    setState(ViewState.idle);
    notifyListeners();
  }

  /// Get All Teachers
  Teacher? deleteTeacher;
  Future deleteTeacherr(context, String teachrId) async {
    setState(ViewState.busy);
    try {
      await client.teacher.deleteTeacher(teachrId).then(
          (value) async => teachers = await client.teacher.getAllTeachers());

      print("herrrr");
      print("teachers lenght ${teachers?.length}");
    } catch (e) {
      print("erroe occured $e");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error Occured")));
    }
    setState(ViewState.idle);
    notifyListeners();
  }

  /// Get All Teachers
  Student? deleteStudent;
  Future deleteStudentt(context, int studtId) async {
    setState(ViewState.busy);
    try {
      await client.student.deleteStudent(studtId).then(
          (value) async => students = await client.student.getAllStudents());
      print("herrrr");
    } catch (e) {
      print("erroe occured $e");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error Occured")));
    }
    setState(ViewState.idle);
  }

  // Update Student

  Student? updateStudent;
  Future updateStudentt(context, Student std) async {
    setState(ViewState.busy);
    try {
      await client.student
          .updateStudent(std)
          .then((value) async => await getAllStudent(context));
      print(
          "herrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr ${students?.length}");
    } catch (e) {
      print("error occured $e");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error Occured")));
    }
    setState(ViewState.idle);
  }
  // Update Student

  Future updatePassword(context, Student std) async {
    setState(ViewState.busy);
    try {
      await client.student.updateStudent(std);
      print(
          "herrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr ${students?.length}");
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (route) => false);
    } catch (e) {
      print("error occured $e");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error Occured")));
    }
    setState(ViewState.idle);
  }

  Future updateTeacherPassword(context, Teacher tchr) async {
    setState(ViewState.busy);
    try {
      await client.teacher.updateTeacher(tchr);
      print(
          "herrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr ${teachers?.length}");
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (route) => false);
    } catch (e) {
      print("error occured $e");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error Occured")));
    }
    setState(ViewState.idle);
  }
  // Update Teacher

  Teacher? updateTeacher;
  Future updateTeacherr(context, Teacher teach) async {
    setState(ViewState.busy);
    try {
      await client.teacher
          .updateTeacher(teach)
          .then((value) async => await getAllTeachers(context, repl: true));
      print(
          "herrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr ${teachers?.length}");
    } catch (e) {
      print("error occured $e");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error Occured")));
    }
    setState(ViewState.idle);
  }

  ////
  int? otpp;
  late TwilioFlutter twilioFlutter;
  Future sendSms(
    context, {
    required String name,
    required String dateTime,
    required String phone,
  }) async {
    ///
    ///
    ///
    ///
    otpp = Random().nextInt(999999) + 100000;

    print(otpp);
    try {
      twilioFlutter = TwilioFlutter(
          accountSid: accountSid,
          authToken: authToken,
          twilioNumber: twilioNumber);
    } catch (e) {}

    final smsToUser =
        "Hello ${name}, You got a new OTP from PMDC dalazak Road\nHere is your OTP: $otpp \nDateTime: $dateTime \nphone: ${studentForgot?.phonenumber}  ";

    try {
      final smsSent = twilioFlutter.sendSMS(
        toNumber: "$phone", // Contact number of Admin
        messageBody: smsToUser,
      );
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => EnterOtp()));
    } catch (e) {
      print("@SmsSent" + e.toString());
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Sms Sending Failed")));
    }

    setState(ViewState.idle);
    notifyListeners();
  }
}
