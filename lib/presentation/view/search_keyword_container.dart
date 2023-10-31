import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_practice/presentation/view_model/shop_list_view_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SearchKeywordContainer extends StatefulHookConsumerWidget {
  const SearchKeywordContainer({super.key});

  @override
  ConsumerState<SearchKeywordContainer> createState() => _SearchKeywordContainerState();
}

class _SearchKeywordContainerState extends ConsumerState<SearchKeywordContainer> {
  late final TextEditingController textController = useTextEditingController();
  late final FocusNode focusNode = useFocusNode();

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      textController.addListener(() {
        if (textController.text.isEmpty) {
          _resetSearchWord();
          focusNode.unfocus();
        }
      });
      return null;
    }, []);
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: textController,
        focusNode: focusNode,
        onEditingComplete: _onEditingComplete,
        decoration: const InputDecoration(
          hintText: 'Search',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  void _onEditingComplete() {
    ref.read(shopListViewModel.notifier).changeSearchWord(textController.text);
  }

  void _resetSearchWord() {
    ref.read(shopListViewModel.notifier).changeSearchWord('');
  }
}
