import 'package:ShopApp/providers/products.dart';
import 'package:ShopApp/screens/edit_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProductScreen extends StatelessWidget {
  static String ROUTE_NAME = "/user-product";
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text("User Product"),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: 500,
            child: ListView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.red,
                          // backgroundImage: NetworkImage(products.items[index].imageUrl),
                        ),
                        title: Text(products.items[index].title),
                        trailing: Container(
                          width: 100,
                          child: Row(
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  print(products.items[index].id);
                                  Navigator.pushNamed(context, EditProductScreen.ROUTE_NAME , arguments: products.items[index].id);
                                },
                              ),
                               IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        )),
                  );
                },
                itemCount: products.items.length),
          ),
        ));
  }
}
