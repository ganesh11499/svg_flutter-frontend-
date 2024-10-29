import 'package:flutter/material.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  AddProductState createState() => AddProductState();
}

class AddProductState extends State<AddProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 15,
                        offset: const Offset(0, 3)),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Add Product',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),

                    //Product name input feild
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Product Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          )),
                    ),

                    //Capacity input feild
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Capacity',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          )),
                    ),

                    //Price input feild
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Price',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0))),
                    ),

                    //utton
                    const SizedBox(height : 24),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/productList');
                      },

                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(350, 50),
                        backgroundColor: Colors.grey,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Save Product'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
