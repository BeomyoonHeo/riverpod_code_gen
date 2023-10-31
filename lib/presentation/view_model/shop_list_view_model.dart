// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_practice/domain/model/shopping_item_model.dart';
import 'package:riverpod_practice/domain/repository/shopping_repository.dart';
import 'package:riverpod_practice/presentation/view_model/base/base_view_model.dart';
import 'package:riverpod_practice/presentation/view_model/shop_list_view_model_state.dart';

part 'shop_list_view_model.g.dart';

class ShopListViewModel extends BaseViewModel<ShopListViewModelState> {
  ShopListViewModel(this._ref) : super(const ShopListViewModelState());

  final _ref;

  @override
  void init() async {
    super.init();
    Logger().i('🐶🐶🐶init');
    await _getShoppingList();
  }

  @override
  void dispose() {
    super.dispose();
    Logger().i('🐶🐶🐶dispose');
  }

  Future<void> _getShoppingList() async {
    final response = await GetIt.instance.get<ShoppingRepository>().getShoppingList();

    response.fold((l) {
      changeState(() => state.copyWith(shoppingList: l.map((e) => ShoppingItemModel.fromResponse(e)).toList()));
      changeState(() => state.copyWith(loading: const AsyncData(null)));
    }, (r) => changeState(() => state.copyWith(loading: AsyncError(r, StackTrace.current))));
  }

  void changeCategory(EnumCategory category) {
    changeState(() => state.copyWith(enumCategory: category));
  }

  void changeSearchWord(String searchWord) {
    changeState(() => state.copyWith(searchWord: searchWord));
  }
}

final shopListViewModel = StateNotifierProvider.autoDispose<ShopListViewModel, ShopListViewModelState>((ref) {
  return ShopListViewModel(ref);
});

@riverpod
List<ShoppingItemModel> filterShoppingList(FilterShoppingListRef ref) {
  final shoppingList = ref.watch(shopListViewModel).shoppingList;
  final enumCategory = ref.watch(shopListViewModel).enumCategory;

  switch (enumCategory) {
    case EnumCategory.electronics:
      return shoppingList.where((element) => element.category.category == EnumCategory.electronics).toList();

    case EnumCategory.jewelery:
      return shoppingList.where((element) => element.category.category == EnumCategory.jewelery).toList();

    case EnumCategory.menClothing:
      return shoppingList.where((element) => element.category.category == EnumCategory.menClothing).toList();

    case EnumCategory.womenClothing:
      return shoppingList.where((element) => element.category.category == EnumCategory.womenClothing).toList();

    default:
      return shoppingList;
  }
}

@riverpod
List<ShoppingItemModel> searchShoppingList(SearchShoppingListRef ref) {
  final String searchWord = ref.watch(shopListViewModel).searchWord;
  final shoppingList = ref.watch(filterShoppingListProvider);

  if (searchWord.isEmpty) return shoppingList;

  return shoppingList.where((element) => element.title.contains(searchWord)).toList();
}
