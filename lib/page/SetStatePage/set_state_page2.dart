import 'package:flutter/material.dart';
import 'package:flutter_compare_architecture/repository/countRepository.dart';

//APIライクに変更したカウントアプリ
//StatefulWidgetの状態管理が煩雑になりがち
class SetStatePage2 extends StatelessWidget {
  const SetStatePage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:const Text('setState2 demo')
      ),
      body: _Page(),
    );
  }
}

class _Page extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PageState();
}

class _PageState extends State<_Page> {
  int _counter = 0;
  bool _isLoading = false;

  //この関数が_counter以外にも関心を持つことになり見通しが悪い
  //カウントアップの際インジケータの表示/非表示切り替えとカウントアップの処理でWidgetABCが2回リビルドされてしまう
  void _incrementCounter() async{
    var countRepository = CountRepository();
    setState(() {
      _isLoading = true;
    });
    countRepository.fetch().then(
      (increaseCount){
        setState(() {
          _counter += increaseCount;
        });
      }
    ).whenComplete((){
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            //子のウィジェットに値の変更を伝えるため引数として渡す
            _WidgetA(_counter),
            _WidgetB(),
            //子のウィジェットにカウントさせる関数を渡す
            _WidgetC(_incrementCounter),
          ],),
        ),
        _LoadingWidget(_isLoading)
    ]
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

class _LoadingWidget extends StatelessWidget {
  final bool isLoading;


  const _LoadingWidget(this.isLoading);

  @override
  Widget build(BuildContext context) {
    print("_LoadingWidget build is called ");
    return isLoading ?
    const DecoratedBox(
        decoration: BoxDecoration(
          color: Color(0x029f6300)
        ),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    ) : const SizedBox.shrink();
  }
}
