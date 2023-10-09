import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Utils/dialog_utils.dart';
import 'package:to_do/Utils/firebase_utils.dart';
import 'package:to_do/home/homeScreen.dart';
import 'package:to_do/register_screen/registerScreen.dart';
import 'package:to_do/reusable%20components/textFormField.dart';
import 'package:to_do/theme.dart';

import '../providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset(
              'assets/images/main_background.png',
              width: double.infinity,
              fit: BoxFit.fill,
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .35,
                  ),
                  TextEditingField(
                    controller: emailController,
                    label: AppLocalizations.of(context)!.email,
                    validator: (validator) {},
                    keyboardType: TextInputType.emailAddress,
                    isPassword: false,
                  ),
                  TextEditingField(
                    controller: passwordController,
                    label: AppLocalizations.of(context)!.password,
                    validator: (validator) {},
                    keyboardType: TextInputType.visiblePassword,
                    isPassword: true,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: signInWithEmailAndPassword,
                        child: Text(
                          AppLocalizations.of(context)!.log_in_btn,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MyTheme.blueColor,
                          padding: EdgeInsets.symmetric(
                            vertical: 20,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(AppLocalizations.of(context)!.have_account),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterScreen()));
                        },
                        child: Text(
                          AppLocalizations.of(context)!.sign_up,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  signInWithEmailAndPassword() async {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (formKey.currentState?.validate() == true) {
      DialogUtils.showLoading(context);
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        var user = await FirebaseUtils.readUserFromFirebase(
            credential.user?.uid ?? '');
        if (user == null) {
          return;
        }
        authProvider.updateUser(user);

        print('login successfully');
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(context, 'Login successfully.', () {
          Navigator.pop(context);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(context, 'No user found for that email.', () {
            Navigator.pop(context);
          });
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
              context, 'Wrong password provided for that user.', () {
            Navigator.pop(context);
          });
          print('Wrong password provided for that user.');
        }
      } catch (e) {
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(context, e.toString(), () {
          Navigator.pop(context);
        });
        print(e);
      }
    }
  }
}
