import 'package:auto_route/auto_route.dart';

class AppNavigator {
  static void pushByName(context, className) => AutoRouter.of(context).pushNamed( className);

  static void pushByClassName(context, className) => AutoRouter.of(context).push(className);

  static void replaceClassName(context, className) => AutoRouter.of(context).replace(className);

  static void removeClassName(context) => AutoRouter.of(context).removeLast();

  static void popPush(context) => AutoRouter.of(context).pop();

  static void pushUntil(context, routeName) => AutoRouter.of(context).popUntilRouteWithName(routeName);
}
