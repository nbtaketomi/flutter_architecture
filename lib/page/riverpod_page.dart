import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RiverpodPage extends StatelessWidget {
  const RiverpodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

//グローバルに使用可能
final counterProvider = StateProvider((ref) => 0);

class _WidgetA extends ConsumerWidget {
  //consumerWidgetにすることで参照(ref)を利用可能に
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("_widgetA build is called ");
    final count = ref.watch(counterProvider);
    return Center(
        child: Text(
      '$count',
      style: Theme.of(context).textTheme.displayMedium,
    ));
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

class _WidgetC extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("_widgetC build is called ");
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () {
              ref.read(counterProvider.notifier).state++;
            },
            child: const Icon(Icons.add),
          ),
          const Text("このwidgetはrebuildされないのが望ましい")
        ],
      ),
    );
  }
}
