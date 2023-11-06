import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_practice/domain/model/shopping_item_model.dart';
import 'package:riverpod_practice/presentation/view/shoping_list/component/category_button_list.dart';
import 'package:riverpod_practice/core/component/custom_loading.dart';
import 'package:riverpod_practice/presentation/view/shoping_list/component/search_keyword_container.dart';
import 'package:riverpod_practice/presentation/view/shoping_list/shop_list_view_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ShoppingList extends HookConsumerWidget {
  const ShoppingList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shoppingList = ref.watch(wordFilterShopListProvider);
    final viewModelState = ref.watch(shopListViewModelProvider.select((value) => value.loading));
    final viewModel = ref.watch(shopListViewModelProvider.notifier);

    useEffect(() {
      ref.read(shopListViewModelProvider.notifier).getShoppingList();
      return null;
    }, []);

    useEffect(() {
      if (viewModelState is AsyncLoading) {
        ref.read(loadingStateProvider.notifier).show();
      } else {
        ref.read(loadingStateProvider.notifier).dismiss();
      }
      return null;
    }, [viewModelState]);

    return Container(
      child: Column(children: [
        const SizedBox(height: 50, child: CategoryButtonList()),
        const SizedBox(height: 20),
        const SearchKeywordContainer(),
        Expanded(child: _buildListView(viewModelState, shoppingList, viewModel)),
      ]),
    );
  }

  Widget _buildListView(final AsyncValue<void> viewModelLoadingState, final List<ShoppingItemModel> shoppingList,
      final ShopListViewModel viewModel) {
    return switch (viewModelLoadingState) {
      AsyncData(:final value) => ListView.builder(
          itemBuilder: (_, index) => ListTile(
              leading: Image.network(shoppingList[index].image),
              title: Text(shoppingList[index].title),
              trailing: Checkbox(
                  value: shoppingList[index].isAddedCart, onChanged: (_) => viewModel.addCart(shoppingList[index])),
              subtitle: Text('${shoppingList[index].price}\$')),
          itemCount: shoppingList.length),
      AsyncError(:final error, :final stackTrace) => const Center(child: Text('error !')),
      AsyncLoading() => Container(),
      AsyncValue() => Container(),
    };
  }
}
