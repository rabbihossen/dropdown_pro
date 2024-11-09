import 'package:flutter/material.dart';

import '../models/dropdown_model.dart';

class DropdownList<T> extends StatelessWidget {
  final List<T> filteredItems;
  final double dropdownHeight;
  final ValueChanged<T>? onChanged; // Callback to handle item selection
  final T? selectedItem; // Pass selectedItem as a parameter

  const DropdownList({
    required this.filteredItems,
    required this.dropdownHeight,
    this.onChanged,
    required this.selectedItem,
    super.key,
  });

  // Method to get the title of an item based on its type
  String _getItemTitle(T item) {
    if (item is DropdownModel) {
      return item.title; // If the item is a DropdownModel, return its title.
    } else if (item is String) {
      return item; // If the item is a String, return it directly.
    } else {
      throw ArgumentError(
          'Unsupported item type: ${item.runtimeType}'); // Handle unsupported types
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: dropdownHeight,
      child: Material(
        color: Colors.white,
        elevation: 4.0,
        child: ListView.builder(
          itemCount: filteredItems.length,
          itemBuilder: (context, index) {
            final item = filteredItems[index];
            return ListTile(
              title: Text(_getItemTitle(
                  item)), // Use _getItemTitle to display the item's title
              tileColor: item == selectedItem
                  ? Colors.blue[100]
                  : null, // Highlight selected item
              onTap: () {
                // Notify the parent widget when an item is selected
                onChanged?.call(item);
              },
            );
          },
        ),
      ),
    );
  }
}
