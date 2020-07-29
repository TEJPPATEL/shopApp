import 'package:ShopApp/providers/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Order"),
      ),
      body: ListView.builder(

        itemBuilder: (context, index) => Card(
          child: Dismissible(
            background: Container(
              color: Theme.of(context).errorColor,
              child: Icon(Icons.delete, color: Colors.white),
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 10),
            ),
            direction: DismissDirection.endToStart,
            confirmDismiss: (direction){
             return showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Are You Sure ? "),
                  content: Text("Do You Want to remove item from cart ?"),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("Yes"),
                      onPressed: () {
                        return Navigator.of(context).pop(true);
                      },
                    ),
                    FlatButton(
                      child: Text("No"),
                      onPressed: () {
                        return Navigator.of(context).pop(false);
                      },
                    )
                  ],
                ),
              );
              // return Future.value(true);
            },
            onDismissed: (direction) {
              //Not work here directly
              // Provider.of<Cart>(context).items.remove(cart.items.keys.firstWhere((element) =>  cart.items["key"] == cart.items.values.toList()[index])); //give id of product want to delete share through constructor of parent item 
            },
            key: ValueKey(cart.items.values.toList()[index].id),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                
                leading: CircleAvatar(
                  maxRadius: 30,
                  child: FittedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        "\$: ${cart.items.values.toList()[index].price.toString()}",
                      ),
                    ),
                  ),
                ),
                title: Text(cart.items.values.toList()[index].title),
                trailing: Text(
                    " ${cart.items.values.toList()[index].quantity.toString()} x"),
              ),
            ),
          ),
        ),
        itemCount: cart.items.length,
      ),
    );
  }
}
