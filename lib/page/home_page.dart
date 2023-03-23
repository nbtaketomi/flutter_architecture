import 'package:flutter/material.dart';
import 'package:flutter_compare_architecture/page/SetStatePage/set_state_page.dart';
import 'package:flutter_compare_architecture/page/SetStatePage/set_state_page2.dart';
import 'inherited_widget_page.dart';
import 'riverpod_page.dart';
import 'provider_page.dart';

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
          ContentsPage(name: "setState", route: SetStatePage()),
          ContentsPage(name: "setState2", route: SetStatePage2()),
          ContentsPage(name: "InheritedWidget", route: InheritedWidgetPage()),
          ContentsPage(name: "provider", route: ProviderPage()),
          ContentsPage(name: "riverPod", route: RiverpodPage()),
        ],
      )
    );
  }
}

class ContentsPage extends StatelessWidget{
  const ContentsPage({super.key, required this.name, required this.route});
  final String name;
  final Widget route;
  @override
  Widget build(BuildContext context) {
   return ListTile(
     title: Text('case $name'),
     onTap: (){
       Navigator.push(context, MaterialPageRoute(builder: (context) => route, fullscreenDialog:true));
     },
   );
  }

}
