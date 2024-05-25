
import 'dart:convert';
import 'package:crud_app/models/data_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class UpdatedProductScreen extends StatefulWidget {
  final Product product;
  const UpdatedProductScreen({super.key, required this.product});

  @override
  State<UpdatedProductScreen> createState() => UpdatedProductScreenState();
}

class UpdatedProductScreenState extends State<UpdatedProductScreen> {

  bool _updateProductInProgress = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _unitPriceTEController = TextEditingController();
  final TextEditingController _productCodeTEController = TextEditingController();
  final TextEditingController _quantityTEController = TextEditingController();
  final TextEditingController _totalPriceTEController = TextEditingController();
  final TextEditingController _imageTEController = TextEditingController();


  @override
  void initState() {
    _nameTEController.text = widget.product.productName ?? '';
    _productCodeTEController.text = widget.product.productCode ?? '';
    _unitPriceTEController.text = widget.product.unitPrice ?? '';
    _quantityTEController.text = widget.product.quantity ?? '';
    _totalPriceTEController.text = widget.product.totalPrice ?? '';
    _imageTEController.text = widget.product.image ?? '';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Product"),
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
                  // set the condition
                  visible: _updateProductInProgress == false,
                  // if the condition is false , then show loading progress
                  replacement:const Center(
                      child: CircularProgressIndicator()
                  ) ,
                  // if the condition is true , then show Elevated button
                  child: ElevatedButton(
                      onPressed: (){
                        if(_formKey.currentState!.validate()){
                          _updateProduct();
                        }
                      },
                      child: const Text("Updated")
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


  // create "Put Api method"
  Future<void> _updateProduct() async {
    _updateProductInProgress = true;
    setState(() {});

    // step-1 = set the URL
    String updateProductUrl =
        'https://crud.teamrabbil.com/api/v1/UpdateProduct/${widget.product.id}';

    // Step 2:  Prepare data
    // which field we updated
    Map<String, dynamic> inputData = {
      "Img": _imageTEController.text,
      "ProductCode": _productCodeTEController.text,
      "ProductName": _nameTEController.text,
      "Qty": _quantityTEController.text,
      "TotalPrice": _totalPriceTEController.text,
      "UnitPrice": _unitPriceTEController.text
    };

    // step-3 = parse Url into Uri
    Uri uri = Uri.parse(updateProductUrl);

    // Step 4: Send Request
    Response response = await post(
      uri,
      body: jsonEncode(inputData),
      headers: {'content-type': 'application/json'},
    );

    // print the console
    print(response.statusCode);
    print(response.body);
    print(response.headers);

    // step-5 = if statsCode is correct or incorrect then show toast message
    if (response.statusCode == 200) {
      // show confirmation text
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Product has been successfully updated!")),
      );
      Navigator.pop(context,true);
    } else {
      // show failed text
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Updated product failed! Please try again.")),
      );
    }
    _updateProductInProgress = false;
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
