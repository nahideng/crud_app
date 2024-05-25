
import 'dart:convert';
import 'package:crud_app/models/data_model.dart';
import 'package:crud_app/screens/add_product_screen.dart';
import 'package:crud_app/screens/update_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ProductScreenList extends StatefulWidget {
  const ProductScreenList({super.key});

  @override
  State<ProductScreenList> createState() => _ProductScreenListState();
}

class _ProductScreenListState extends State<ProductScreenList> {
  bool _getProductListInProgress = false;
  List<Product> productList = [];

  // Show Dialog
  void _showConfirmationDialog(String productId) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Center(child: Text("Delete")),
            content: const Text(
                "Are you sure that you want to deleted this product?"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: () {
                    _deleteProduct(productId);
                    Navigator.pop(context);
                  },
                  child: const Text("Yes,Delete"))
            ],
          );
        });
  }

  // create "Del"/ delete Api method"
  Future<void> _deleteProduct(String productId) async {
    _getProductListInProgress = true;
    setState(() {});

    // step-1 = set url
    String deleteProductUrl =
        'https://crud.teamrabbil.com/api/v1/DeleteProduct/$productId';

    // step-2 = Parse Url into uri
    Uri uri = Uri.parse(deleteProductUrl);

    // step-3 = send request (GET)
    Response response = await get(uri);

    // print the console
    print(response.statusCode);
    print(response.body);

    // step-4 = check the Response
    if (response.statusCode == 200) {
      // again call getProductList
      _getProductList();

      // confirmation message show
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Delete product successfully.")),
      );
    } else {
      //set loading stop
      _getProductListInProgress = false;
      setState(() {});
      // show failed text
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Delete product failed! Please try again.")),
      );
    }
  }

  @override
  void initState() {
    _getProductList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product List"),
      ),
      body: Visibility(
        visible: _getProductListInProgress == false,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: ListView.separated(
            itemCount: productList.length,
            separatorBuilder: (_, __) {
              return const Divider();
            },
            itemBuilder: (context, index) {
              final productData = productList[index];
              return ListTile(
                leading: CircleAvatar(
                    child: Image.network(productData.image ?? '',
                        width: 250, height: 250)),
                title: Text(
                  productData.productName ?? '',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Wrap(
                  children: [
                    Text("Unit Price : ${productData.unitPrice} "),
                    Text("Quantity : ${productData.quantity} "),
                    Text("Total Price : ${productData.totalPrice}"),
                  ],
                ),
                trailing: Wrap(
                  children: [
                    IconButton(
                        onPressed: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  UpdatedProductScreen(product: productData),
                            ),
                          );
                          if (result == true) {
                            _getProductList();
                            setState(() {});
                          }
                        },
                        icon: const Icon(Icons.edit)),
                    IconButton(
                        onPressed: () {
                          _showConfirmationDialog(productData.id!);
                        },
                        icon: const Icon(Icons.delete_outline_outlined))
                  ],
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result2 = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>  AddProductScreen(),
            ),
          );
          if (result2==true) {
            _getProductList();
            setState(() {});
          }

        },
        child: const Icon(Icons.add),
      ),
    );
  }

  // create "Get Api method"
  Future<void> _getProductList() async {
    _getProductListInProgress = true;
    setState(() {});
    productList.clear();

    // step-1 = set url
    const String productListUrl =
        'https://crud.teamrabbil.com/api/v1/ReadProduct';

    // step-2 = Parse Url into uri
    Uri uri = Uri.parse(productListUrl);

    // step-3 = send request (GET)
    Response response = await get(uri);

    // print the console
    print(response.statusCode);
    print(response.body);

    // step-4 = check the Response
    if (response.statusCode == 200) {
      // decode the data
      final decodedData = jsonDecode(response.body);

      // get the list
      //List<Map<String, dynamic>> ProductItem = decodedData['data'];
      final ProductItem = decodedData['data'];

      // loop over in this list
      for (Map<String, dynamic> p in ProductItem) {
        // crate the Product class instance
        Product product = Product.fromJson(p);
        // add product into one by one productList
        productList.add(product);
      }
    } else {
      // show failed text
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Get product list failed! Please try again.")),
      );
    }

    // When finished all task, then we will set it false
    _getProductListInProgress = false;
    setState(() {});
  }
}
