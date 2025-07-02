import 'package:flutter/material.dart';

enum InputType { email, password, phone, name }

class CustomFormField extends StatefulWidget {
  final InputType inputType;
  final TextEditingController controller;
  final String label;

  const CustomFormField({
    required this.inputType,
    required this.controller,
    required this.label,
    super.key,
  });

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField>
    with SingleTickerProviderStateMixin {
  bool obscure = false;
  late AnimationController _animController;
  late Animation<double> _opacity;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.inputType == InputType.password) {
      obscure = true;
    }

    _focusNode.addListener(() {
      if (_focusNode.hasFocus && widget.inputType == InputType.phone) {
        if (!widget.controller.text.startsWith('+998')) {
          widget.controller.text = '+998';
          widget.controller.selection = TextSelection.fromPosition(
            TextPosition(offset: widget.controller.text.length),
          );
        }
      }
    });

    _animController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _opacity = Tween<double>(begin: 0, end: 1).animate(_animController);
    _animController.forward();
  }

  String? _validator(String? value) {
    if (value == null || value.isEmpty) return 'Maydon bo\'sh bo\'lmasin';
    switch (widget.inputType) {
      case InputType.email:
        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
          return 'Email xato';
        }
        break;
      case InputType.phone:
        if (!RegExp(r'^\+998\d{9}$').hasMatch(value)) {
          return 'Iltimos to‘liq raqam kiriting';
        }
        break;
      case InputType.password:
        if (value.length < 6) return 'Kamida 6 ta belgidan iborat bo\'lsin';
        break;
      case InputType.name:
        if (value.length < 2) return 'Ism juda qisqa';
        break;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: TextFormField(
        focusNode: _focusNode,
        controller: widget.controller,
        obscureText: obscure,
        keyboardType: _getKeyboardType(),
        validator: _validator,
        cursorColor: Color(0xFF35C56E),
        decoration: InputDecoration(
          labelText: widget.label,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          alignLabelWithHint: true,
          labelStyle: TextStyle(color: Color(0xFF35C56E)),
          floatingLabelStyle: TextStyle(color: Color(0xFF35C56E)),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF35C56E), width: 1),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF35C56E), width: 1),
          ),
          suffixIcon: widget.inputType == InputType.password
              ? IconButton(
                  icon: Icon(
                    obscure ? Icons.visibility_off : Icons.visibility,
                    color: Color(0xFF35C56E),
                  ),
                  onPressed: () {
                    setState(() {
                      obscure = !obscure;
                    });
                  },
                )
              : null,
        ),
      ),
    );
  }

  TextInputType _getKeyboardType() {
    switch (widget.inputType) {
      case InputType.email:
        return TextInputType.emailAddress;
      case InputType.phone:
        return TextInputType.phone;
      case InputType.password:
        return TextInputType.text;
      case InputType.name:
        return TextInputType.name;
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _animController.dispose();
    super.dispose();
  }
}
