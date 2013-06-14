import 'package:angular/debug.dart';
import 'package:angular/angular.dart';
import 'dart:mirrors';
import 'package:di/di.dart';
import 'dart:html' as dom;


class NgModelAttrDirective {
  ParsedFn expression;
  dom.InputElement node;

  var lastValue = null;

  NgModelAttrDirective(dom.Node this.node, Parser parser, DirectiveValue value) {
    expression = parser(value.value);
  }

  _attachDefault(Scope scope) {
    // model -> view
    scope.$watch(expression.getter, (value, _, __) {
      if (value != lastValue) {
        lastValue = value;
        node.value = value;
      }
    });

    // view -> model
    node.onInput.listen((event) {
      lastValue = node.value;

      scope.$apply(() {
        expression.assignFn(scope, lastValue, {});
      });
    });
  }

  _attachCheckbox(Scope scope) {
    // model -> view
    scope.$watch(expression.getter, (value, _, __) {
      if (value != lastValue) {
        lastValue = value;
        node.checked = value;
      }
    });

    // view -> model
    node.onChange.listen((event) {
      lastValue = node.checked;

      scope.$apply(() {
        expression.assignFn(scope, lastValue, {});
      });
    });
  }

  attach(Scope scope) {
    if (node.type == 'checkbox') {
      _attachCheckbox(scope);
    } else {
      _attachDefault(scope);
    }
  }
}
