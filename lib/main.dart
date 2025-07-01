import 'package:flutter/material.dart';
import 'package:flutter_compare_architecture/page/home_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_compare_architecture/page/SetStatePage/set_state_page.dart';
import 'package:flutter_compare_architecture/page/SetStatePage/set_state_page2.dart';
import 'package:flutter_compare_architecture/page/inherited_widget_page.dart';
import 'package:flutter_compare_architecture/page/provider_page.dart';
import 'package:flutter_compare_architecture/page/riverpod_page.dart';

void main() {
  runApp(ProviderScope(
    child: MyApp(),
  ));
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MyHomePage(title: 'flutter architectures'),
      routes: [
        GoRoute(
          path: 'setState',
          builder: (context, state) => const SetStatePage(),
        ),
        GoRoute(
          path: 'setState2',
          builder: (context, state) => const SetStatePage2(),
        ),
        GoRoute(
          path: 'inheritedWidget',
          builder: (context, state) => const InheritedWidgetPage(),
        ),
        GoRoute(
          path: 'provider',
          builder: (context, state) => const ProviderPage(),
        ),
        GoRoute(
          path: 'riverpod',
          builder: (context, state) => const RiverpodPage(),
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: _router,
    );
  }
}

