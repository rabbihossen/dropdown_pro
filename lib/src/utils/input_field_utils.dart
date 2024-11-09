import 'package:flutter/material.dart';

Widget buildSearchField(
    TextEditingController controller, Function(String) onChanged) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: 'Search...',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
  );
}
