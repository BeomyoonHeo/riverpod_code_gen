import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_practice/core/extension/list.dart';
import 'package:riverpod_practice/data/repository/shopping_repository_impl.dart';
import 'package:riverpod_practice/domain/model/shopping_item_model.dart';
import 'package:riverpod_practice/domain/repository/shopping_repository.dart';
import 'package:riverpod_practice/domain/service/cart_list_service.dart';
import 'package:riverpod_practice/presentation/view/shoping_list/shop_list_view_model_state.dart';

part 'shop_list_view_model.g.dart';

@riverpod
class ShopListViewModel extends _$ShopListViewModel {
  @override
  ShopListViewModelState build() {
    return const ShopListViewModelState();
  }

  late final ShoppingRepository _shoppingRepository = ref.watch(shoppingRepositoryProvider);
  late final List<ShoppingItemModel> _cartList = ref.read(cartListServiceProvider).cartList;

  Future<void> getShoppingList() async {
    final response = await _shoppingRepository.getShoppingList();
    response.fold((l) {
      state = state.copyWith(
          shoppingList: l
              .map((e) => ShoppingItemModel.fromResponse(e))
              .map((e) => _cartList.firstWhereOrNull((p0) => p0.id == e.id) == null ? e : e.copyWith(isAddedCart: true))
              .toList(),
          loading: const AsyncData(null));
    }, (r) => state = state.copyWith(loading: AsyncError(r, StackTrace.current)));
  }

  void changeCategory(EnumCategory category) {
    if (state.enumCategory == category) {
      return;
    }
    state = state.copyWith(enumCategory: category);
  }

  void changeSearchWord(String searchWord) {
    state = state.copyWith(searchWord: searchWord);
  }

  void addCart(ShoppingItemModel shoppingItemModel) {
    final bool isAddedCart = !shoppingItemModel.isAddedCart;
    shoppingItemModel = shoppingItemModel.copyWith(isAddedCart: isAddedCart);
// ignore: avoid_manual_providers_as_generated_provider_dependency
    ref.read(cartListServiceProvider).addCart(shoppingItemModel);
    state = state.copyWith(
        shoppingList: state.shoppingList.map((e) => e.id == shoppingItemModel.id ? shoppingItemModel : e).toList());
  }
}

@riverpod
List<ShoppingItemModel> categoryFilterShopList(CategoryFilterShopListRef ref) {
  final shoppingList = ref.watch(shopListViewModelProvider.select((vm) => vm.shoppingList));
  final category = ref.watch(shopListViewModelProvider.select((vm) => vm.enumCategory));
  switch (category) {
    case EnumCategory.electronics:
      return shoppingList.where((element) => element.category.category == EnumCategory.electronics).toList();
    case EnumCategory.jewelery:
      return shoppingList.where((element) => element.category.category == EnumCategory.jewelery).toList();
    case EnumCategory.menClothing:
      return shoppingList.where((element) => element.category.category == EnumCategory.menClothing).toList();
    case EnumCategory.womenClothing:
      return shoppingList.where((element) => element.category.category == EnumCategory.womenClothing).toList();
    case EnumCategory.none:
      return shoppingList;
  }
}

@riverpod
List<ShoppingItemModel> wordFilterShopList(WordFilterShopListRef ref) {
  final shoppingList = ref.watch(categoryFilterShopListProvider);
  final searchWord = ref.watch(shopListViewModelProvider.select((vm) => vm.searchWord));
  return shoppingList.where((element) => element.title.contains(searchWord)).toList();
}
