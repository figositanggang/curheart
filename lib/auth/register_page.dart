import 'package:curheart/helper/supabase_auth_helper.dart';
import 'package:curheart/utils/const_variables.dart';
import 'package:curheart/utils/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController nameController;

  bool showPassword = false;

  @override
  void initState() {
    super.initState();

    emailController = TextEditingController();
    nameController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController = TextEditingController();
    passwordController.dispose();

    super.dispose();
  }

  void signUp({required String email, required String password}) async {
    Object res = await SupabaseAuthHelper.signUp(
      email: email,
      name: nameController.text.trim(),
      photoUrl: "",
      password: password,
    );

    print(res);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints:
              BoxConstraints(minHeight: MediaQuery.sizeOf(context).height),
          child: Center(
            child: Column(
              children: [
                MyText(
                  text: "Daftar",
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),

                // @ FORM
                Form(
                  key: formKey,
                  child: Container(
                    width: MediaQuery.sizeOf(context).width - 100,
                    child: Column(
                      children: [
                        // @ Email
                        MyTextField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          label: "email",
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(" ")
                          ],
                          validator: emailValidator,
                        ),
                        SizedBox(height: 10),

                        // @ Name
                        MyTextField(
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          label: "nama",
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp(r'\d')),
                          ],
                        ),
                        SizedBox(height: 10),

                        // @ Password
                        MyTextField(
                          controller: passwordController,
                          label: "password",
                          obscureText: !showPassword,
                          validator: passwordValidator,
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(" ")
                          ],
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                showPassword = !showPassword;
                              });
                            },
                            icon: FaIcon(
                              showPassword
                                  ? FontAwesomeIcons.solidEye
                                  : FontAwesomeIcons.solidEyeSlash,
                              size: 18,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),

                        // @ Login Button
                        SizedBox(
                          width: double.infinity,
                          child: MyButton(
                            onPressed: () {
                              if (!formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    MySnackBar(content: "Ada yang salah"));
                              } else {
                                signUp(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                );
                              }
                            },
                            text: "Daftar",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),

                // @ Sudah punya akun
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Sudah punya akun?"),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Login"),
                    ),
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
