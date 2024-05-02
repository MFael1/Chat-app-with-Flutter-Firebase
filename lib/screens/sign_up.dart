import 'package:chatapp/components/custom_button.dart';
import 'package:chatapp/components/custom_text_feild.dart';
import 'package:chatapp/constant.dart';
import 'package:chatapp/screens/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// ignore: must_be_immutable
class SignUpPage extends StatefulWidget {
  SignUpPage({super.key});
  static const String id = 'SignUp';

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String? email;

  String? password;

  bool _st = false;

  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimiaryColor,
        title: Text(
          'data',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: kPrimiaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: ModalProgressHUD(
          inAsyncCall: _st,
          child: Form(
            key: formkey,
            child: ListView(
              children: [
                Icon(
                  Icons.message_rounded,
                  color: Colors.white,
                  size: 150,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'TURBOCHAT',
                      style: TextStyle(fontSize: 30),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 25),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextFeild(
                  validat: (value) {
                    bool b = false;
                    for (int i = 0; i < value!.length; ++i) {
                      if (value[i] == '@') b = true;
                    }
                    if (!b) {
                      return 'invalid email';
                    }
                  },
                  onChanged: (data) {
                    email = data;
                  },
                  hint: 'Email',
                ),
                SizedBox(
                  height: 20,
                  width: double.infinity,
                ),
                CustomTextFeild(
                  obscureText: true,
                  validat: (value) {
                    if (value!.length < 8) return 'too shourt';
                  },
                  onChanged: (data) {
                    password = data;
                  },
                  hint: 'Password',
                ),
                SizedBox(height: 20),
                CustomTextFeild(
                  obscureText: true,
                  hint: 'Confirm password',
                ),
                CustomButton(
                  name: 'Rigister',
                  func: () async {
                    if (formkey.currentState!.validate()) {
                      try {
                        _st = true;
                        setState(() {});
                        UserCredential user = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: email!, password: password!);
                        snackMessage(context, 'Successed');
                        Navigator.pushNamed(context, HomePage.id,
                            arguments: email);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          snackMessage(
                              context, 'weak password, try again please');
                        } else if (e.code == 'email-already-in-use') {
                          snackMessage(context,
                              'Email already in use, please try again');
                        }
                      } catch (e) {
                        snackMessage(
                            context, 'There is an error, please try again');
                      }
                    } else {
                      snackMessage(context, 'There is an error');
                    }
                    _st = false;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void snackMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
