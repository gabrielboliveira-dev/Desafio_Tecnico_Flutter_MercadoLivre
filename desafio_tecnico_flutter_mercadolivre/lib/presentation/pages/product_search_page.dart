import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_search_provider.dart';
import '../widgets/product_list_item.dart';
import '../pages/product_details_page.dart';

class ProductSearchPage extends StatefulWidget {
  const ProductSearchPage({Key? key}) : super(key: key);

  @override
  State<ProductSearchPage> createState() => _ProductSearchPageState();
}

class _ProductSearchPageState extends State<ProductSearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch() {
    final query = _searchController.text.trim();
    context.read<ProductSearchProvider>().searchProducts(query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Busca Mercado Livre'),
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black87,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Buscar produtos',
                hintText: 'Ex: smartphone, fone de ouvido...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _performSearch,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onSubmitted: (_) => _performSearch(),
            ),
          ),

          Expanded(
            child: Consumer<ProductSearchProvider>(
              builder: (context, provider, child) {
                switch (provider.state) {
                  case SearchState.initial:
                    return const Center(
                      child: Text('Digite sua busca acima para começar.'),
                    );
                  case SearchState.loading:
                    return const Center(child: CircularProgressIndicator());
                  case SearchState.error:
                    return Center(
                      child: Text(
                        provider.errorMessage,
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                    );
                  case SearchState.success:
                    if (provider.products.isEmpty) {
                      return const Center(
                        child: Text('Nenhum produto encontrado.'),
                      );
                    }
                    return ListView.builder(
                      itemCount: provider.products.length,
                      itemBuilder: (context, index) {
                        final product = provider.products[index];
                        return ProductListItem(
                          product: product,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProductDetailsPage(productId: product.id),
                              ),
                            );
                          },
                        );
                      },
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
