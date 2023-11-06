import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

CustomOverlayEntry useOverlay({Widget? child}) {
  return use(_OverlayHook(child: child));
}

class _OverlayHook extends Hook<CustomOverlayEntry> {
  const _OverlayHook({this.child});
  final Widget? child;

  @override
  HookState<CustomOverlayEntry, Hook<CustomOverlayEntry>> createState() => _OverlayHookState();
}

class _OverlayHookState extends HookState<CustomOverlayEntry, _OverlayHook> {
  CustomOverlayEntry? _overlayEntry;

  @override
  void initHook() {
    super.initHook();
  }

  @override
  void dispose() {
    super.dispose();
    if (_overlayEntry!.mounted) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }

  @override
  CustomOverlayEntry build(BuildContext context) {
    _overlayEntry ??= CustomOverlayEntry(builder: (context) => hook.child ?? _buildLoadingContainer());
    return _overlayEntry!;
  }

  Widget _buildLoadingContainer() {
    return Container(
      color: Colors.black.withOpacity(0.5),
      alignment: Alignment.center,
      child: const CircularProgressIndicator(),
    );
  }
}

class CustomOverlayEntry extends OverlayEntry {
  CustomOverlayEntry({required super.builder});

  @override
  void markNeedsBuild({Function? callback}) {
    if (SchedulerBinding.instance.schedulerPhase == SchedulerPhase.persistentCallbacks) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        callback?.call();
        super.markNeedsBuild();
      });
    } else {
      callback?.call();
      super.markNeedsBuild();
    }
  }
}
