import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_practice/domain/model/shopping_item_model.dart';

part 'shop_list_view_model_state.freezed.dart';

// => can other use extends Equatable
@freezed
class ShopListViewModelState with _$ShopListViewModelState {
  const factory ShopListViewModelState({
    @Default([]) final List<ShoppingItemModel> shoppingList,
    @Default(EnumCategory.none) final EnumCategory enumCategory,
    @Default('') final String searchWord,
    @Default(AsyncLoading()) final AsyncValue<void> loading, //viewModel Loading
  }) = _ShopListViewModelState;
}
