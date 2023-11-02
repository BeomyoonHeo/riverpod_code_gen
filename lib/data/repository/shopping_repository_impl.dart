import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_practice/data/response/shopping_response.dart';
import 'package:riverpod_practice/domain/repository/shopping_repository.dart';

part 'shopping_repository_impl.g.dart';

@Riverpod(keepAlive: true)
ShoppingRepository shoppingRepository(ShoppingRepositoryRef ref) => const ShoppingRepositoryImpl();

class ShoppingRepositoryImpl implements ShoppingRepository {
  const ShoppingRepositoryImpl();

  @override
  Future<Either<List<ShoppingResponse>, Exception>> getShoppingList() async {
    final url = Uri.parse('https://fakestoreapi.com/products');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final shoppingResponseList =
          jsonDecode(response.body).map((e) => ShoppingResponse.fromJson(e)).toList().cast<ShoppingResponse>();
      return left(shoppingResponseList);
    } else {
      return right(Exception('error'));
    }
  }
}
