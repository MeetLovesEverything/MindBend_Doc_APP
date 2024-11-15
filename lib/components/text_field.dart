import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputTextField extends StatefulWidget {
  final String? Function(String?)? validation;
  final Function()? onEditComplete;
  final TextEditingController? textEditingController;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatters;
  final bool enable;
  final String title;
  final TextAlign textAlign;
  final TextInputAction textInputAction;
  final Function(String val)? onChange;
  final double? width;

  const InputTextField({
    Key? key,
    this.width,
    this.validation,
    this.textEditingController,
    this.onChange,
    this.textInputType,
    required this.title,
    this.inputFormatters,
    this.enable = true,
    this.textAlign = TextAlign.left,
    this.onEditComplete,
    this.textInputAction = TextInputAction.done,
  }) : super(key: key);

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: TextFormField(
        controller: widget.textEditingController,
        validator: widget.validation ?? (val) => null,
        keyboardType: widget.textInputType,
        inputFormatters: widget.inputFormatters,
        textInputAction: widget.textInputType == TextInputType.multiline
            ? TextInputAction.newline
            : widget.textInputAction, // Use newline only for multiline
        enabled: widget.enable,
        onChanged: (val) {
          if (widget.onChange != null) {
            widget.onChange!(val);
          }
        },
        onEditingComplete: widget.onEditComplete,
        style: const TextStyle(
          fontSize: 12.0,
          height: 1.5,
          color: Colors.black,
        ),
        textAlign: widget.textAlign,
        minLines: widget.textInputType == TextInputType.multiline ? 2 : 1,
        maxLines: widget.textInputType == TextInputType.multiline ? null : 1,
        decoration: InputDecoration(
          hintText: widget.title,
          labelText: widget.title,
          labelStyle: const TextStyle(
            color: Colors.black54,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          hintStyle: const TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 11,
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(width: 1, color: Colors.black26),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(width: 1, color: Colors.black26),
          ),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(width: 1, color: Colors.black26),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(width: 1, color: Colors.black26),
          ),
        ),
      ),
    );
  }
}
