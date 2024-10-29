import 'package:flutter/material.dart';

class Product {
  final String productName;
  final double price;
  final String capacity;
  final String createdDate;

  Product(
      {required this.productName,
      required this.price,
      required this.capacity,
      required this.createdDate});
}

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  ProductListState createState() => ProductListState();
}

class ProductListState extends State<ProductList> {
  final List<Product> products = [
    Product(
        productName: 'Product A',
        capacity: '200g',
        price: 200,
        createdDate: '29-10-2024'),
    Product(
        productName: 'Product A',
        capacity: '200g',
        price: 200,
        createdDate: '29-10-2024'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/addProduct');
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(50, 50),
                backgroundColor: const Color.fromARGB(255, 67, 190, 243),
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Add Product',
                style: TextStyle(fontSize: 18),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: DataTable(
                headingRowColor: WidgetStateColor.resolveWith(
                    (states) => const Color.fromARGB(255, 67, 190, 243)),
                dataRowColor: WidgetStateColor.resolveWith((states) =>
                    states.contains(WidgetState.selected)
                        ? Colors.blue.withOpacity(0.08)
                        : Colors.white),
                columns: const [
                  DataColumn(label: Text("Product Name")),
                  DataColumn(label: Text("Capacity")),
                  DataColumn(label: Text("Price")),
                  DataColumn(label: Text("Created Date")),
                ],
                rows: products.map((item) {
                  return DataRow(cells: [
                    DataCell(Text(item.productName)),
                    DataCell(Text(item.capacity)),
                    DataCell(Text(item.price.toString())),
                    DataCell(Text(item.createdDate)),
                  ]);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
