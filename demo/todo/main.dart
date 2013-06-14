import 'package:angular/debug.dart';
import 'package:angular/angular.dart';
import 'package:di/di.dart';
import 'dart:html' as dom;
import 'dart:math' as math;

import 'controller.dart';
import 'click.dart';
import 'model.dart';
import 'class.dart';
import 'disabled.dart';
import 'cloak.dart';
import 'hide.dart';

import 'todo.dart';


// helper for bootstrapping angular
bootstrapAngular(modules, [rootElementSelector = '[ng-app]']) {
  List<dom.Node> topElt = dom.query(rootElementSelector).nodes.toList();
  assert(topElt.length > 0);

  var coreModule = new AngularModule();

  // TODO(vojta): wtf is this ? move to core ?
  coreModule.value(Expando, new Expando());

  // register angular core stuff
  angularModule(coreModule);

  var allModules = ([coreModule])..addAll(modules);

  Injector injector = new Injector(allModules);

  injector.invoke((Compiler $compile, Scope $rootScope) {
    $compile.call(topElt).call(topElt).attach($rootScope);
    $rootScope.$digest();
  });
}



main() {
  var module = new AngularModule();

  // TODO(vojta): move these into core
  module.directive(NgControllerAttrDirective);
  module.directive(NgModelAttrDirective);
  module.directive(NgClickAttrDirective);
  module.directive(NgClassAttrDirective);
  module.directive(NgDisabledAttrDirective);
  module.directive(NgCloakAttrDirective);
  module.directive(NgHideAttrDirective);

  module.directive(NgTextMustacheDirective);
  module.directive(NgBindAttrDirective);
  module.directive(NgRepeatAttrDirective);

  bootstrapAngular([module]);
}
