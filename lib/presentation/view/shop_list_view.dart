import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_practice/presentation/view/category_button_list.dart';
import 'package:riverpod_practice/presentation/view/search_keyword_container.dart';
import 'package:riverpod_practice/presentation/view/shopping_list.dart';

class ShopListView extends ConsumerWidget {
  const ShopListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop List'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: _buildShoppingList(),
    );
  }

  Widget _buildShoppingList() {
    return Container(
      alignment: Alignment.center,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 50, child: CategoryButtonList()),
          SizedBox(height: 20),
          SearchKeywordContainer(),
          Expanded(child: ShoppingList()),
        ],
      ),
    );
  }
}
