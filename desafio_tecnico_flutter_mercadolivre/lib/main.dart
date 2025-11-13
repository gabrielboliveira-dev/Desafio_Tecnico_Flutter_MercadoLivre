import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'package:intl/date_symbol_data_local.dart';

import 'data/datasources/meli_api_datasources.dart';
import 'data/repositories/product_repository_impl.dart';

import 'domain/repositories/product_repository.dart';

import 'presentation/providers/product_search_provider.dart';
import 'presentation/providers/product_details_provider.dart';
import 'presentation/pages/product_search_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('pt_BR', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<http.Client>(create: (_) => http.Client()),
        Provider<MeliApiDataSource>(
          create: (context) =>
              MeliApiDataSourceImpl(client: context.read<http.Client>()),
        ),

        Provider<ProductRepository>(
          create: (context) => ProductRepositoryImpl(
            dataSource: context.read<MeliApiDataSource>(),
          ),
        ),

        ChangeNotifierProvider<ProductSearchProvider>(
          create: (context) => ProductSearchProvider(
            repository: context.read<ProductRepository>(),
          ),
        ),

        ChangeNotifierProvider<ProductDetailsProvider>(
          create: (context) => ProductDetailsProvider(
            repository: context.read<ProductRepository>(),
          ),
        ),
      ],

      child: MaterialApp(
        title: 'Busca Mercado Livre',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
          scaffoldBackgroundColor: Colors.grey[100],
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.amber,
            foregroundColor: Colors.black87,
            elevation: 1,
          ),
          useMaterial3: true,
        ),
        home: const ProductSearchPage(),
      ),
    );
  }
}
