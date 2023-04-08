import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:pmdc_version_4_client/pmdc_version_4_client.dart';
import 'package:pmdc_version_4_flutter/core/enums/view_state.dart';
import 'package:pmdc_version_4_flutter/core/model/base_view_model.dart';
import 'package:pmdc_version_4_flutter/core/services/database_storage_services.dart';
import 'package:pmdc_version_4_flutter/main.dart';
import 'package:pmdc_version_4_flutter/ui/auth/login_screen/login_screen.dart';
import 'package:pmdc_version_4_flutter/ui/splash_screen/splash_screen.dart';
import 'package:pmdc_version_4_flutter/ui/teacher/teacher_home_screen/teacher_subject_screen/teacher_subject_detail_screen/teacher_subject_notes.dart';
import 'package:pmdc_version_4_flutter/ui/teacher/teacher_home_screen/teacher_subject_screen/teacher_subject_detail_screen/teacher_subject_video_lecture.dart';

import 'teacher_subject_screen/teacher_subject_detail_screen/teacher_subject_assignments.dart';

List<String> programs = [
  "Computer Sciences",
  "Pre-Engineering",
  "Pre-Medical",
  "Computer Arts",
];

class TeacherHomeScreenProvider extends BaseViewModal {
  // int paid = 0;
  // int unPaid = 0;
  // List<FeeRecord> feeRecords = [];
  GlobalKey<FormState> formKey = GlobalKey();
  List<NoticeBoard> noticeBoard = [];
  List<AssignSubjects> teacherSubjects = [];
  List<AssignSubjects> filterSubject = [];
  List<Library> libraryBooks = [];
  List<VideoLectures> listOfVideoLecture = [];
  List<SubjectNotes>? subjectNotes = [];
  List<Assignments>? assignments = [];
  List<Announcement> announcements = [];
  List<SubjectDiary> subjectDiaries = [];
  List<SubjectDiary> listOfDiary = [];
  List<Student>? listOfStudents = [];
  List<Submitasignment>? listOfTeacherSubmitedAssignment = [];
  String? imgurl;
  SubjectDiary subjectDiary = SubjectDiary(
    weekNo: "weekNo",
    chapterNo: "chapterNo",
    chapterName: "chapterName",
    topic: "topic",
    dateAdded: "dateAdded",
    status: "status",
    subjectId: 0,
    section: "section",
    programId: 0,
    classId: 0,
  );
  VideoLectures videoLecture = VideoLectures(
    chapterName: "chapterName",
    chapterNo: "chapterNo",
    topic: "topic",
    file: "file",
    teacherId: 0,
    dateAdded: "dateAdded",
    viewCount: "viewCount",
    subjectId: 0,
    programId: 0,
    section: "section",
    classId: 0,
  );
  Announcement announcement = Announcement(
    sNo: 1,
    title: "title",
    description: "description",
    publishDate: "publishDate",
    subjectId: 0,
    programId: 0,
    section: "section",
    classId: 0,
    teacherId: "0",
  );
  Assignments assignment = Assignments(
      title: '',
      deadLine: '',
      topic: '',
      file: '',
      isSubmited: true,
      dateAdded: '',
      subjectId: 0,
      section: "a",
      programId: '',
      classId: 0,
      teacherId: '0');
  File? scannedDocumentFile;
  File? file;
  File? documentFile;
  double progress = 0;
  DatabaseStorageServices _firebaseService = DatabaseStorageServices();
  SubjectNotes subjectNote = SubjectNotes(
      chapterName: '',
      chapterNo: '',
      topic: '',
      file: '',
      teacherId: '',
      dateAdded: '',
      viewCount: '',
      subjectId: '',
      programId: 0,
      section: "",
      classId: 0);

  logOut(context) {
    List<NoticeBoard> noticeBoard = [];
    List<AssignSubjects> teacherSubjects = [];
    List<AssignSubjects> filterSubject = [];
    // List<Library> libraryBooks = [];
    List<VideoLectures> listOfVideoLecture = [];
    List<SubjectNotes>? subjectNotes = [];
    List<Assignments>? assignments = [];
    List<Announcement> announcements = [];
    List<SubjectDiary> listOfDiary = [];
    List<Student>? listOfStudents = [];
    List<Submitasignment>? listOfTeacherSubmitedAssignment = [];
    String? imgurl;
    File? scannedDocumentFile;
    File? file;
    File? documentFile;
    double progress = 0;
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => SplashScreen()),
        (route) => false);
  }

  // constructor

  // TeacherHomeScreenProvider() {
  //   init();
  // }

  // init

  init() async {
    setState(ViewState.busy);

    await getNoticeBoard();
    await getLibraryBooks();
    await getTeacherSubject();
    setState(ViewState.idle);
    notifyListeners();
  }

  // get Notice Board Details

  Future<void> getNoticeBoard() async {
    try {
      noticeBoard = await client.noticeBoard.getNotice().then((value) {
        print("Notice Board ${value[0].notice}");
        return value;
      });
    } catch (e) {
      print("Error Occured at notice board: $e");
    }

    print("Notice Board length: ${noticeBoard.length}");
  }

  //  Getting Teacher Subjects

  Future<void> getTeacherSubject() async {
    try {
      teacherSubjects = await client.assignSubjects
          .getTeacherSubjects(int.parse(teacherDetails!.teacherid))
          .then((value) {
        print("Teacher Subject ${value?[0].subjectName}");
        return value!;
      });
    } catch (e) {
      print("Error Occured at getting subjects: $e");
    }
    print("Subjects length: ${teacherSubjects.length}");
  }

  //  Getting teacher Submitted Assignment

  Future<void> getTeacherSubmitedAssignment(index) async {
    try {
      listOfTeacherSubmitedAssignment =
          await client.assignment.getSubmitasignment(assignments![index].id);
    } catch (e) {}
  }

  //  Getting Library Books

  Future<void> getLibraryBooks() async {
    try {
      libraryBooks = await client.library.getBooks(teacherDetails!.teacherid);
    } catch (e) {}
  }

  // Getting SubjectNotes

  Future getSubjectNotes(AssignSubjects assignSubject) async {
    print(
        "Teacher id: ${assignSubject.teacherId}, subject Id: ${assignSubject.subjectId}, Class: ${assignSubject.classId}, program: ${assignSubject.programId}, section: ${assignSubject.section}");
    subjectNotes = await client.subjectnotes.getSubjectNotesTeacher(
      assignSubject.teacherId,
      assignSubject.subjectId,
      assignSubject.classId,
      assignSubject.programId,
      assignSubject.section,
    );
    print("Notes Length: ${subjectNotes?.length}");
  }

  // Getting Assignments

  Future getAssignments(AssignSubjects assignSubject) async {
    print(
        "Teacher id: ${assignSubject.teacherId}, subject Id: ${assignSubject.subjectId}, Class: ${assignSubject.classId}, program: ${assignSubject.programId}, section: ${assignSubject.section}");
    assignments = await client.assignment.getAssignmentsTeacher(
      assignSubject.teacherId,
      assignSubject.subjectId,
      assignSubject.classId,
      assignSubject.programId,
      assignSubject.section,
    );
    print("Assignments Length: ${assignments?.length}");
  }

  // Getting Subject Diary

  Future getSubjectDiary(AssignSubjects assignSubject) async {
    print(
        "Teacher id: ${assignSubject.teacherId}, subject Id: ${assignSubject.subjectId}, Class: ${assignSubject.classId}, program: ${assignSubject.programId}, section: ${assignSubject.section}");
    listOfDiary = await client.subjectdiary.getSubjectDiaryTeacher(
      assignSubject.teacherId,
      assignSubject.subjectId,
      assignSubject.classId,
      assignSubject.programId,
      assignSubject.section,
    );
    print("Assignments Length: ${assignments?.length}");
  }

  // Getting VideoLecture

  Future getVideoLecture(AssignSubjects assignSubject) async {
    print(
        "Teacher id: ${assignSubject.teacherId}, subject Id: ${assignSubject.subjectId}, Class: ${assignSubject.classId}, program: ${assignSubject.programId}, section: ${assignSubject.section}");
    listOfVideoLecture = await client.videolecture.getVideoLectureTeacher(
      int.parse(assignSubject.teacherId),
      int.parse(assignSubject.subjectId),
      assignSubject.classId,
      assignSubject.programId,
      assignSubject.section,
    );
    print("Assignments Length: ${assignments?.length}");
  }

  //  Filterring Subjects According to classes

  void filterSubjects(classId) {
    if (classId == 0) {
      filterSubject = teacherSubjects;
    } else {
      filterSubject = teacherSubjects
          .where((subject) => subject.classId == classId)
          .toList();
    }
  }

  // adding subject notes

  Future<void> addSubjectNotes(index, context) async {
    setState(ViewState.busy);

    print("Screen index $index");
    subjectNote.classId = filterSubject[index].classId;
    subjectNote.programId = filterSubject[index].programId;
    subjectNote.section = filterSubject[index].section;
    subjectNote.subjectId = filterSubject[index].subjectId;
    subjectNote.teacherId = filterSubject[index].teacherId;
    subjectNote.dateAdded = DateTime.now().toString();
    subjectNote.viewCount = '2';
    //  subjectNote.file = '';
    print("${subjectNote.chapterName}   ${subjectNote.teacherId}");
    try {
      final file = await _firebaseService.uploadFile(
          image: documentFile!,
          userId: subjectNote.teacherId,
          callBack: (progress) {
            print("progress<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
            progress = progress;
            notifyListeners();
          });
      subjectNote.file = file.toString();
      await client.subjectnotes.addSubjectNotes(subjectNote).then((value) {
        if (value == true) {
          subjectNotes?.add(subjectNote);

          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Notes Uploaded")));
          Navigator.of(context).pop();
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Error, Try again")));
        }
      });
    } catch (e) {}
    setState(ViewState.idle);
  }

  // adding subject notes

  Future<void> addDiary(index, context) async {
    setState(ViewState.busy);

    print("Screen index $index");
    subjectDiary.classId = filterSubject[index].classId;
    subjectDiary.programId = filterSubject[index].programId;
    subjectDiary.section = filterSubject[index].section;
    subjectDiary.subjectId = int.parse(filterSubject[index].subjectId);

    subjectDiary.dateAdded = DateTime.now().toString();

    //  subjectNote.file = '';
    print("${subjectNote.chapterName}   ${subjectNote.teacherId}");
    try {
      final file = await _firebaseService.uploadFile(
          image: documentFile!,
          userId: subjectDiary.subjectId.toString(),
          callBack: (progress) {
            print("progress<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
            progress = progress;
            notifyListeners();
          });

      await client.subjectdiary.addSubjectDiary(subjectDiary).then((value) {
        if (value == true) {
          listOfDiary.add(subjectDiary);

          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Notes Uploaded")));
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => TeacherSubjectNotesScreen(index: index)));
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Error, Try again")));
        }
      });
    } catch (e) {}
    setState(ViewState.idle);
  }

  // adding Video Lecture

  Future<void> addVideoLecture(index, context) async {
    setState(ViewState.busy);
    notifyListeners();

    print("Screen index $index");
    videoLecture.classId = filterSubject[index].classId;
    videoLecture.programId = filterSubject[index].programId;
    videoLecture.section = filterSubject[index].section;
    videoLecture.subjectId = int.parse(filterSubject[index].subjectId);
    videoLecture.teacherId = int.parse(filterSubject[index].teacherId);
    videoLecture.dateAdded = DateTime.now().toString();
    videoLecture.viewCount = '2';
    //  subjectNote.file = '';
    print("${videoLecture.chapterName}   ${subjectNote.teacherId}");
    try {
      // final file = await _firebaseService.uploadFile(
      //     image: documentFile!,
      //     userId: videoLecture.teacherId.toString(),
      //     callBack: (progress) {
      //       print("progress<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
      //       progress = progress;
      //       notifyListeners();
      //     });
      videoLecture.file = imgurl.toString();
      await client.videolecture.addVideoLecture(videoLecture).then((value) {
        if (value == true) {
          listOfVideoLecture.add(videoLecture);

          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Lecture Uploaded")));
          Navigator.of(context).pop();
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Error, Try again")));
        }
      });
    } catch (e) {
      print("error $e");
    }
    setState(ViewState.idle);
    notifyListeners();
  }

  //  Adding assignments
  Future<void> addAssignment(index, context) async {
    setState(ViewState.busy);

    print("Screen index $index");
    assignment.classId = filterSubject[index].classId;
    assignment.programId = filterSubject[index].programId.toString();
    assignment.section = filterSubject[index].section;
    assignment.subjectId = int.parse(filterSubject[index].subjectId);
    assignment.teacherId = filterSubject[index].teacherId;
    assignment.dateAdded = DateTime.now().toString();
    assignment.isSubmited = true;

    //  subjectNote.file = '';
    print("${assignment.deadLine}   ${assignment.teacherId}");
    try {
      final file = await _firebaseService.uploadFile(
          image: documentFile!,
          userId: assignment.teacherId.toString(),
          callBack: (progress) {
            print("progress<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
            progress = progress;
            notifyListeners();
          });
      assignment.file = file.toString();
      await client.assignment.addAssignment(assignment).then((value) {
        if (value == true) {
          assignments?.add(assignment);

          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Assignment Uploaded")));
          Navigator.of(context).pop();
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Error, Try again")));
        }
      });
    } catch (e) {}
    setState(ViewState.idle);
  }

  bool isLoading = false;

  Future<String?> videotakenGallery() async {
    isLoading = true;
    notifyListeners();
    final picker = ImagePicker();
    final imagefile = await picker.pickVideo(source: ImageSource.gallery);

    final ref = await FirebaseStorage.instance
        .ref()
        .child('Posts')
        .child(DateTime.now().toString());
    // ignore: unused_local_variable
    final image = File(imagefile!.path);

    await ref.putFile(image);
    final url = await ref.getDownloadURL();
    //  Navigator.of(context).pop();

    imgurl = url;
    isLoading = false;
    notifyListeners();
    return imgurl;
    // controller = VideoPlayerController.network('${imgurl}')
    //   ..initialize().then((value) {
    //     setState(() {});
    //   });
  }

  openFilePicker(BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: [
          'pdf',
        ],
      );

      if (result != null) {
        file = File(result.files.single.path!);

        print(file!.path);
        notifyListeners();
        return file;
      } else {
        // User canceled the picker
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("message: ${e}")));

      print(e);
    }
  }

  void viewFile(File file) {
    OpenFile.open(
      file.path,
    );
  }

  // Updating Subject Notes

  Future<void> UpdateSubjectNotes(index, context) async {
    setState(ViewState.busy);

    print("Screen index $index");
    subjectNote.classId = subjectNotes![index].classId;
    subjectNote.programId = subjectNotes![index].programId;
    subjectNote.section = subjectNotes![index].section;
    subjectNote.subjectId = subjectNotes![index].subjectId;
    subjectNote.teacherId = subjectNotes![index].teacherId;
    subjectNote.dateAdded = DateTime.now().toString();
    subjectNote.viewCount = '2';
    subjectNote.id = subjectNotes![index].id;
    //  subjectNote.file = '';
    print("${subjectNote.chapterName}   ${subjectNote.teacherId}");
    try {
      final file = await _firebaseService.uploadFile(
          image: documentFile!,
          userId: subjectNote.teacherId,
          callBack: (progress) {
            print("progress<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
            progress = progress;
            notifyListeners();
          });
      subjectNote.file = file.toString();
      print("url: ${subjectNote.file}");

      await client.subjectnotes.updateSubjectNotes(subjectNote).then((value) {
        if (value == true) {
          subjectNotes?[index] = subjectNote;

          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Notes Updated")));
          Navigator.of(context).pop();
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Error, Try again")));
        }
      });
    } catch (e) {}
    setState(ViewState.idle);
  }

  // Updating Video lECTURE

  Future<void> UpdateVideoLecture(index, context) async {
    setState(ViewState.busy);

    print("Screen index $index");
    videoLecture.classId = listOfVideoLecture[index].classId;
    videoLecture.programId = listOfVideoLecture[index].programId;
    videoLecture.section = listOfVideoLecture[index].section;
    videoLecture.subjectId = listOfVideoLecture[index].subjectId;
    videoLecture.teacherId = listOfVideoLecture[index].teacherId;
    videoLecture.dateAdded = DateTime.now().toString();
    videoLecture.viewCount = '2';
    videoLecture.id = listOfVideoLecture[index].id;
    //  subjectNote.file = '';
    print("${subjectNote.chapterName}   ${subjectNote.teacherId}");
    try {
      final file = await _firebaseService.uploadFile(
          image: documentFile!,
          userId: videoLecture.teacherId.toString(),
          callBack: (progress) {
            print("progress<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
            progress = progress;
            notifyListeners();
          });
      videoLecture.file = file.toString();
      print("url: ${videoLecture.file}");

      await client.videolecture.updateVideoLectures(videoLecture).then((value) {
        if (value == true) {
          listOfVideoLecture[index] = videoLecture;

          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Lecture Updated")));
          Navigator.of(context).pop();
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Error, Try again")));
        }
      });
    } catch (e) {}
    setState(ViewState.idle);
  }

  //  Updatng Assignments

  Future<void> UpdateAssignments(index, context) async {
    setState(ViewState.busy);
    notifyListeners();
    print("Screen index $index");
    assignment.classId = assignments![index].classId;
    assignment.programId = assignments![index].programId;
    assignment.section = assignments![index].section;
    assignment.subjectId = assignments![index].subjectId;
    assignment.teacherId = assignments![index].teacherId;
    assignment.dateAdded = assignments![index].dateAdded;
    assignment.isSubmited = true;
    assignment.id = assignments![index].id;
    //  subjectNote.file = '';
    // print("${subjectNote.chapterName}   ${subjectNote.teacherId}");
    try {
      final file = await _firebaseService.uploadFile(
          image: documentFile!,
          userId: assignment.teacherId,
          callBack: (progress) {
            print("progress<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
            progress = progress;
            notifyListeners();
          });
      assignment.file = file.toString();
      print("url: ${assignment.file}");

      await client.assignment.updateAssignment(assignment).then((value) {
        if (value == true) {
          assignments?[index] = assignment;

          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Assignment Updated")));
          Navigator.of(context).pop();
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Error, Try again")));
        }
      });
    } catch (e) {}
    setState(ViewState.idle);
    notifyListeners();
  }

  //  Delete subject note
  Future<void> deleteSubjectNote(noteId) async {
    setState(ViewState.busy);
    try {
      await client.subjectnotes.deleteSubjectNotes(noteId).then(
          (value) => subjectNotes?.removeWhere((note) => note.id == noteId));
    } catch (e) {}

    setState(ViewState.idle);
    notifyListeners();
  }

  //  Delete Video Lecture
  Future<void> deleteVideoLecture(noteId, index) async {
    setState(ViewState.busy);
    try {
      await client.videolecture
          .deleteVideoLectures(noteId)
          .then((value) => listOfVideoLecture.removeAt(index));
    } catch (e) {}
    setState(ViewState.idle);
    notifyListeners();
  }

  //  Delete Assignmnt
  Future<void> deleteAssignment(assignmentId) async {
    setState(ViewState.busy);
    try {
      await client.assignment.deleteAssignment(assignmentId).then((value) =>
          assignments
              ?.removeWhere((assignment) => assignment.id == assignmentId));
    } catch (e) {}
    setState(ViewState.idle);
    notifyListeners();
  }

  // Add announcement

  Future<void> addAnnouncement(index, context) async {
    setState(ViewState.busy);

    print("Add Announcement");
    announcement.sNo = 100;
    announcement.classId = filterSubject[index].classId;
    announcement.programId = filterSubject[index].programId;
    announcement.section = filterSubject[index].section;
    announcement.subjectId = int.parse(filterSubject[index].subjectId);
    announcement.teacherId = filterSubject[index].teacherId;
    announcement.publishDate = DateTime.now().toString();
    try {
      await client.announcement.addAnnouncement(announcement);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Announcement Posted")));
      Navigator.of(context).pop();
    } catch (e) {}
    setState(ViewState.idle);
    notifyListeners();
  }

  Future<void> getAnnouncements(AssignSubjects assignSubject) async {
    print(
        "Teacher id: ${assignSubject.teacherId}, subject Id: ${assignSubject.subjectId}, Class: ${assignSubject.classId}, program: ${assignSubject.programId}, section: ${assignSubject.section}");
    announcements = await client.announcement.getAnnouncementTeacher(
      assignSubject.teacherId,
      assignSubject.subjectId,
      assignSubject.classId,
      assignSubject.programId,
      assignSubject.section,
    );
    print("Announcement Length: ${assignments?.length}");
  }

  Future<void> deleteAnnouncement(announcementId) async {
    setState(ViewState.busy);
    try {
      await client.announcement.deleteAnnouncement(announcementId).then(
          (value) => announcements
              .removeWhere((assignment) => assignment.id == announcementId));
    } catch (e) {}
    setState(ViewState.idle);
    notifyListeners();
  }

  Future<void> listOfStudent(AssignSubjects assignSubject) async {
    listOfStudents = await client.student.getStudents(
        assignSubject.classId, assignSubject.programId, assignSubject.section);
  }
}
