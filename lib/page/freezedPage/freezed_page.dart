import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'freezed_page.freezed.dart';

// ドメインモデル
@freezed
class Counter with _$Counter {
  const factory Counter({required int value}) = _Counter;
}

// 状態管理用のStateNotifier
class CounterNotifier extends StateNotifier<Counter> {
  CounterNotifier() : super(const Counter(value: 0));

  void increment() {
    state = state.copyWith(value: state.value + 1);
  }

  void decrement() {
    state = state.copyWith(value: state.value - 1);
  }
}

// Provider
final counterProvider = StateNotifierProvider<CounterNotifier, Counter>((ref) {
  return CounterNotifier();
});

// UI
class FreezedPage extends ConsumerWidget {
  const FreezedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Freezed Page Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Counter Value: ${counter.value}',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    ref.read(counterProvider.notifier).increment();
                  },
                  child: const Text('Increment'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    ref.read(counterProvider.notifier).decrement();
                  },
                  child: const Text('Decrement'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
