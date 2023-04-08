import 'package:flutter/material.dart';
import 'package:pmdc_version_4_client/pmdc_version_4_client.dart';
import 'package:pmdc_version_4_flutter/constants/constants.dart';
import 'package:pmdc_version_4_flutter/main.dart';
import 'package:pmdc_version_4_flutter/ui/auth/login_screen/login_screen.dart';
import 'package:pmdc_version_4_flutter/ui/student/home_page/home_page.dart';

import '../../../widgets/facebook_google_btn_widget.dart';
import '../../../widgets/signin_login_btn_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isSwitched = false;
  bool _obscuredText = true;

  _toggle() {
    setState(() {
      _obscuredText = !_obscuredText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),

                  ///Create your Account Text
                  const Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Text(
                      'Create your Account',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  /// 1st container for facebook icon and text
                  facebook_google_btn_widget(
                    containerColors: const Color(0xff1877F2),
                    containerImage:
                        Image.asset('assets/images/facebook_logo.png'),
                    containerText: 'CONTINUE WITH FACEBOOK',
                    textColor: Colors.white,
                  ),
                  const SizedBox(
                    height: 25,
                  ),

                  /// 2nd container for google icon and tex
                  facebook_google_btn_widget(
                      containerColors: Colors.white,
                      containerImage:
                          Image.asset('assets/images/google_logo.png'),
                      containerText: 'CONTINUE WITH GOOGLE',
                      textColor: Colors.black),

                  const SizedBox(
                    height: 25,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ///name
                        TextFormField(
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          cursorColor: kAppColor,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 10),
                            border: InputBorder.none,
                            hintText: 'Name',
                            fillColor: kTextFieldColor,
                            filled: true,
                          ),
                          validator: (value) {
                            if (value!.isEmpty || value.length < 6) {
                              return 'Name must be at least 6 characters long.';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 25),

                        ///email
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          cursorColor: kAppColor,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 10),
                            border: InputBorder.none,
                            fillColor: kTextFieldColor,
                            filled: true,
                            hintText: 'Enter valid email id as abc@gmail.com',
                          ),
                          validator: (value) {
                            if (value!.isEmpty || !value.contains('@')) {
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
                          controller: passwordController,
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
                            if (value!.isEmpty || value.length < 6) {
                              return "Please enter 6 character long password";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),

                        ///agree condition
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                                text: const TextSpan(
                                    text: 'I have read the ',
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.black54),
                                    children: [
                                  TextSpan(
                                      text: 'Privacy Policy',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18))
                                ])),
                            Switch(
                              value: isSwitched,
                              onChanged: (value) {
                                setState(() {
                                  isSwitched = value;
                                });
                              },
                              activeTrackColor: kAppColor,
                              activeColor: kAppColor,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),

                        signIn_login_Btn_widget(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              if (isSwitched != false) {
                                final snackBar = SnackBar(
                                  content: const Text('Uploaded'),
                                  backgroundColor: kAppColor,
                                  action: SnackBarAction(
                                    label: 'dismiss',
                                    textColor: Colors.white,
                                    onPressed: () {},
                                  ),
                                );
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HomePage()));

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              } else {
                                final snackBar = SnackBar(
                                  content: const Text(
                                      'Please Agree to term and condition'),
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
                          containerText: 'GET STARTED',
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    },
                    child: RichText(
                        text: const TextSpan(
                            text: 'ALREADY HAVE AN ACCOUNT?',
                            style:
                                TextStyle(fontSize: 15, color: Colors.black54),
                            children: [
                          TextSpan(
                              text: ' LOGIN ',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18))
                        ])),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
