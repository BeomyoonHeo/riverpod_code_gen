import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_practice/domain/model/shopping_item_model.dart';
import 'package:riverpod_practice/domain/service/cart_list_service.dart';
import 'package:riverpod_practice/presentation/view/cart_list/cart_list_view_model_state.dart';

part 'cart_list_view_model.g.dart';

@riverpod
class CartListViewModel extends _$CartListViewModel {
  @override
  CartListViewModelState build() {
    final cartList = ref.read(cartListServiceProvider).cartList;
    ref.listen(cartListServiceProvider, (_, next) {
      _changeCartList(next.cartList);
    });
    return CartListViewModelState(cartList: cartList);
  }

  void _changeCartList(List<ShoppingItemModel> cartList) {
    state = state.copyWith(cartList: [...cartList]);
    Logger().i(state.cartList.length);
  }
}
