import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pmdc_version_4_client/pmdc_version_4_client.dart';
import 'package:pmdc_version_4_flutter/constants/constants.dart';
import 'package:pmdc_version_4_flutter/core/enums/view_state.dart';
import 'package:pmdc_version_4_flutter/ui/admin/admin_homepage/admin_home_page.dart';
import 'package:pmdc_version_4_flutter/ui/auth/forget_password/enter_otp1.dart';
import 'package:pmdc_version_4_flutter/ui/auth/login_screen/login_provider.dart';

import 'package:provider/provider.dart';

import '../../../widgets/signin_login_btn_widget.dart';

Student? studentDetails;
Teacher? teacherDetails;
String? type;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
    value: item,
    child: Text(
      item,
      style: const TextStyle(fontSize: 20, color: Colors.black),
    ));

late VoidCallback onChanged;

class _LoginScreenState extends State<LoginScreen> {
  final item = ['PMDC dalazak road', 'PMDC Shabqadar'];
  String? value;
  int _groupValue = -1;

  bool _obscuredText = true;
  final _formKey = GlobalKey<FormState>();

  _toggle() {
    setState(() {
      _obscuredText = !_obscuredText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(builder: (context, model, ch) {
      return ModalProgressHUD(
        inAsyncCall: model.state == ViewState.busy,
        progressIndicator: CircularProgressIndicator(
          color: Colors.orange,
        ),
        child: Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
                child: Column(
                  children: [
                    ///Image
                    SizedBox(
                      height: 250,
                      width: double.infinity,
                      child: Image.asset('assets/images/login_logo_img.png'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    ///Direct Access not Allowed Container
                    Container(
                      height: 30,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: kAppColor,
                      ),
                      child: const Center(
                        child: Text(
                          'Direct Access not Allowed',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    ///DropDownButton
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: const BoxDecoration(
                        color: kTextFieldColor,
                      ),
                      child: DropdownButton<String>(
                        elevation: 0,
                        underline: Container(),
                        value: value,
                        hint: const Text('Select Campus'),
                        isExpanded: true,
                        iconSize: 30,
                        icon: const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: kAppColor,
                        ),
                        items: item.map(buildMenuItem).toList(),
                        onChanged: (value) {
                          setState(() {
                            this.value = value;
                          });
                        },
                      ),
                    ),
                    Row(
                      children: const <Widget>[
                        Flexible(
                          child: Divider(
                            thickness: 3,
                            color: Colors.black45,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 7.0, vertical: 5),
                          child: Text(
                            'Select Role',
                            style:
                                TextStyle(fontSize: 20, color: Colors.black45),
                          ),
                        ),
                        Flexible(
                          child: Divider(
                            thickness: 3,
                            color: Colors.black45,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Expanded(
                                child: RadioListTile(
                                  value: 0,
                                  groupValue: _groupValue,
                                  title: const Text(
                                    "Student",
                                  ),
                                  onChanged: (newValue) => setState(() {
                                    // final studentt = Student(
                                    //   id: 1234,
                                    //   studentId: "12345",
                                    //   firstName: "Zaka",
                                    //   lastName: "Ulla",
                                    //   dateOfBirth: "14-4-1998",
                                    //   statue: true,
                                    //   fatherName: "Umar Mommand",
                                    //   image:
                                    //       " https://media.istockphoto.com/id/1300972574/photo/millennial-male-team-leader-organize-virtual-workshop-with-employees-online.jpg?b=1&s=170667a&w=0&k=20&c=96pCQon1xF3_onEkkckNg4cC9SCbshMvx0CfKl2ZiYs=",
                                    //   transport: true,
                                    //   busId: 1,
                                    //   section: "A",
                                    //   scholarship: true,
                                    //   admissionDate: "12-02-2023",
                                    //   gender: "Male",
                                    //   classId: 1,
                                    //   password: "asdf1234",
                                    //   programId: 1,
                                    // );
                                    //   client.student.addStudent(studentt);
                                    _groupValue =
                                        int.parse(newValue.toString());
                                  }),
                                  activeColor: kAppColor,
                                  selected: false,
                                ),
                              ),
                              Expanded(
                                child: RadioListTile(
                                  value: 1,
                                  groupValue: _groupValue,
                                  title: const Text("Teacher"),
                                  onChanged: (newValue) => setState(() =>
                                      _groupValue =
                                          int.parse(newValue.toString())),
                                  activeColor: kAppColor,
                                  selected: false,
                                ),
                              ),
                              Expanded(
                                child: RadioListTile(
                                  value: 2,
                                  groupValue: _groupValue,
                                  title: const Text("Admin"),
                                  onChanged: (newValue) => setState(() =>
                                      _groupValue =
                                          int.parse(newValue.toString())),
                                  activeColor: kAppColor,
                                  selected: false,
                                ),
                              ),
                            ],
                          ),

                          ///email
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: model.emailController,
                            cursorColor: kAppColor,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 10),
                              border: InputBorder.none,
                              fillColor: kTextFieldColor,
                              filled: true,
                              hintText: 'Email / Username',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter a valid email address.";
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(height: 25),

                          ///password
                          TextFormField(
                            obscureText: _obscuredText,
                            controller: model.passwordController,
                            cursorColor: kAppColor,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 10),
                              border: InputBorder.none,
                              hintText: 'Password',
                              fillColor: kTextFieldColor,
                              filled: true,
                              suffixIcon: TextButton(
                                onPressed: _toggle,
                                child: Icon(Icons.remove_red_eye,
                                    color: _obscuredText
                                        ? Colors.black12
                                        : Colors.black54),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {});
                            },
                            validator: (value) {
                              if (value!.isEmpty || value.length < 4) {
                                return "Please enter 6 character long password";
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),

                          Align(
                              alignment: Alignment.topLeft,
                              child: TextButton(
                                  onPressed: () {
                                    if (_groupValue != -1) {
                                      if (_groupValue == 0) {
                                        type = 'student';
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    EnterIdForOtp(
                                                      type: 'student',
                                                    )));
                                      } else if (_groupValue == 1) {
                                        type = 'teacher';
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    EnterIdForOtp(
                                                      type: 'teacher',
                                                    )));
                                      }
                                    } else {
                                      final snackBar = SnackBar(
                                        content:
                                            const Text('Please select type '),
                                        backgroundColor: kAppColor,
                                        action: SnackBarAction(
                                          label: 'dismiss',
                                          textColor: Colors.white,
                                          onPressed: () {},
                                        ),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    }
                                  },
                                  child: const Text(
                                    'Forgot your Password?',
                                    style: TextStyle(color: Colors.black),
                                  ))),
                          const SizedBox(
                            height: 20,
                          ),
                          signIn_login_Btn_widget(
                            onTap: () async {
                              if (value == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Select Campus")));
                                return;
                              }
                              if (value != "PMDC dalazak road") {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            "Selected Campus not available yet")));
                                return;
                              }
                              if (_formKey.currentState!.validate()) {
                                if (_groupValue != -1) {
                                  if (_groupValue == 0) {
                                    model.loginStudent(context);
                                  } else if (_groupValue == 1) {
                                    print("Teacher login");
                                    model.loginTeacher(context);
                                  } else {
                                    model.adminLogin(context);
                                  }
                                } else {
                                  final snackBar = SnackBar(
                                    content: const Text('Please select type '),
                                    backgroundColor: kAppColor,
                                    action: SnackBarAction(
                                      label: 'dismiss',
                                      textColor: Colors.white,
                                      onPressed: () {},
                                    ),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              }
                            },
                            containerText: 'LOGIN',
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),
      );
    });
  }
}
