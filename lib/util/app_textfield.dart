import 'package:flutter/material.dart';

class AppFormTextField extends StatelessWidget {
  final FormFieldValidator<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final FormFieldValidator<String>? onSubmit;
  final String? hintText;
  final TextAlign? textAlign;
  final TextInputType? keyboardType;
  final Widget? suffix;
  final Widget? prefix;
  final bool? obscureText;
  final Key? formKey;
  final String? initialValue;
  final bool? enabled;
  final TextStyle? style;
  final TextEditingController? controller;
  final String? hintLabel;
  final BuildContext? ctx;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final bool? autofocus;

  const AppFormTextField({
    this.onSaved,
    this.validator,
    this.hintText = "",
    this.textAlign = TextAlign.start,
    this.keyboardType = TextInputType.text,
    this.suffix,
    this.prefix,
    this.obscureText = false,
    this.formKey,
    this.initialValue,
    this.enabled = true,
    this.style,
    this.controller,
    this.hintLabel = "",
    this.onSubmit,
    this.focusNode,
    this.textInputAction,
    this.autofocus = false,
    @required this.ctx,
  });

  Widget textField() {
    return TextFormField(
      autofocus: autofocus!,
      key: formKey,
      style: style,
      validator: validator,
      onSaved: onSaved,
      onFieldSubmitted: onSubmit,
      keyboardType: keyboardType,
      textAlign: textAlign!,
      obscureText: obscureText!,
      initialValue: initialValue,
      enabled: enabled,
      controller: controller,
      keyboardAppearance: Theme.of(ctx!).brightness,
      cursorColor: Theme.of(ctx!).textSelectionTheme.cursorColor,
      textInputAction: textInputAction,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Colors.grey)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(width: 1, color: Colors.black87),
          ),
          hintText: hintText,
          suffixIcon: suffix,
          prefixIcon: prefix,
          isDense: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    return hintLabel!.isEmpty
        ? textField()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                hintLabel!,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              SizedBox(height: 5),
              textField()
            ],
          );
  }
}
