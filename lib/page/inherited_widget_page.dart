import 'package:flutter/material.dart';

//InheritedWidgetを使ったサンプル
class InheritedWidgetPage extends StatelessWidget {
  const InheritedWidgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _Page(
      child: Scaffold(
        appBar:  AppBar(
          title: const Text('InheritedWidget Demo'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            //子のウィジェットに値の変更を伝えるため引数として渡す
            _WidgetA(),
            _WidgetB(),
            //子のウィジェットにカウントさせる関数を渡す
            _WidgetC(),
          ],
        ),
      ),
    );;
  }
}

class _Page extends StatefulWidget {
  const _Page({required this.child});

  final Widget child;
  @override
  State<StatefulWidget> createState() => _PageState();

  static _PageState of(BuildContext context, {bool rebuild =true}) {
    //先祖を辿って_MyInheritedWidgetを探し、そのdata（＝state）を返す
    if (rebuild){
      //dependOnInheritedWidgetOfExactType()はリビルドされる
      return (context.dependOnInheritedWidgetOfExactType<_Inherited>())!.data;
    }
    //getElementForInheritedWidgetOfExactType()はリビルドされない
    return (context.getElementForInheritedWidgetOfExactType<_Inherited>()!.widget as _Inherited).data;
  }
}

class _PageState extends State<_Page> {
  int counter = 0;

  void _incrementCounter() {
    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _Inherited(
        data: this,
        child: widget.child
    );
  }
}

class _Inherited extends InheritedWidget {
  const _Inherited({
    required Widget child,
    required this.data,
  }) : super(child: child);


  final _PageState data;

  @override
  bool updateShouldNotify(_Inherited oldWidget){
    //getElementForInheritedWidgetOfExactType()にリビルドすることを通知するかどうか
    return true;
  }
}


class _WidgetA extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    print("_widgetA build is called ");
    //1.staticなofメソッドによる状態取得
    final _PageState state = _Page.of(context);
    return Center(
      child: Text(
        "${state.counter}",
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
  @override
  Widget build(BuildContext context) {
    print("_widgetC build is called ");
    //1.staticなofメソッドによる状態取得。リビルドはしない設定
    final _PageState state = _Page.of(context, rebuild: false);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () {
              state._incrementCounter();
            },
            child: const Icon(Icons.add),
          ),
          const Text("このwidgetはrebuildされないのが望ましい")
        ],
      ),
    );
  }
}

