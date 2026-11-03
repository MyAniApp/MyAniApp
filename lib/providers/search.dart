import 'package:flutter_hooks/flutter_hooks.dart' hide useSearchController;
import 'package:material_ui/material_ui.dart';

@Deprecated("Remove when flutter_hoks moves to material_ui")
SearchController useSearchController({List<Object?>? keys}) {
  return use(_SearchControllerHook(keys: keys));
}

class _SearchControllerHook extends Hook<SearchController> {
  const _SearchControllerHook({List<Object?>? keys}) : super(keys: keys);

  @override
  HookState<SearchController, Hook<SearchController>> createState() =>
      _SearchControllerHookState();
}

class _SearchControllerHookState
    extends HookState<SearchController, _SearchControllerHook> {
  final controller = SearchController();

  @override
  String get debugLabel => 'useSearchController';

  @override
  SearchController build(BuildContext context) => controller;

  @override
  void dispose() => controller.dispose();
}
