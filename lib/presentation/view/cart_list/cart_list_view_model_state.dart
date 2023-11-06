import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_practice/domain/model/shopping_item_model.dart';

part 'cart_list_view_model_state.freezed.dart';

@freezed
class CartListViewModelState with _$CartListViewModelState {
  const factory CartListViewModelState({
    @Default(<ShoppingItemModel>[]) final List<ShoppingItemModel> cartList,
  }) = _CartListViewModelState;
}
