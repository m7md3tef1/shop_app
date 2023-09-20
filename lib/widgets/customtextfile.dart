import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {

  var label;
  var icondata;
  var suffix;
  bool? secure;
  Function(String)? onSubmit;
  var type;
  void Function(String?)? onsaved;
  String? Function(String?)? validator;
  TextEditingController? controller;
  CustomTextFormField({super.key,
    this.onSubmit,
    this.type,
    this.controller,
    this.label,
    this.icondata,
    this.secure,
    this.onsaved,
    this.validator,
    this.suffix,
  });
  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext
  context) {
    return TextFormField(
      controller: widget.controller,
      onSaved: widget.onsaved,
      validator: widget.validator,
      onFieldSubmitted: widget.onSubmit,
      obscureText: widget.secure!,
      keyboardType: widget.type,
      decoration: InputDecoration(
          label: Text(widget.label!),

          prefixIcon: Icon(
            widget.icondata,
            color: Colors.black26,
          ),
          border:  const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            borderSide: BorderSide(color: Colors.white, width: 1),
          ),
        //  border: Border.all(color: Colors.grey, width: .7),
          suffixIcon: widget.suffix),
    );
  }
}
