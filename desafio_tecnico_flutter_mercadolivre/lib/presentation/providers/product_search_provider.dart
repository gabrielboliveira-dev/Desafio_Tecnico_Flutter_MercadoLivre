import 'package:flutter/material.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';

enum SearchState { initial, loading, success, error }

class ProductSearchProvider extends ChangeNotifier {
  final ProductRepository repository;

  ProductSearchProvider({required this.repository});

  SearchState _state = SearchState.initial;
  String _errorMessage = '';
  List<ProductEntity> _products = [];

  SearchState get state => _state;
  String get errorMessage => _errorMessage;
  List<ProductEntity> get products => _products;
  Future<void> searchProducts(String query) async {
    if (query.isEmpty) {
      _state = SearchState.initial;
      _products = [];
      notifyListeners();
      return;
    }
    _state = SearchState.loading;
    notifyListeners();

    try {
      _products = await repository.searchProducts(query);
      _state = SearchState.success;
    } catch (e) {
      _state = SearchState.error;
      _errorMessage = 'Erro ao buscar produtos: ${e.toString()}';
    }
    notifyListeners();
  }
}
