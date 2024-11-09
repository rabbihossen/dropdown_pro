import '../models/dropdown_model.dart';

double calculateDropdownHeight(
    double itemHeight, int maxVisibleItems, List items) {
  return items.length <= maxVisibleItems
      ? items.length * itemHeight
      : maxVisibleItems * itemHeight;
}

String getItemTitle<T>(T item) {
  if (item is DropdownModel) {
    return item.title;
  }
  return item.toString();
}
