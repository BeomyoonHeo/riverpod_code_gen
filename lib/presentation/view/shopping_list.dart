import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_practice/presentation/view_model/shop_list_view_model.dart';

class ShoppingList extends ConsumerWidget {
  const ShoppingList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shoppingList = ref.watch(shopListViewModel);
    final searchedShoppingList = ref.watch(searchShoppingListProvider);

    return shoppingList.map(
      data: (data) => ListView.builder(
          itemBuilder: (context, index) => ListTile(
              leading: Image.network(searchedShoppingList[index].image),
              title: Text(searchedShoppingList[index].title),
              trailing: Text(searchedShoppingList[index].category.category.toString()),
              subtitle: Text('${searchedShoppingList[index].price}\$')),
          itemCount: searchedShoppingList.length),
      error: (error) => const Center(child: Text('error !')),
      loading: (loading) => _buildLoadingContainer(),
    );
  }

  Widget _buildLoadingContainer() {
    return Container(
      alignment: Alignment.center,
      child: const CircularProgressIndicator(),
    );
  }
}
