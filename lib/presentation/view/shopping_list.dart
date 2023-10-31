import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_practice/presentation/view_model/shop_list_view_model.dart';

class ShoppingList extends ConsumerWidget {
  const ShoppingList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shoppingList = ref.watch(searchShoppingListProvider);
    final viewModel = ref.watch(shopListViewModel.select((value) => value.loading));

    return viewModel.map(
      data: (data) => ListView.builder(
          itemBuilder: (_, index) => ListTile(
              leading: Image.network(shoppingList[index].image),
              title: Text(shoppingList[index].title),
              trailing: Text(shoppingList[index].category.category.toString()),
              subtitle: Text('${shoppingList[index].price}\$')),
          itemCount: shoppingList.length),
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
