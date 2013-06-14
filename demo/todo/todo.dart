import 'package:angular/angular.dart';


class Item {
  String text;
  bool done;

  Item([String text = '', bool done = false]) {
    this.text = text;
    this.done = done;
  }

  clone() {
    return new Item(text, done);
  }

  // workaround; parsed expression cannot set properties
  void operator []=(key, value) {
    switch (key) {
      case 'text':
        text = value;
        break;
      case 'done':
        done = value;
        break;
    }
  }
}

class TodoController {
  Scope scope;
  List<Item> items;
  Item newItem;

  TodoController(Scope this.scope) {
    newItem = new Item();
    items = [new Item('Write Angular in Dart', true), new Item('Write Dart in Angular'), new Item('Do something useful')];

    // export to scope
    // how about automatic exporting all public properties/methods ?
    scope['items'] = items;
    scope['newItem'] = newItem;

    scope['add'] = this.add;
    scope['markAllDone'] = this.markAllDone;
    scope['archiveDone'] = this.archiveDone;
    scope['classFor'] = this.classFor;
    scope['remaining'] = this.remaining;
  }

  // workaround, because we can't watch deeply
  _refreshItems() {
    scope['items'] = items.toList();
  }

  add() {
    if (newItem.text == '') return;

    items.add(newItem.clone());
    newItem.text = '';

    _refreshItems();
  }

  markAllDone() {
    items.forEach((item) {
      item.done = true;
    });
  }

  archiveDone() {
    items.removeWhere((item) {
      return item.done;
    });

    _refreshItems();
  }

  classFor(Item item) {
    return item.done ? 'done' : '';
  }

  remaining() {
    var remaining = 0;

    items.forEach((item) {
      if (!item.done) remaining++;
    });

    return remaining;
  }
}
