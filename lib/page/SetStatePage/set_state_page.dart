import 'package:flutter/material.dart';

//シンプルなカウントアプリ
//これくらいだったらserState()でも十分
//でもsetState()によりリビルドの必要がないwidgetBまでリビルドされてしまう
class SetStatePage extends StatelessWidget {
  const SetStatePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:const Text('setState demo')
      ),
      body: _Page(),
    );
  }
}

class _Page extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _pageState();
}

class _pageState extends State<_Page> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            //子のウィジェットに値の変更を伝えるため引数として渡す
            _WidgetA(_counter),
            _WidgetB(),
            //子のウィジェットにカウントさせる関数を渡す
            _WidgetC(_incrementCounter),
          ],
        ),
      );
  }
}


class _WidgetA extends StatelessWidget {
  final int counter;
  const _WidgetA(this.counter);

  @override
  Widget build(BuildContext context) {
    print("_widgetA build is called ");
    return Center(
      child: Text(
        "$counter",
        style: Theme.of(context).textTheme.displayMedium,
      ),
    );
  }
}

class _WidgetB extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    print("_widgetB build is called ");
    return const Center(
      child: Text(
        "このwidgetはrebuildされないのが望ましい",
        style: TextStyle(fontSize: 15),
      ),
    );
  }
}

class _WidgetC extends StatelessWidget {
  final void Function() incrementCounter;

  const _WidgetC(this.incrementCounter);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    print("_widgetC build is called ");
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () {
              incrementCounter();
            },
            child: const Icon(Icons.add),
          ),
          const Text("このwidgetはrebuildされないのが望ましい")
        ],
      ),
    );
  }
}
