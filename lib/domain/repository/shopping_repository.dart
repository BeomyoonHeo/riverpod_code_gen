import 'package:fpdart/fpdart.dart';
import 'package:riverpod_practice/response/shopping_response.dart';

abstract class ShoppingRepository {
  Future<Either<List<ShoppingResponse>, Exception>> getShoppingList();
}
