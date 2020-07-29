import 'package:ShopApp/providers/auth.dart';
import 'package:ShopApp/providers/cart.dart';
import 'package:ShopApp/providers/products.dart';
import 'package:ShopApp/screens/auth_screen.dart';
import 'package:ShopApp/screens/edit_product_screen.dart';
import 'package:ShopApp/screens/nice_ui.dart';
import 'package:ShopApp/screens/product_detail_screen.dart';
import 'package:ShopApp/screens/product_overview_screen.dart';
import 'package:ShopApp/screens/user_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Auth()),

        ChangeNotifierProvider(
          create: (_) => Products(),
        ),
        // ChangeNotifierProvider.value(value: Cart())
        ChangeNotifierProvider(
          create: (_) => Cart(),
        )
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) => MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.orangeAccent,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: auth.isAuth ? ProductOverviewScreen() : AuthScreen(),
          routes: {
            ProductDetailScreen.ROUTE_NAME: (context) => ProductDetailScreen(),
            EditProductScreen.ROUTE_NAME: (context) => EditProductScreen(),
            UserProductScreen.ROUTE_NAME: (cotnext) => UserProductScreen(),
          },
        ),
      ),
    );
  }
}
