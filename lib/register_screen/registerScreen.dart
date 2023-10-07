import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Utils/dialog_utils.dart';
import 'package:to_do/Utils/firebase_utils.dart';
import 'package:to_do/home/homeScreen.dart';
import 'package:to_do/login_screen/loginScreen.dart';
import 'package:to_do/models/userModel.dart';
import 'package:to_do/providers/auth_provider.dart';
import 'package:to_do/reusable%20components/textFormField.dart';
import 'package:to_do/theme.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var nameController = TextEditingController();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var confirmPasswordController = TextEditingController();

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
                    controller: nameController,
                    label: AppLocalizations.of(context)!.name,
                    validator: (validator) {
                      if (nameController.text.isEmpty) {
                        return 'Enter your name';
                      }
                    },
                    isPassword: false,
                  ),
                  TextEditingField(
                    controller: emailController,
                    label: AppLocalizations.of(context)!.email,
                    validator: (validator) {
                      if (emailController.text.isEmpty) {
                        return 'Enter your email';
                      } else if (emailController.text.contains(
                              r"/^WS{1,2}:\/\/\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}:56789/i") ||
                          emailController.text.trim() == '') {
                        return 'Email must be like email@example.com';
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    isPassword: false,
                  ),
                  TextEditingField(
                    controller: passwordController,
                    label: AppLocalizations.of(context)!.password,
                    validator: (text) {
                      if (passwordController.text.isEmpty) {
                        return ' Enter a password';
                      } else if (passwordController.text.length > 0 &&
                          passwordController.text.length < 6) {
                        return 'password is too weak';
                      }
                    },
                    keyboardType: TextInputType.visiblePassword,
                    isPassword: true,
                  ),
                  TextEditingField(
                    controller: confirmPasswordController,
                    label: AppLocalizations.of(context)!.confirm_password,
                    validator: (text) {
                      if (confirmPasswordController.text !=
                          passwordController.text) {
                        return 'password \doesn\'t match';
                      }
                    },
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.sign_up_btn,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
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
                        onPressed: signUpWithEmailAndPassword,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(AppLocalizations.of(context)!.already_have_account),
                      SizedBox(
                        width: 10,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                        child: Text(
                          AppLocalizations.of(context)!.log_in,
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

  signUpWithEmailAndPassword() async {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    DialogUtils.showLoading(context);
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      MyUser user = MyUser(
          name: nameController.text,
          email: emailController.text,
          id: credential.user!.uid);
      await FirebaseUtils.addUserToFireStore(user);
      authProvider.updateUser(user);
      print('registration successfully');
      DialogUtils.hideLoading(context);
      DialogUtils.showMessage(context, 'registration successfully', () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      });
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(context, 'The password provided is too weak.',
            () {
          Navigator.pop(context);
        });
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(
            context, 'The account already exists for that email.', () {
          Navigator.pop(context);
        });
        print('The account already exists for that email.');
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
