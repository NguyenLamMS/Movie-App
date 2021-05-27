import 'package:flutter/material.dart';
import 'package:movieapp/common/constants/size_constants.dart';
import 'package:movieapp/common/extensions/size_extensions.dart';
import 'package:movieapp/presentation/themes/theme_text.dart';
class LableFielWidget extends StatelessWidget {
  final String lable;
  final String hintext;
  final bool isPasswordField;
  final TextEditingController controller;
  final UnderlineInputBorder _enableBorder = const UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey));
  final UnderlineInputBorder _focusedBorder = const UnderlineInputBorder(
    borderSide: BorderSide(
      color: Colors.white,
    ),
  );

  const LableFielWidget({Key key, @required this.lable, @required this.hintext, @required this.isPasswordField = false, @required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Sizes.dimen_8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text(lable.toUpperCase()), TextField(
          obscureText: isPasswordField,
          obscuringCharacter: '*',
          controller: controller,
          style: Theme.of(context).textTheme.headline6,
          decoration: InputDecoration(
            hintText: hintext,
            hintStyle: Theme.of(context).textTheme.greySubtitle1,
            focusedBorder: _focusedBorder,
            enabledBorder: _enableBorder
          ),
        )],
      ),
    );
  }
}
