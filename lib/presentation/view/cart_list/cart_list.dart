import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_practice/presentation/view/cart_list/cart_list_view_model.dart';
import 'package:riverpod_practice/presentation/view/shoping_list/shop_list_view_model.dart';

class CartList extends HookConsumerWidget {
  const CartList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(cartListViewModelProvider.select((value) => value.cartList));
    return Scaffold(
      body: Container(
          child: ListView.builder(
        itemBuilder: (_, index) => ListTile(
          title: Text(vm[index].title),
        ),
        itemCount: vm.length,
      )),
    );
  }
}
