import 'package:angular/debug.dart';
import 'package:angular/angular.dart';
import 'dart:mirrors';
import 'package:di/di.dart';
import 'dart:html' as dom;


class NgDisabledAttrDirective {
  String expression;
  dom.Element node;

  NgDisabledAttrDirective(dom.Node this.node, DirectiveValue value) {
    expression = value.value;
  }

  attach(Scope scope) {
    scope.$watch(expression, (value, _, __) {
      node.disabled = toBool(value);
    });
  }
}
