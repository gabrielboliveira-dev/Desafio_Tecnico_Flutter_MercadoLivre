import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants/api_constants.dart';
import '../models/product_details_model.dart';
import '../models/product_model.dart';

class ServerException implements Exception {
  final String message;
  ServerException(this.message);
}

abstract class MeliApiDataSource {
  Future<List<ProductModel>> searchProducts(String query);
  Future<ProductDetailsModel> getProductDetails(String id);
}

class MeliApiDataSourceImpl implements MeliApiDataSource {
  final http.Client client;

  MeliApiDataSourceImpl({required this.client});

  @override
  Future<List<ProductModel>> searchProducts(String query) async {
    final uri = Uri.parse(
      '${ApiConstants.baseUrl}${ApiConstants.search}?q=$query',
    );

    final response = await client.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List results = data['results'];
      return results.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw ServerException('Falha ao buscar produtos: ${response.statusCode}');
    }
  }

  @override
  Future<ProductDetailsModel> getProductDetails(String id) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.items}/$id');

    final response = await client.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return ProductDetailsModel.fromJson(data);
    } else {
      throw ServerException('Falha ao buscar detalhes: ${response.statusCode}');
    }
  }
}
