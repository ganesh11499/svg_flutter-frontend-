import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'dart:html' as html;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class ShopRegisterForm extends StatefulWidget {
  const ShopRegisterForm({super.key});

  @override
  ShopRegisterFormState createState() => ShopRegisterFormState();
}

//logger
final Logger logger = Logger();


//toast notifications
void showToast() {
  Fluttertoast.showToast(
    msg: "This is toast msg",
    toastLength: Toast.LENGTH_SHORT, //duration
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.white,
    textColor: Colors.black,
    fontSize: 16.0,
  );
}




//Shop register api function
Future<void> registerShop(context, String shopName, email, mobile, address, city, state, pincode, picture, userId) async{

  const url = 'http://localhost:3000/shop-register/shopRegister';

  try {
    final Map<String, dynamic> body = {
      'shopName' : shopName,
      'email' : email,
      'mobile' : mobile,
      'address' : address,
      'city' : city,
      'state' : state,
      'pincode' : pincode,
      'picture' : picture,
      'userId' : userId,
    };

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(body),
    );
    if(response.statusCode == 201) {
      Fluttertoast.showToast(
        msg: "Successfully Shop Registered",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0,
      );
      Navigator.pushNamed(context, '/home');
    }else {
        Fluttertoast.showToast(
        msg: "Failed To Register Shop",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0,
      );
    }
  } catch (error) {
     // Catch and handle any network or other errors
    Fluttertoast.showToast(
      msg: "Failed To Rgister Shop",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      fontSize: 16.0,
    );
  }
} 



class ShopRegisterFormState extends State<ShopRegisterForm> {
  final TextEditingController shopNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController pictureController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int ? userId;
  int ? shopId;
  String? userName;

// getShopDetails(int ? shopId);


//Shop Details get api function
Future<void> getShopDetails(int shopId) async{
  final url = Uri.parse('http://localhost:3000/shop-register/$shopId');

  try {
    final response = await http.get(url);

    if(response.statusCode == 200){
      final shopDetails = json.decode(response.body);
      logger.i("ShopDetails: $shopDetails");
      setState(() {
        shopNameController.text = shopDetails['shopName'] ?? '';
        addressController.text = shopDetails['address'] ?? '';
        emailController.text = shopDetails['email'] ?? '';
        mobileController.text = shopDetails['mobile'] ?? '';
        cityController.text = shopDetails['city'] ?? '';
        stateController.text = shopDetails['state'] ?? '';
        pincodeController.text = shopDetails['pincode'] ?? '';
        pictureController.text = shopDetails['picture'] ?? '';
      });
    }else {
      logger.e("Failed to load shop details");
    }
  } catch (e) {
    logger.e("Error: $e");
  }
}


 @override
  void initState() {
    super.initState();
    loadLoginUserData();
  }

//Get local storage login user data  
Future<void> loadLoginUserData () async {
  setState(() {
    userId = int.tryParse(html.window.localStorage['flutter.userId'] ?? '0') ?? 0;
    shopId = int.tryParse(html.window.localStorage['flutter.shopId'] ?? '0') ?? 0;
    userName = html.window.localStorage['flutter.userName'];
  });
 logger.i("Saved userData: $userName, userId: $userId, shopId:$shopId");

 if (shopId != null && shopId! > 0) {
      await getShopDetails(shopId!);
    } else {
      logger.e("Invalid shopId. Cannot fetch shop details.");
    }
} 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        title: const Text(
          "SVG",
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
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
                          offset: const Offset(0, 3))
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Shop Register Form',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),

                    //Shop name input feild
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: shopNameController,
                      decoration: InputDecoration(
                        labelText: 'Shop Name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                      ),
                       
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter shop name';
                        }
                        return null;
                      },
                    ),

                    //Email input feild
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                      ),
                      
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter email';
                        }
                        return null;
                      },
                    ),

                    //Mobile number input feild
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: mobileController,
                      decoration: InputDecoration(
                        labelText: 'Mobile Number',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                      ),
                      
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter mobile number';
                        }
                        return null;
                      },
                    ),

                    //Address  input feild
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: addressController,
                      decoration: InputDecoration(
                        labelText: "Address",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                      ),
                      
                      validator: (value) {
                        if(value == null || value.isEmpty){
                          return "Please enter address";
                        }
                        return null;
                      },
                    ),

                    //City input feild
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: cityController,
                      decoration: InputDecoration(
                        labelText: "City",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                      ),
                      
                      validator: (value) {
                        if(value == null || value.isEmpty){
                          return "Please enter city";
                        }
                        return null;
                      },
                    ),

                    //State input feild
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: stateController,
                      decoration: InputDecoration(
                        labelText: "State",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                      ),
                      
                      validator: (value) {
                        if(value == null || value.isEmpty){
                          return "Please enter state";
                        }
                        return null;
                      },
                    ),

                    //Pincode input feild
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: pincodeController,
                      decoration: InputDecoration(
                        labelText: "Pincode",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.9)),
                      ),
                      
                      validator: (value) {
                        if(value == null || value.isEmpty){
                          return "Please enter pincode";
                        }
                        return null;
                      },
                    ),

                    //Picture image selction input feild
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: pictureController,
                      decoration: InputDecoration(
                        labelText: "Select Image",
                        // suffixIcon: IconButton(onPressed: _pickImage, icon: Icon(Icons.photo)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                      ),
                      
                      validator: (value) {
                        if(value == null || value.isEmpty){
                          return "Please select image";
                        }
                        return null;
                      },
                    ),

                    //Shop register submit button
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if(_formKey.currentState?.validate() ?? false){
                        registerShop(
                          context,
                          shopNameController.text,
                          emailController.text,
                          mobileController.text,
                          addressController.text,
                          cityController.text,
                          stateController.text,
                          pincodeController.text,
                          pictureController.text,
                          userId,
                        );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(350, 50),
                        backgroundColor: Colors.grey,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                      ),
                      child: const Text(
                        "Submit",
                        style: TextStyle(fontSize: 18),
                      ),
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
