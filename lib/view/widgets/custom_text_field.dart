import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomTextField extends StatefulWidget {
  final String hinttext;
  final String text;
  final TextEditingController controller;

  final Function onsaved;
  final Function onChanged;

  final Function validator;
  final Icon icon;

  final TextInputType textType;

  bool passwordVisible;
  final bool isPassword;
  CustomTextField({
    Key key,
    this.hinttext,
    this.onsaved,
    this.validator,
    this.text,
    this.textType = TextInputType.text,
    this.passwordVisible = true,
    this.isPassword = false,
    this.controller,
    this.icon,
    this.onChanged,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    var textFormField = TextFormField(
      controller: widget.controller,
      obscureText: widget.passwordVisible,
      keyboardType: widget.textType,
      onSaved: widget.onsaved,
      onChanged: widget.onChanged,
      validator: widget.validator,
      decoration: InputDecoration(
        hintText: widget.hinttext,
        hintStyle: const TextStyle(color: Colors.grey),
        fillColor: Colors.white,
        prefixIcon: widget.icon,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(widget.passwordVisible
                    ? Icons.visibility_off
                    : Icons.visibility),
                onPressed: () {
                  setState(() {
                    widget.passwordVisible = !widget.passwordVisible;
                  });
                },
              )
            : null,
      ),
    );
    return Column(
      children: [
        CustomText(
          text: widget.text,
          fontsize: 15,
          color: Colors.grey.shade900,
        ),
        textFormField,
      ],
    );
  }
}
