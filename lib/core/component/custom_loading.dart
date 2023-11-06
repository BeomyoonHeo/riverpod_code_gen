import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_practice/core/component/loading_overlay.dart';

part 'custom_loading.g.dart';

@Riverpod(keepAlive: true)
class LoadingState extends _$LoadingState {
  CustomOverlayEntry? _overlayEntry;

  @override
  Widget build() {
    return const SizedBox.shrink();
  }

  static TransitionBuilder init({
    TransitionBuilder? builder,
  }) {
    return (BuildContext context, Widget? child) {
      if (builder != null) {
        return builder(context, CustomLoading(child: child!));
      } else {
        return CustomLoading(child: child!);
      }
    };
  }

  Future<void> show() async => _markNeedsBuild(() => state = defaultLoadingContainer());

  Future<void> dismiss() async => _markNeedsBuild(() => state = const SizedBox.shrink());

  void _markNeedsBuild(Function callback) => _overlayEntry?.markNeedsBuild(callback: callback);

  set overlayEntry(CustomOverlayEntry value) => _overlayEntry = value;

  Widget defaultLoadingContainer() {
    return Container(
      color: Colors.black.withOpacity(0.5),
      alignment: Alignment.center,
      child: const CircularProgressIndicator(),
    );
  }
}

class CustomLoading extends HookConsumerWidget {
  const CustomLoading({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CustomOverlayEntry overlayEntry = CustomOverlayEntry(
      builder: (context) => ref.watch(loadingStateProvider),
    );
    ref.watch(loadingStateProvider.notifier).overlayEntry = overlayEntry;
    return Material(
      child: Overlay(
        initialEntries: [
          OverlayEntry(builder: (context) => child),
          overlayEntry,
        ],
      ),
    );
  }
}
