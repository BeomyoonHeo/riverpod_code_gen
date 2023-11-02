import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_practice/presentation/view_model/shop_list_view_model.dart';

class ShoppingList extends HookConsumerWidget {
  const ShoppingList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModelLoadingState = ref.watch(shopListViewModelProvider.select((value) => value.loading));
    final shoppingList = ref.watch(shoppingListProvider);

    return switch (viewModelLoadingState) {
      AsyncData(:final value) => ListView.builder(
          itemBuilder: (_, index) => ListTile(
              leading: Image.network(shoppingList[index].image),
              title: Text(shoppingList[index].title),
              trailing: Text(shoppingList[index].category.category.toString()),
              subtitle: Text('${shoppingList[index].price}\$')),
          itemCount: shoppingList.length),
      AsyncError(:final error, :final stackTrace) => const Center(child: Text('error !')),
      AsyncLoading() => Container(),
      AsyncValue() => Container(),
    };
  }
}
