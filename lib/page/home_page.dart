import 'package:flutter/material.dart';
import 'package:flutter_compare_architecture/page/SetStatePage/set_state_page.dart';
import 'package:flutter_compare_architecture/page/SetStatePage/set_state_page2.dart';
import 'inherited_widget_page.dart';
import 'riverpod_page.dart';
import 'provider_page.dart';
import 'package:go_router/go_router.dart';

class MyHomePage extends StatelessWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView(
        children: const <Widget>[
          ContentsPage(name: "setState", path: "/setState", route: SetStatePage()),
          ContentsPage(name: "setState2", path: "/setState2", route: SetStatePage2()),
          ContentsPage(name: "InheritedWidget", path: "/inheritedWidget", route: InheritedWidgetPage()),
          ContentsPage(name: "provider", path: "/provider", route: ProviderPage()),
          ContentsPage(name: "riverPod", path: "/riverpod", route: RiverpodPage()),
        ],
      )
    );
  }
}

class ContentsPage extends StatelessWidget{
  const ContentsPage({super.key, required this.name, required this.path, required this.route});
  final String name;
  final String path;
  final Widget route;
  @override
  Widget build(BuildContext context) {
   return ListTile(
     title: Text('case $name'),
     onTap: (){
       context.go(path);
     },
   );
  }
}
