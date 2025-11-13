import 'package:flutter/material.dart';
import '../../domain/entities/product_details_entity.dart';
import '../../domain/repositories/product_repository.dart';

enum DetailsState { initial, loading, success, error }

class ProductDetailsProvider extends ChangeNotifier {
  final ProductRepository repository;

  ProductDetailsProvider({required this.repository});
  DetailsState _state = DetailsState.initial;
  String _errorMessage = '';
  ProductDetailsEntity? _productDetails;

  DetailsState get state => _state;
  String get errorMessage => _errorMessage;
  ProductDetailsEntity? get productDetails => _productDetails;
  Future<void> fetchProductDetails(String id) async {
    _state = DetailsState.loading;
    _productDetails = null;
    notifyListeners();

    try {
      _productDetails = await repository.getProductDetails(id);
      _state = DetailsState.success;
    } catch (e) {
      _state = DetailsState.error;
      _errorMessage = 'Erro ao buscar detalhes: ${e.toString()}';
    }
    notifyListeners();
  }
}
