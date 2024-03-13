import 'package:flix/core/extension/color_extension.dart';
import 'package:flutter/material.dart';

class FormTextField extends StatefulWidget {
  final String? hintText, errorText;
  final TextEditingController _controller;
  final TextInputType keyboardType;
  final bool isPassword;
  final TextInputAction textInputAction;
  final TextCapitalization textCapitalization;
  final bool isEnabled;
  final Key? widgetKey;

  const FormTextField(this._controller,
      {super.key,
      this.hintText,
      this.keyboardType = TextInputType.none,
      this.isPassword = false,
      this.textInputAction = TextInputAction.next,
      this.textCapitalization = TextCapitalization.none,
      this.errorText,
        this.widgetKey,
      this.isEnabled = true});

  @override
  State<FormTextField> createState() => _FormTextFieldState();
}

class _FormTextFieldState extends State<FormTextField> {
  bool showPassword = false;
  String? errorText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: widget.widgetKey,
      obscureText: widget.isPassword && !showPassword,
      autocorrect: !widget.isPassword,
      enableSuggestions: !widget.isPassword,
      keyboardType: widget.keyboardType,
      textCapitalization: widget.textCapitalization,
      controller: widget._controller,
      textInputAction: widget.textInputAction,
      enabled: widget.isEnabled,
      decoration: InputDecoration(
        fillColor:
            widget.isEnabled ? Colors.transparent : Theme.of(context).disabledColor,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
        ),
        hintText: widget.hintText,
        errorText: widget.errorText,
        suffixIcon: widget.isPassword
            ? Focus(
                descendantsAreFocusable: false,
                canRequestFocus: false,
                child: IconButton(
                  icon: showPassword
                      ? const Icon(Icons.visibility_outlined)
                      : const Icon(Icons.visibility_off_outlined),
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                ),
              )
            : null,
      ),
    );
  }
}
