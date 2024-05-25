
import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {

  bool _addNewProductInProgress = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _unitPriceTEController = TextEditingController();
  final TextEditingController _productCodeTEController = TextEditingController();
  final TextEditingController _quantityTEController = TextEditingController();
  final TextEditingController _totalPriceTEController = TextEditingController();
  final TextEditingController _imageTEController = TextEditingController();




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Product"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.text,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator:(String? value){
                    if(value == null || value.trim().isEmpty){
                      return "Write your product name";
                    }
                    return null;
                  } ,
                  controller: _nameTEController ,
                  textAlign: TextAlign.start,
                  decoration: const InputDecoration(
                    hintText: "Name",
                    labelText: "Name",
                  ),
                ),
                const SizedBox(height: 16.0),

                TextFormField(
                  keyboardType: TextInputType.number,
                  validator:(String? value){
                    if(value == null || value.trim().isEmpty){
                      return "Write your unit price";
                    }
                    return null;
                  } ,
                  controller:_unitPriceTEController,
                  textAlign: TextAlign.start,
                  decoration: const InputDecoration(
                    hintText: "Unit Price",
                    labelText: "Unit price",
                  ),
                ),
                const SizedBox(height: 16.0),

                TextFormField(
                  keyboardType: TextInputType.text,
                  validator:(String? value){
                    if(value == null || value.trim().isEmpty){
                      return "Write your product code";
                    }
                    return null;
                  } ,
                  controller: _productCodeTEController ,
                  textAlign: TextAlign.start,
                  decoration: const InputDecoration(
                    hintText: "Product Code",
                    labelText: "Product Code",
                  ),
                ),
                const SizedBox(height: 16.0),

                TextFormField(
                  keyboardType: TextInputType.number,
                  validator:(String? value){
                    if(value == null || value.trim().isEmpty){
                      return "Write your quantity";
                    }
                    return null;
                  } ,
                  controller: _quantityTEController,
                  textAlign: TextAlign.start,
                  decoration: const InputDecoration(
                    hintText: "Quantity",
                    labelText: "Quantity",
                  ),
                ),
                const SizedBox(height: 16.0),

                TextFormField(
                  keyboardType: TextInputType.number,
                  validator:(String? value){
                    if(value == null || value.trim().isEmpty){
                      return "Write your product total price";
                    }
                    return null;
                  } ,
                  controller:_totalPriceTEController ,
                  textAlign: TextAlign.start,
                  decoration: const  InputDecoration(
                    hintText: "Total Price",
                    labelText: "Total Price",
                  ),
                ),
                const SizedBox(height: 16.0),

                TextFormField(
                  keyboardType: TextInputType.text,
                  validator:(String? value){
                    if(value == null || value.trim().isEmpty){
                      return "Give your image";
                    }
                    return null;
                  } ,
                  controller:_imageTEController ,
                  textAlign: TextAlign.start,
                  decoration: const InputDecoration(
                    hintText: "Image",
                    labelText: "Image",
                  ),
                ),
                const SizedBox(height: 25.0),

                Visibility(
                  visible: _addNewProductInProgress == false,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: ElevatedButton(
                      onPressed: (){
                        if(_formKey.currentState!.validate()){

                          // call the post api method
                          _addProduct();

                        }
                      },
                      child: const Text("Add")
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


  // create "Post Api Method"
  Future<void> _addProduct() async {
    _addNewProductInProgress = true;
    setState(() {});

    // Step 1: Set Url
    const String addNewProductUrl = 'https://crud.teamrabbil.com/api/v1/CreateProduct';

    // Step 2:  Prepare data
    Map<String, dynamic> inputData = {
      "Img": _imageTEController.text,
      "ProductCode": _productCodeTEController.text,
      "ProductName": _nameTEController.text,
      "Qty": _quantityTEController.text,
      "TotalPrice": _totalPriceTEController.text,
      "UnitPrice": _unitPriceTEController.text
    };


    // step-3 = parse url into Uri
    Uri uri = Uri.parse(addNewProductUrl);

    // Step 4: Send Request
    Response response = await post(
      uri,
      body: jsonEncode(inputData),
      headers: {'content-type': 'application/json'},
    );
    print(response.statusCode);
    print(response.body);
    print(response.headers);

    // _addNewProductInProgress = false;
    // setState(() {});


    // step-5 = if statsCode is correct or incorrect then show toast message
    if (response.statusCode == 200) {
      // clean the form
      _nameTEController.clear();
      _unitPriceTEController.clear();
      _productCodeTEController.clear();
      _quantityTEController.clear();
      _totalPriceTEController.clear();
      _imageTEController.clear();

      // show confirmation text
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("New product added successfully!")),
      );
      Navigator.pop(context,true);
    } else {
      // show failed text
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Add product failed! Please try again.")),
      );
    }
    _addNewProductInProgress = false;
    setState(() {});
  }



  @override
  void dispose() {
    _nameTEController.dispose();
    _unitPriceTEController.dispose();
    _productCodeTEController.dispose();
    _quantityTEController.dispose();
    _totalPriceTEController.dispose();
    _imageTEController.dispose();
    super.dispose();
  }
}
