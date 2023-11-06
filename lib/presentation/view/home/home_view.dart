import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_practice/presentation/view/cart_list/cart_list.dart';
import 'package:riverpod_practice/presentation/view/shoping_list/component/category_button_list.dart';
import 'package:riverpod_practice/core/component/custom_loading.dart';
import 'package:riverpod_practice/presentation/view/shoping_list/component/search_keyword_container.dart';
import 'package:riverpod_practice/presentation/view/shoping_list/shopping_list.dart';
import 'package:riverpod_practice/presentation/view/shoping_list/shop_list_view_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HomeView extends StatefulHookConsumerWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _ShopListViewState();
}

class _ShopListViewState extends ConsumerState<HomeView> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_currentIndex == 0 ? 'shop list' : 'cart'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          ShoppingList(),
          CartList(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.home, color: _currentIndex == 0 ? Colors.blue : Colors.grey), label: 'home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, color: _currentIndex == 1 ? Colors.blue : Colors.grey),
            label: 'cart',
            backgroundColor: _currentIndex == 0 ? Colors.blue : Colors.grey),
      ], onTap: (index) => setState(() => _currentIndex = index)),
    );
  }
}
