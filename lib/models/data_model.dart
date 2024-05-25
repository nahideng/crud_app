

class Product {
  String? id;
  String? productName;
  String? productCode;
  String? image;
  String? unitPrice;
  String? quantity;
  String? totalPrice;
  String? createdDate;

  Product({
    this.id,
    this.productName,
    this.productCode,
    this.image,
    this.unitPrice,
    this.quantity,
    this.totalPrice,
    this.createdDate
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    productName = json['ProductName'];
    productCode = json['ProductCode'];
    image = json['Img'];
    unitPrice = json['UnitPrice'];
    quantity = json['Qty'];
    totalPrice = json['TotalPrice'];
    createdDate = json['CreatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['ProductName'] = this.productName;
    data['ProductCode'] = this.productCode;
    data['Img'] = this.image;
    data['UnitPrice'] = this.unitPrice;
    data['Qty'] = this.quantity;
    data['TotalPrice'] = this.totalPrice;
    data['CreatedDate'] = this.createdDate;
    return data;
  }
}
