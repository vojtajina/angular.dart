import 'package:angular/debug.dart';
import 'package:angular/angular.dart';
import 'dart:mirrors';
import 'package:di/di.dart';
import 'dart:html' as dom;


class XNgControllerAttrDirective {
  static var $transclude = "element";

  Symbol ctrlSymbol;
  Injector injector;
  BlockList blockList;

  NgControllerAttrDirective(DirectiveValue value, Injector injector, BlockList blockList) {
    this.ctrlSymbol = new Symbol(value.value + 'Controller');
    this.injector = injector;
    this.blockList = blockList;
  }

  attach(Scope scope) {
    var childScope = scope.$new();
    var module = new Module();
    module.value(Scope, childScope);

    // attach the child scope
    blockList.newBlock()..attach(childScope)..insertAfter(blockList);

    // instantiate the controller
    injector.createChild([module]).getBySymbol(ctrlSymbol);
  }
}

// TODO(vojta): create a new scope
// TODO(vojta): Ctrl as alias syntax ?
class NgControllerAttrDirective {

  Symbol ctrlSymbol;
  Injector injector;

  NgControllerAttrDirective(Injector this.injector, DirectiveValue value) {
    this.ctrlSymbol = new Symbol(value.value + 'Controller');
  }

  attach(Scope scope) {
    var module = new Module();
    module.value(Scope, scope);

    injector.createChild([module]).getBySymbol(ctrlSymbol);
  }
}

/**
directive static properties:
- transclude
- generate
- template

*/


/**
ISSUES:

- ng-repeat does not handle undefined/non array things
- directive can only ask for BlockList if transcluded; better error
- deep watching ?
- cannot bind (parse + set) to regular objects (only maps), eg. item.text (where item is class Item with text property)
*/



/**
* Misko questions:
* - Block = wrapper around a DOM element (instance), BlockType = wrapper around element (template), BlockList = list of blocks
*/


/**
* DART:
* - API docs should contain a trivial example how to use it; currently it's a huge piece of shit, useless
*/