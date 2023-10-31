// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_practice/domain/model/shopping_item_model.dart';
import 'package:riverpod_practice/domain/repository/shopping_repository.dart';

part 'shop_list_view_model.g.dart';

@riverpod
List<ShoppingItemModel> filterShoppingList(FilterShoppingListRef ref) {
  final shoppingList = ref.watch(shopListProvider);
  final enumCategory = ref.watch(enumCategoryProvider);

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
  final String searchWord = ref.watch(searchWordProvider);
  final shoppingList = ref.watch(filterShoppingListProvider);

  if (searchWord.isEmpty) return shoppingList;

  return shoppingList.where((element) => element.title.contains(searchWord)).toList();
}

@riverpod
class ShopList extends _$ShopList {
  @override
  List<ShoppingItemModel> build() {
    return [];
  }

  void add(ShoppingItemModel item) {
    state = [...state, item];
  }

  void addAll(List<ShoppingItemModel> items) {
    state = [...state, ...items];
  }
}

abstract class BaseViewModel<T> extends StateNotifier<AsyncValue<T>> {
  BaseViewModel(super.state) {
    init();
  }

  @protected
  void init() {
    if (mounted) {
      state = const AsyncValue.loading();
    }
  }

  @override
  void dispose() {
    if (mounted) {
      super.dispose();
    }
  }
}

class ShopListViewModel extends BaseViewModel<void> {
  ShopListViewModel({
    required List<ShoppingItemModel> shoppingList,
    required ShoppingRepository shoppingRepository,
    required enumCategory,
    required searchWordProvider,
  })  : _shoppingList = shoppingList,
        _shoppingRepository = shoppingRepository,
        _enumCategory = enumCategory,
        _searchWord = searchWordProvider,
        super(const AsyncData(null));

  final List<ShoppingItemModel> _shoppingList;
  final ShoppingRepository _shoppingRepository;
  final StateController<EnumCategory> _enumCategory;
  final StateController<String> _searchWord;

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
    final response = await _shoppingRepository.getShoppingList();
    response.fold((l) {
      _shoppingList.addAll(l.map((e) => ShoppingItemModel.fromResponse(e)).toList());
      state = const AsyncData(null);
    }, (r) => state = AsyncError(r, StackTrace.current));
  }

  void changeCategory(EnumCategory category) {
    _enumCategory.state = category;
  }

  void changeSearchWord(String searchWord) {
    _searchWord.state = searchWord;
  }
}

final shopListViewModel = StateNotifierProvider.autoDispose<ShopListViewModel, AsyncValue<void>>((ref) {
  final shopList = ref.watch(shopListProvider);
  final shoppingRepository = GetIt.instance.get<ShoppingRepository>();
  final enumCategory = ref.read(enumCategoryProvider.notifier);
  final searchWord = ref.read(searchWordProvider.notifier);
  return ShopListViewModel(
      shoppingList: shopList,
      shoppingRepository: shoppingRepository,
      enumCategory: enumCategory,
      searchWordProvider: searchWord);
});

final searchWordProvider = StateProvider.autoDispose<String>((ref) => '');
