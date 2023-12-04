// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:curheart/models/curheart_model.dart';
import 'package:curheart/models/user_model.dart';
import 'package:flutter/material.dart';

import 'package:curheart/utils/custom_theme.dart';
import 'package:flutter/services.dart';

// ! Full Screen Loading
class FullScreenLoading extends StatelessWidget {
  String? text;

  FullScreenLoading({
    super.key,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: AnimatedTextKit(
          animatedTexts: [
            TyperAnimatedText(
              text ?? "LOADING",
              speed: const Duration(milliseconds: 100),
              textStyle: TextStyle(color: primaryColor),
            ),
          ],
        ),
      ),
    );
  }
}

// ! Primary Button
class PrimaryButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  EdgeInsetsGeometry? padding;

  PrimaryButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        color: lightPrimary,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: darkPrimary,
            offset: Offset(5, 6),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: onPressed,
        highlightColor: darkPrimary,
        child: Padding(
          padding: padding ?? EdgeInsets.all(15),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ! Custom Text
class MyText extends StatelessWidget {
  final String text;
  double? fontSize;
  Color? color;
  FontWeight? fontWeight;

  MyText({
    Key? key,
    required this.text,
    this.fontSize,
    this.color,
    this.fontWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
      ),
    );
  }
}

// ! Custom TextFormField
class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  String? Function(String?)? validator;
  List<TextInputFormatter>? inputFormatters;
  Iterable<String>? autofillHints;
  EdgeInsetsGeometry? contentPadding = EdgeInsets.symmetric(
    horizontal: 5,
    vertical: 10,
  );
  bool obscureText;
  Widget? suffixIcon;
  TextInputType? keyboardType;

  MyTextField({
    super.key,
    required this.controller,
    required this.label,
    this.autofillHints,
    this.contentPadding,
    this.inputFormatters,
    this.validator,
    this.suffixIcon,
    this.keyboardType,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      autofillHints: autofillHints,
      inputFormatters: inputFormatters,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        contentPadding: contentPadding,
        suffixIcon: suffixIcon,
      ),
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
    );
  }
}

// ! Cureheart Card
class CureheartCard extends StatelessWidget {
  final UserModel userModel;
  final CurheartModel curheartModel;

  const CureheartCard({
    super.key,
    required this.userModel,
    required this.curheartModel,
  });

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        color: Color(curheartModel.color),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).brightness == Brightness.light
                ? darkPrimary
                : lightPrimary,
            offset: Offset(7, 7),
          ),
        ],
      ),
      height: 250,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        highlightColor: Colors.black.withOpacity(.5),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: double.infinity,
                child: Text(
                  curheartModel.title,
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(userModel.photoUrl),
                  ),
                  SizedBox(width: 10),
                  Text(userModel.name),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ! Custom SnackBar
SnackBar MySnackBar({required String content}) {
  return SnackBar(
    backgroundColor: dangerRed,
    content: Text(
      content,
      style: TextStyle(color: lightPrimary),
    ),
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.all(20),
  );
}

// ! Custom Route
Route CustomRoute(Widget page) {
  return PageRouteBuilder(
    transitionDuration: Duration(milliseconds: 100),
    reverseTransitionDuration: Duration(milliseconds: 100),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
    pageBuilder: (context, animation, secondaryAnimation) {
      return page;
    },
  );
}
