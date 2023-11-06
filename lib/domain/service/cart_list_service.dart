import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_practice/domain/model/shopping_item_model.dart';

part 'cart_list_service.g.dart';

@Riverpod(keepAlive: true)
CartListService cartListService(CartListServiceRef ref) {
  return CartListService(ref);
}

class CartListService {
  CartListService(this.ref);
  final List<ShoppingItemModel> _cartList = [];
  final CartListServiceRef ref;

  void addCart(ShoppingItemModel shoppingItemModel) {
    final bool isAddedCart = shoppingItemModel.isAddedCart;

    if (isAddedCart) {
      _cartList.add(shoppingItemModel);
    } else {
      _cartList.removeWhere((element) => element.id == shoppingItemModel.id);
    }
    ref.notifyListeners();
  }

  List<ShoppingItemModel> get cartList => _cartList;
}
