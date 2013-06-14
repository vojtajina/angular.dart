import 'dart:html' as dom;
import 'package:angular/debug.dart';
import 'package:angular/angular.dart';


class NgClickAttrDirective {
  String expression;
  dom.Node node;


  NgClickAttrDirective(dom.Node this.node, DirectiveValue directiveValue) {
    expression = directiveValue.value;
  }

  attach(Scope scope) {
    node.onClick.listen((event) => scope.$apply(expression));
  }
}