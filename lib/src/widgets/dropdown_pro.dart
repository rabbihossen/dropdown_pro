import 'package:flutter/material.dart';

import '../constants/dimensions.dart';
import '../models/dropdown_model.dart';
import '../themes/custom_color.dart';
import 'dropdown_list.dart';

class DropdownPro<T> extends StatefulWidget {
  final List<T> itemsList;
  final ValueChanged<T?>? onChanged;
  final bool enableSearch;

  const DropdownPro({
    required this.itemsList,
    this.onChanged,
    this.enableSearch = false, // Enable or disable the search feature
    super.key,
  });

  @override
  _DropdownProState<T> createState() => _DropdownProState<T>();
}

class _DropdownProState<T> extends State<DropdownPro<T>> {
  bool isDropdownOpened = false;
  TextEditingController searchController = TextEditingController();
  List<T> filteredItems = [];
  dynamic selectedItem;

  @override
  void initState() {
    super.initState();
    filteredItems = widget.itemsList;
  }

  // Method to get the title of an item based on its type
  String _getItemTitle(T item) {
    if (item is DropdownModel) {
      return item.title; // If the item is a DropdownModel, return its title.
    } else if (item is String) {
      return item; // If the item is a String, return it directly.
    } else {
      throw ArgumentError(
        'Unsupported item type: ${item.runtimeType}',
      ); // Handle unsupported types
    }
  }

  void _toggleDropdown() {
    setState(() {
      isDropdownOpened = !isDropdownOpened;
      if (!isDropdownOpened) {
        filteredItems = widget.itemsList;
        searchController.clear();
      }
    });
  }

  void _onSearchChanged(String value) {
    setState(() {
      filteredItems = widget.itemsList
          .where((item) =>
              _getItemTitle(item).toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleDropdown,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: Dimensions.inputBoxHeight,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius),
              border: Border.all(color: CustomColor.primary),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    selectedItem != null
                        ? _getItemTitle(selectedItem)
                        : 'Select Item',
                    style: TextStyle(
                      color: selectedItem != null ? Colors.black : Colors.grey,
                    ),
                  ),
                ),
                const Icon(Icons.arrow_drop_down, color: CustomColor.primary),
              ],
            ),
          ),
          if (isDropdownOpened)
            Column(
              children: [
                if (widget.enableSearch)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextField(
                      controller: searchController,
                      onChanged: _onSearchChanged,
                      decoration: const InputDecoration(
                        hintText: 'Search...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                DropdownList<T>(
                  filteredItems: filteredItems,
                  dropdownHeight: 200,
                  onChanged: (item) {
                    widget.onChanged?.call(item);
                    setState(() {
                      selectedItem = item;
                      isDropdownOpened = false;
                    });
                  },
                  selectedItem: selectedItem,
                ),
              ],
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
