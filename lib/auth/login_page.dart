import 'package:curheart/auth/register_page.dart';
import 'package:curheart/helper/supabase_auth_helper.dart';
import 'package:curheart/provider/user_provider.dart';
import 'package:curheart/start/auth_state_page.dart';
import 'package:curheart/utils/const_variables.dart';
import 'package:curheart/utils/custom_methods.dart';
import 'package:curheart/utils/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late UserProvider userProvider;

  bool showPassword = false;

  @override
  void initState() {
    super.initState();

    userProvider = Provider.of<UserProvider>(context, listen: false);

    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  void signIn({required String email, required String password}) async {
    showDialog(
      context: context,
      builder: (context) => FullScreenLoading(
        text: "Mencoba Login...",
      ),
    );

    await Future.delayed(Duration(milliseconds: 500));

    Object res = await SupabaseAuthHelper.signIn(
      userProvider,
      email: email,
      password: password,
    );

    if (res == "success") {
      Navigator.pushReplacement(context, CustomRoute(AuthStatePage()));
    } else {
      Navigator.pop(context);

      showSnackBar(
          context, MySnackBar(content: "Email atau password salah..."));
    }
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
                  text: "Login",
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 30),

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
                          autofillHints: [AutofillHints.email],
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(" ")
                          ],
                          validator: emailValidator,
                        ),
                        SizedBox(height: 10),

                        // @ Password
                        MyTextField(
                          controller: passwordController,
                          label: "password",
                          obscureText: !showPassword,
                          autofillHints: [AutofillHints.password],
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
                                signIn(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                );
                              }
                            },
                            text: "Login",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),

                // @ Belum punya akun
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Belum punya akun?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, CustomRoute(RegisterPage()));
                      },
                      child: Text("Daftar"),
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
