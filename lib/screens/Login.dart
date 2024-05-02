import 'package:chatapp/components/custom_button.dart';
import 'package:chatapp/components/custom_text_feild.dart';
import 'package:chatapp/constant.dart';
import 'package:chatapp/screens/home_page.dart';
import 'package:chatapp/screens/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});
  static const String id = 'Login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formkey = GlobalKey();

  String? email;
  String? password;
  bool _st = false;
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
                  size: 250,
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
                      'Sign in',
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
                    if (!b) return 'invalid email';
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
                    if (value!.length < 8) return 'wrong Pssword';
                  },
                  onChanged: (data) {
                    password = data;
                  },
                  hint: 'Password',
                ),
                CustomButton(
                  name: 'Sign in',
                  func: () async {
                    if (formkey.currentState!.validate()) {
                      try {
                        _st = true;
                        setState(() {});
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: email!, password: password!);
                        snackMessage(context, 'Successed');
                        Navigator.pushNamed(context, HomePage.id,
                            arguments: email);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          snackMessage(context, 'User not fount');
                        } else if (e.code == 'wrong-password') {
                          snackMessage(context, 'Wrong password');
                        }
                      }
                      _st = false;
                      setState(() {});
                    } else {
                      snackMessage(context, 'Try again please');
                    }
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('don\'t have an account? '),
                    GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, SignUpPage.id);
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void snackMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}
