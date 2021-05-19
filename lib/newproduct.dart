import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'main.dart';

class NewProduct extends StatefulWidget {
  @override
  _NewProductState createState() => _NewProductState();
}

class _NewProductState extends State<NewProduct> {
  TextEditingController name = new TextEditingController();
  TextEditingController type = new TextEditingController();
  TextEditingController price = new TextEditingController();
  TextEditingController quantity = new TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ProgressDialog pr;
  File _image;
  String pathAsset = 'asset/images/image.jpg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Product'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
              elevation: 20,
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text('Product Detail',
                            style: TextStyle(
                                fontSize: 26, fontWeight: FontWeight.bold)),
                        Container(
                            padding: EdgeInsets.only(top:15),
                            alignment: Alignment.centerLeft,
                            child: Text("Name",
                                style: TextStyle( fontSize: 15,fontWeight: FontWeight.bold))),
                        TextFormField(
                          controller: name,
                          decoration: InputDecoration(
                            hintText: 'Name',
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'This field is required';
                            }
                            // Return null if the entered username is valid
                            return null;
                          },
                        ),
                        Container(
                            padding: EdgeInsets.only(top:15),
                            alignment: Alignment.centerLeft,
                            child: Text("Type",
                                style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold))),
                        TextFormField(
                          controller: type,
                          decoration: InputDecoration(hintText: 'Type'),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (String value) {
                            if (value.isEmpty) return "This field is required";
                            return null;
                          },
                        ),
                        Container(
                            padding: EdgeInsets.only(top:15),
                            alignment: Alignment.centerLeft,
                            child: Text("Price(RM)",
                                style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold))),
                        TextFormField(
                            controller: price,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(hintText: 'Price'),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (String value) {
                              if (value.isEmpty)
                                return "This field is required";
                              return null;
                            }),
                        Container(
                            padding: EdgeInsets.only(top:15),
                            alignment: Alignment.centerLeft,
                            child: Text("Quantity",
                                style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold))),
                        TextFormField(
                          controller: quantity,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Quantity',
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (String value) {
                            if (value.length == 0)
                              return "This field is required";
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        Text("Add Image",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        SizedBox(height: 5),
                        GestureDetector(
                          onTap: () => {_onPictureSelectionDialog()},
                          child: Container(
                              height: 250,
                              width: 250,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: _image == null
                                      ? AssetImage(pathAsset)
                                      : FileImage(_image),
                                  fit: BoxFit.scaleDown,
                                ),
                              )),
                        ),
                        //  ),
                        MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            minWidth: 200,
                            child: Text('Add Product',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                            color: Colors.blueAccent,
                            onPressed: () {
                              _onAddProduct();
                            })
                      ],
                    ),
                  ))),
        ),
      ),
    );
  }

  _onPictureSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          content: new Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Take picture from:",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    )),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                        child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      minWidth: 100,
                      height: 100,
                      child: Text('Camera',
                          style: TextStyle(
                            color: Colors.white,
                          )),
                      color: Theme.of(context).accentColor,
                      elevation: 10,
                      onPressed: () =>
                          {Navigator.pop(context), _chooseCamera()},
                    )),
                    SizedBox(width: 10),
                    Flexible(
                        child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      minWidth: 100,
                      height: 100,
                      child: Text('Gallery',
                          style: TextStyle(
                            color: Colors.white,
                          )),
                      color: Theme.of(context).accentColor,
                      elevation: 10,
                      onPressed: () =>
                          {Navigator.pop(context), _chooseGallery()},
                    )),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future _chooseCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(
      source: ImageSource.camera,
      maxHeight: 500,
      maxWidth: 500,
    );

    if (pickedFile != null) {
      _image = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
  }

  _chooseGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
      maxHeight: 800,
      maxWidth: 800,
    );

    if (pickedFile != null) {
      _image = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
  }

  void _onAddProduct() {
    setState(() {
      String _name = name.text.toString();
      String _type = type.text.toString();
      String _price = price.text.toString();
      String _quantity = quantity.text.toString();

      if (_image == null ||
          _name.isEmpty ||
          _type.isEmpty ||
          _price.isEmpty ||
          _quantity.isEmpty) {
        Fluttertoast.showToast(
            msg: "Please enter valid information of product!",
            backgroundColor: Colors.red);
      }

      _addProduct(_name, _type, _price, _quantity);

      return;
    });
  }

  //upload to database
  Future<void> _addProduct(
      String name, String type, String price, String quantity) async {
    String base64Image = base64Encode(_image.readAsBytesSync());

    http.post(
        Uri.parse('https://crimsonwebs.com/s270737/myshop/php/newproduct.php'),
        body: {
          "prname": name,
          "prtype": type,
          "prprice": price,
          "prqty": quantity,
          "encoded_string": base64Image
        }).then((response) {
      print(response.body);
      if (response.body == "success") {
        Fluttertoast.showToast(
            msg: "Add " + name + " successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);

        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (content) => MyShop()));
      }
    });
  }
}
