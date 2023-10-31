import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:riverpod_practice/domain/repository/shopping_repository.dart';
import 'package:riverpod_practice/response/shopping_response.dart';

class ShoppingRepositoryImpl implements ShoppingRepository {
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
