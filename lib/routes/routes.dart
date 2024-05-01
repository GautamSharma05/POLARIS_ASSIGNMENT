import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:polaris/module/form/form.dart';
import 'package:polaris/module/home/home.dart';

part 'routes.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  Route? onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) => const Scaffold(
        body: Center(
          child: Text('Page not found'),
        ),
      ),
    );
  }

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: FormRoute.page, path: '/', initial: true),
        AutoRoute(page: HomeRoute.page,path: '/home')
      ];
}
