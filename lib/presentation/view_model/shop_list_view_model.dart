import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_practice/data/repository/shopping_repository_impl.dart';
import 'package:riverpod_practice/domain/model/shopping_item_model.dart';
import 'package:riverpod_practice/domain/repository/shopping_repository.dart';
import 'package:riverpod_practice/presentation/view_model/shop_list_view_model_state.dart';

part 'shop_list_view_model.g.dart';

@riverpod
class ShopListViewModel extends _$ShopListViewModel {
  @override
  ShopListViewModelState build() {
    _shoppingRepository = ref.watch(shoppingRepositoryProvider);
    return const ShopListViewModelState();
  }

  late final ShoppingRepository _shoppingRepository;

  Future<void> getShoppingList() async {
    final response = await _shoppingRepository.getShoppingList();
    response.fold((l) {
      state = state.copyWith(
          shoppingList: l.map((e) => ShoppingItemModel.fromResponse(e)).toList(), loading: const AsyncData(null));
    }, (r) => state = state.copyWith(loading: AsyncError(r, StackTrace.current)));
  }

  void changeCategory(EnumCategory category) {
    state = state.copyWith(enumCategory: category);
  }

  void changeSearchWord(String searchWord) {
    state = state.copyWith(searchWord: searchWord);
  }
}

@Riverpod(keepAlive: false)
List<ShoppingItemModel> shoppingList(ShoppingListRef ref) {
  final shoppingList = ref.watch(shopListViewModelProvider.select((value) => value.shoppingList));
  final searchWord = ref.watch(shopListViewModelProvider.select((value) => value.searchWord));
  final enumCategory = ref.watch(shopListViewModelProvider.select((value) => value.enumCategory));
  List<ShoppingItemModel> filteringShoppingList = [];

  List<ShoppingItemModel> searchWordFiltering(List<ShoppingItemModel> shoppingList) {
    if (searchWord.isEmpty) {
      return shoppingList;
    }
    return shoppingList.where((t) => t.title.contains(searchWord)).toList();
  }

  List<ShoppingItemModel> categoryFiltering() {
    switch (enumCategory) {
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

  void filtering() {
    filteringShoppingList.addAll(categoryFiltering());
    filteringShoppingList = searchWordFiltering(filteringShoppingList);
  }

  filtering();

  return filteringShoppingList;
}
