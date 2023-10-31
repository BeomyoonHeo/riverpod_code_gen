import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_practice/response/shopping_response.dart';

part 'shopping_item_model.freezed.dart';

@Freezed(copyWith: true, equal: true)
class ShoppingItemModel with _$ShoppingItemModel {
  const factory ShoppingItemModel({
    required final int id,
    required final String title,
    required final double price,
    required final String description,
    required final CategoryModel category,
    required final String image,
    required final RatingModel rating,
  }) = _ShoppingItemModel;

  factory ShoppingItemModel.fromResponse(ShoppingResponse response) => ShoppingItemModel(
        id: response.id,
        title: response.title,
        price: response.price,
        description: response.description,
        category: CategoryModel.fromResponse(response),
        image: response.image,
        rating: RatingModel(
          rate: response.rating.rate,
          count: response.rating.count,
        ),
      );
}

@Freezed(copyWith: true, equal: true)
class RatingModel with _$RatingModel {
  const factory RatingModel({
    required final double rate,
    required final int count,
  }) = _RatingModel;
}

@Freezed(copyWith: true, equal: true)
class CategoryModel with _$CategoryModel {
  const factory CategoryModel({
    required final EnumCategory category,
  }) = _CategoryModel;

  factory CategoryModel.fromResponse(ShoppingResponse response) =>
      CategoryModel(category: EnumCategory.fromName(response.category));
}

enum EnumCategory {
  electronics('electronics'),
  jewelery('jewelery'),
  menClothing('men\'s clothing'),
  womenClothing('women\'s clothing'),
  none('');

  const EnumCategory(this._name);

  final String _name;

  factory EnumCategory.fromName(String name) {
    switch (name) {
      case 'electronics':
        return EnumCategory.electronics;
      case 'jewelery':
        return EnumCategory.jewelery;
      case 'men\'s clothing':
        return EnumCategory.menClothing;
      case 'women\'s clothing':
        return EnumCategory.womenClothing;
      default:
        return EnumCategory.none;
    }
  }
}

final enumCategoryProvider = StateProvider.autoDispose((ref) => EnumCategory.none);
