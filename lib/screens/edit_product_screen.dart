import 'package:ShopApp/providers/product.dart';
import 'package:ShopApp/providers/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {
  static const ROUTE_NAME = "/edit-product";

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  var isLoaded = false;
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageFocusNode = FocusNode();
  final _imageController = TextEditingController();

  final titleController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();

  // var _editedProduct =
  //     Product(id: null, title: '', price: 0, description: '', imageUrl: '');

  final _formKey = new GlobalKey<FormState>();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _imageController.dispose();
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _imageFocusNode.addListener(_updateImageUrl);
  }

  void _saveForm() {
    // _formKey..save();
    if (_formKey.currentState.validate()) {
      print("valid");
      print(titleController.text +
          priceController.text +
          descriptionController.text +
          _imageController.text);
    }
  }

  void _updateImageUrl() {
    if (!_imageFocusNode.hasFocus) {
      if ((!_imageController.text.startsWith('http') &&
              !_imageController.text.startsWith('https')) ||
          (!_imageController.text.endsWith('jpg') &&
              !_imageController.text.startsWith('png') &&
              !_imageController.text.endsWith("jpeg"))) {
        return;
      }
    }
    setState(() {});
  }

  var isInit = true;

  // var initalValue = {'title' : '' , 'description' : '' , 'price' : '' , 'imageUrl' : ''};
  var productId;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // if (isInit) {
    // var routeArgs =
    //     ModalRoute.of(context).settings.arguments as Map<String, String>;
    productId = ModalRoute.of(context).settings.arguments;
    print(productId);
    if (productId != null) {
      Product product = Provider.of<Products>(context).findById(productId);
      titleController.text = product.title;
      descriptionController.text = product.description;
      priceController.text = product.price.toString();
      _imageController.text = product.imageUrl;
    }
    //   else {

    //   }
    // }
    // isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Product"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  if (productId != null) {
                    _formKey.currentState.save();
                    Provider.of<Products>(context, listen: false).updateProduct(
                        productId,
                        Product(
                            id: productId,
                            imageUrl: _imageController.text,
                            title: titleController.text,
                            price: double.parse(priceController.text),
                            description: descriptionController.text));
                    Navigator.of(context).pop();
                    return;
                  }
                  // // print("ok");
                  // print(titleController.text +
                  //     priceController.text +
                  //     descriptionController.text +
                  //     _imageController.text);
                  // _formKey.currentState.save();
                  Provider.of<Products>(context, listen: false)
                      .addProduct(Product(
                          id: DateTime.now().toString(),
                          imageUrl: _imageController.text,
                          title: titleController.text,
                          price: double.parse(priceController.text),
                          description: descriptionController.text))
                      .catchError((error) {
                         setState(() {
                          isLoaded = true;
                        });
                      })
                      .then((_) {
                        setState(() {
                          isLoaded = true;
                        });
                    Navigator.of(context).pop();
                  }).catchError((error) => isLoaded = true);
                }
              })
        ],
      ),
      body: isLoaded
          ? Center(
              child: CircularProgressIndicator(backgroundColor: Colors.purple),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      controller: titleController,
                      validator: (val) =>
                          val.isNotEmpty ? null : 'Name should not be empty',
                      decoration: InputDecoration(labelText: "Title"),
                      textInputAction: TextInputAction
                          .next, // bottom right input click to next field
                      // onFieldSubmitted: , //work only when keyboard to submit data
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                    ),
                    TextFormField(
                      controller: priceController,
                      validator: (val) {
                        if (val.isEmpty) {
                          return "Please Enter Price";
                        }

                        if (double.tryParse(val) == null) {
                          return "Please enter Valid Number";
                        }
                        if (double.parse(val) <= 0) {
                          return "Please Enter value greater than Zero";
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: "Price"),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType
                          .number, // bottom right input click to next field
                      focusNode: _priceFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_descriptionFocusNode);
                      },
                    ),
                    TextFormField(
                      controller: descriptionController,
                      validator: (val) {
                        if (val.length < 10) {
                          return "Please write at 10 words in description";
                        }
                        if (val.isEmpty) {
                          return "Please Enter Description";
                        }
                        return null;
                      },
                      focusNode: _descriptionFocusNode,
                      maxLines: 3,
                      decoration: InputDecoration(labelText: "Description"),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType
                          .multiline, // bottom right input click to next field
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        // Container(
                        //   height: 100,
                        //   width: 100,
                        //   margin: EdgeInsets.only(top: 8, right: 10),
                        //   decoration: BoxDecoration(
                        //       border: Border.all(width: 1, color: Colors.grey)),
                        //   child: _imageController.text.isEmpty
                        //       ? Text("Image URL")
                        //       : FittedBox(
                        //           child: Image.network(_imageController.text,
                        //               fit: BoxFit.cover)),
                        // ),
                        Expanded(
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please Select Image Url";
                              }
                              if (!value.startsWith('http') &&
                                  !value.startsWith('https')) {
                                return "Please enter valid URL";
                              }
                              if (!value.endsWith('jpg') &&
                                  !value.endsWith('png') &&
                                  !value.endsWith('jpeg')) {
                                return "Please Enter valid Image";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.url,
                            decoration: InputDecoration(labelText: "Image URL"),
                            textInputAction: TextInputAction.done,
                            controller: _imageController,
                            focusNode: _imageFocusNode,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
