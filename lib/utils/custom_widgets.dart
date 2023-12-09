// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:curheart/core/curheart_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:curheart/models/curheart_model.dart';
import 'package:curheart/models/user_model.dart';
import 'package:curheart/utils/custom_theme.dart';

// @ Full Screen Loading
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

// @ Primary Button
class MyButton extends StatelessWidget {
  final String text;
  final bool isPrimary;
  final void Function() onPressed;
  EdgeInsetsGeometry? padding;
  BorderRadius? borderRadius = BorderRadius.circular(50);

  MyButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.padding,
    this.borderRadius,
    this.isPrimary = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: isPrimary
          ? BoxDecoration(
              color: lightPrimary,
              borderRadius: borderRadius,
              boxShadow: [
                BoxShadow(
                  color: darkPrimary,
                  offset: Offset(5, 6),
                ),
              ],
            )
          : null,
      child: InkWell(
        borderRadius: borderRadius,
        onTap: onPressed,
        highlightColor: darkPrimary,
        child: Padding(
          padding: padding ?? EdgeInsets.all(15),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: isPrimary ? Colors.black : primaryColor,
                fontSize: 20,
                fontWeight: isPrimary ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// @ Custom Text
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

// @ Custom TextFormField
class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  String? Function(String? value)? validator;
  List<TextInputFormatter>? inputFormatters;
  Iterable<String>? autofillHints;
  EdgeInsetsGeometry? contentPadding = EdgeInsets.symmetric(
    horizontal: 5,
    vertical: 10,
  );
  bool obscureText;
  Widget? suffixIcon;
  TextInputType? keyboardType;
  Color? labelColor;
  Color? valueColor;
  int? maxLines = 1;
  InputBorder? focusedBorder;
  InputBorder? enabledBorder;
  void Function(String value)? onChanged;
  String? counterText;

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
    this.labelColor,
    this.valueColor,
    this.maxLines,
    this.focusedBorder,
    this.enabledBorder,
    this.onChanged,
    this.counterText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      controller: controller,
      keyboardType: keyboardType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator ??
          (value) {
            if (value!.isEmpty) {
              return "Masih kosong...";
            }
            return null;
          },
      autofillHints: autofillHints,
      inputFormatters: inputFormatters,
      obscureText: obscureText,
      style: TextStyle(
        color: valueColor,
      ),
      decoration: InputDecoration(
        counterText: counterText,
        counterStyle: TextStyle(color: directColor(context).withOpacity(.5)),
        enabledBorder: enabledBorder,
        focusedBorder: focusedBorder,
        labelText: label,
        contentPadding: contentPadding,
        suffixIcon: suffixIcon,
        labelStyle: TextStyle(
          color: labelColor,
        ),
      ),
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      onChanged: onChanged,
    );
  }
}

// @ Cureheart Card
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
    return Container(
      margin: EdgeInsets.only(bottom: 40),
      child: Ink(
        decoration: BoxDecoration(
          color: Color(curheartModel.color),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: reversedPrimary(context),
              offset: Offset(7, 7),
            ),
          ],
        ),
        height: 250,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          highlightColor: Colors.black.withOpacity(.5),
          onTap: () {
            Navigator.push(
                context,
                CustomRoute(
                    CureheartDetailScreen(curheartModel: curheartModel)));
          },
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
                    Text(
                      userModel.name,
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// @ Alert Dialog
class MyDialog extends StatelessWidget {
  final void Function() onYes;

  const MyDialog({super.key, required this.onYes});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text("Batal ?")),
      actions: [
        SizedBox(height: 20),
        MyButton(
          text: "Ya",
          onPressed: onYes,
        ),
        SizedBox(height: 10),
        MyButton(
          text: "Tidak",
          isPrimary: false,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

// @ Custom Container
class MyContainer extends StatelessWidget {
  final Widget child;

  EdgeInsetsGeometry? padding;
  EdgeInsetsGeometry? margin;
  Color? bgColor;

  MyContainer({
    Key? key,
    required this.child,
    this.padding,
    this.margin,
    this.bgColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: bgColor ?? reversedColor(context),
        boxShadow: [
          BoxShadow(
            color: reversedPrimary(context),
            offset: Offset(5, 6),
          ),
        ],
      ),
      child: child,
    );
  }
}

// @ Choice Chip
class MyChip extends StatelessWidget {
  final Widget label;
  final bool selected;
  final void Function(bool value) onSelected;

  const MyChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: ChoiceChip(
        showCheckmark: false,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        label: label,
        selected: selected,
        onSelected: onSelected,
      ),
    );
  }
}

// ------------------------------------
// ! Non StatelesWidget

// @ MyAppBar
AppBar MyAppBar(
  BuildContext context, {
  Widget? title,
  Widget? leading,
  Color? backgroundColor,
  Color? foregroundColor,
  void Function()? onPressed,
}) {
  return AppBar(
    automaticallyImplyLeading: false,
    title: title,
    leading: leading,
    backgroundColor: backgroundColor,
    foregroundColor: foregroundColor,
    actions: [
      IconButton(
        onPressed: onPressed ??
            () {
              Navigator.pop(context);
            },
        icon: FaIcon(
          FontAwesomeIcons.xmark,
          size: 17,
        ),
        constraints: BoxConstraints(minWidth: 35, minHeight: 35),
        style: ElevatedButton.styleFrom(
          foregroundColor: directColor(context),
          backgroundColor: reversedColor(context),
        ),
      ),
      SizedBox(width: 10),
    ],
  );
}

// @ Custom SnackBar
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

// @ Custom Route
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
