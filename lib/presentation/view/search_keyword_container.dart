import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_practice/presentation/view_model/shop_list_view_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SearchKeywordContainer extends HookConsumerWidget {
  const SearchKeywordContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = useTextEditingController();
    final focusNode = useFocusNode();

    useEffect(() {
      textController.addListener(() {
        if (textController.text.isEmpty) {
          ref.read(shopListViewModelProvider.notifier).changeSearchWord('');
          focusNode.unfocus();
        }
      });
      return null;
    }, []);

    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: textController,
        focusNode: focusNode,
        onEditingComplete: () => ref.read(shopListViewModelProvider.notifier).changeSearchWord(textController.text),
        decoration: const InputDecoration(
          hintText: 'Search',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
