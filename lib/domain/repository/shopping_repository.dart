import 'package:fpdart/fpdart.dart';
import 'package:riverpod_practice/data/response/shopping_response.dart';

abstract class ShoppingRepository {
  factory ShoppingRepository() => ShoppingRepository();

  Future<Either<List<ShoppingResponse>, Exception>> getShoppingList();
}
