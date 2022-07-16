import 'dart:core';

class CollectionFruitMenu {
  final String _title;
  bool _isSelected = false;

  CollectionFruitMenu(this._title);

  String get title => _title;

  bool get isSelected => _isSelected;

  set isSelected(bool value) {
    _isSelected = value;
  }

  CollectionFruitMenu setDefaultSelected() {
    this._isSelected = true;
    return this;
  }
}
