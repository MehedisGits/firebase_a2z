import 'package:flutter/material.dart';

import '../colors.dart';

Widget buildInputField({
  required TextEditingController controller,
  required String label,
  required IconData prefixIcon,
  required String? Function(String?) validator,
  bool isPassword = false,
  bool isVisible = false,
  VoidCallback? onVisibilityToggle,
}) {
  return TextFormField(
    controller: controller,
    obscureText: isPassword ? !isVisible : false,
    style: const TextStyle(color: Colors.black),
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.white.withOpacity(0.3),
      labelText: label,
      labelStyle: const TextStyle(color: TasklyColors.textColorLight),
      prefixIcon: Icon(prefixIcon, color: TasklyColors.primaryAccent),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      suffixIcon:
          isPassword
              ? IconButton(
                icon: Icon(
                  isVisible ? Icons.visibility : Icons.visibility_off,
                  color: TasklyColors.primaryAccent,
                ),
                onPressed: onVisibilityToggle,
              )
              : null,
    ),
    validator: validator,
  );
}
