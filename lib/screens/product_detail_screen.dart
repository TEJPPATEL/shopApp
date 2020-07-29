import 'package:ShopApp/providers/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const ROUTE_NAME = "/product-detail";

  @override
  Widget build(BuildContext context) {
    final routeArgus =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final String productId = routeArgus["id"];
    // final String productTitle = routeArgus["title"];
    //  get single product using firstWhere or make method in Products provider
    // final loadedProduct = Provider.of<Products>(context).items.firstWhere((product) => product.id == productId);
    final loadedProduct = Provider.of<Products>(context , listen: false).findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: Text(productId),
    );
  }
}
