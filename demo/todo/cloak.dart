import 'package:angular/debug.dart';
import 'package:angular/angular.dart';
import 'dart:mirrors';
import 'package:di/di.dart';
import 'dart:html' as dom;


class NgCloakAttrDirective {
  dom.Element node;

  NgCloakAttrDirective(dom.Node this.node) {}

  attach(Scope scope) {
    node.style.display = 'block';
  }
}
