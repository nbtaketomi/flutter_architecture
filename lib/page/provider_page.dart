import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// 状態クラス
class CounterObj {
  CounterObj() : count = 0;
  int count;
}

// 状態管理クラス
class ProviderCounterNotifier extends ChangeNotifier {
  ProviderCounterNotifier() : obj = CounterObj();
  CounterObj obj;

  void incrementCounter() {
    obj.count++;
    //リスナーに変更を伝える
    notifyListeners();
  }
}

// 依存関係を注入
class ProviderPage extends StatelessWidget {
  const ProviderPage({super.key});

  @override
  Widget build(BuildContext context) {
    //createで指定した状態をchildで指定したwidgetに伝える
    return ChangeNotifierProvider(
      create: (_) => ProviderCounterNotifier(),
      child: const _ProviderPage(),
    );
  }
}
//　ページの実体
class _ProviderPage extends StatelessWidget {
  const _ProviderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider Demo'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _WidgetA(),
          _WidgetB(),
          _WidgetC(),
        ],
      ),
    );
  }
}

class _WidgetA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("_widgetA build is called ");

    return Center(
      //リスナー。状態管理クラスの変更を購読している
        child: Consumer<ProviderCounterNotifier>(
          builder: (context, state, _) => Text(
            "${state.obj.count}",
            style: Theme.of(context).textTheme.displayMedium,
          ),
        )
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
    final ProviderCounterNotifier unListenState =
        context.read<ProviderCounterNotifier>();
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () {
              unListenState.incrementCounter();
            },
            child: const Icon(Icons.add),
          ),
          const Text("このwidgetはrebuildされないのが望ましい")
        ],
      ),
    );
  }
}
