import 'package:driver_review_capstone/const/constants.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool? isObscure;
  final bool? autoFocus;
  final bool? isLast;
  final bool? validate;
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.isObscure = false,
    this.autoFocus = false,
    this.isLast = false,
    this.validate = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  Color fillColor = Colors.white;
  Color focusColor = kFocusColor;
  Color errorFocusColor = Colors.red.withOpacity(0.1);
  late FocusNode _myFocusNode;
  final ValueNotifier<bool> _myFocusNotifier = ValueNotifier<bool>(false);

  bool showPassword = false;

  @override
  void initState() {
    super.initState();
    _myFocusNode = FocusNode();
    _myFocusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _myFocusNode.removeListener(_onFocusChange);
    _myFocusNode.dispose();
    _myFocusNotifier.dispose();

    super.dispose();
  }

  void _onFocusChange() {
    _myFocusNotifier.value = _myFocusNode.hasFocus;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _myFocusNotifier,
      builder: (context, isFocus, child) {
        return TextField(
          controller: widget.controller,
          autofocus: widget.autoFocus!,
          obscureText: widget.isObscure! ? !showPassword : false,
          enableSuggestions: !widget.isObscure!,
          autocorrect: false,
          focusNode: _myFocusNode,
          keyboardType: widget.keyboardType,
          textInputAction:
              widget.isLast! ? TextInputAction.done : TextInputAction.next,
          textCapitalization: widget.keyboardType == TextInputType.name
              ? TextCapitalization.words
              : TextCapitalization.none,
          decoration: InputDecoration(
            filled: true,
            fillColor: isFocus
                ? widget.validate!
                    ? errorFocusColor
                    : focusColor
                : fillColor,
            hintText: widget.hintText,
            hintStyle: const TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w500,
              color: kGrey,
            ),
            errorText: widget.validate! ? "Field Can't Be Empty" : null,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: kGrey, width: 2.0),
              borderRadius: BorderRadius.circular(12.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: kPrimaryColor, width: 2.0),
              borderRadius: BorderRadius.circular(12.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 2.0),
              borderRadius: BorderRadius.circular(12.0),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 2.0),
              borderRadius: BorderRadius.circular(12.0),
            ),
            suffixIcon: widget.isObscure!
                ? InkWell(
                    onTap: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    child: showPassword
                        ? const Icon(Icons.visibility_off_outlined)
                        : const Icon(Icons.visibility_outlined),
                  )
                : const SizedBox.shrink(),
          ),
          style: const TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w600,
            color: kDark,
          ),
        );
      },
    );
  }
}
