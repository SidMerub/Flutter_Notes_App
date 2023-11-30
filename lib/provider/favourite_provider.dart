import 'package:flutter/foundation.dart';






class FavouriteItemProvider with ChangeNotifier {
  List<String> _selectedItem = [];
  String _searchQuery = '';

  List<String> get selectedItem => _selectedItem;
  String get searchQuery => _searchQuery;

  void addItems(String value) {
    _selectedItem.add(value);
    notifyListeners();
  }

  void removeItems(String value) {
    _selectedItem.remove(value);
    notifyListeners();
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }
}

