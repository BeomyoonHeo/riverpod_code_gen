import 'package:get_it/get_it.dart';
import 'package:riverpod_practice/data/repository/shopping_repository_impl.dart';
import 'package:riverpod_practice/domain/repository/shopping_repository.dart';

abstract class GetItLocator {
  static final _getIt = GetIt.instance;

  static Future<void> dependencies() async {
    _getIt.registerSingleton<ShoppingRepository>(ShoppingRepositoryImpl());
  }
}
