import 'package:flutter/material.dart';

import '../constants/dimensions.dart';
import '../models/dropdown_model.dart';

// Function to create the overlay entry for the dropdown items
OverlayEntry createOverlayEntry({
  required BuildContext context,
  required LayerLink layerLink,
  required List<DropdownModel> filteredItems,
  required VoidCallback closeDropdown,
}) {
  return OverlayEntry(
    builder: (context) => Positioned(
      width: MediaQuery.of(context).size.width * 0.8,
      child: CompositedTransformFollower(
        link: layerLink,
        showWhenUnlinked: false,
        offset: const Offset(0, Dimensions.inputBoxHeight + 5.0),
        child: Material(
          color: Colors.white, // Background color of the dropdown
          elevation: 4.0, // Optional: add shadow
          child: ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            children: filteredItems.map((item) {
              return ListTile(
                title: Text(item.title),
                onTap: () {
                  closeDropdown();
                  // Add other selection logic here if needed
                },
              );
            }).toList(),
          ),
        ),
      ),
    ),
  );
}
