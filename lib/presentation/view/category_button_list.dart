import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_practice/domain/model/shopping_item_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:riverpod_practice/presentation/view_model/shop_list_view_model.dart';

class CategoryButtonList extends StatefulHookConsumerWidget {
  const CategoryButtonList({super.key});

  @override
  ConsumerState<CategoryButtonList> createState() => _CategoryButtonListState();
}

class _CategoryButtonListState extends ConsumerState<CategoryButtonList> {
  late final scrollController = useScrollController();

  void _onPressedButton(int index) {
    ref.read(shopListViewModelProvider.notifier).changeCategory(EnumCategory.values[index]);
    scrollController.animateTo(index * 200, duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    final currentCategory = ref.watch(shopListViewModelProvider.select((value) => value.enumCategory));
    return ListView.separated(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) => ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: currentCategory == EnumCategory.values[index] ? Colors.blue : Colors.grey,
            ),
            onPressed: () => _onPressedButton(index),
            child: Text(EnumCategory.values[index].toString())),
        separatorBuilder: (_, index) => const SizedBox(width: 20),
        itemCount: EnumCategory.values.length);
  }
}
