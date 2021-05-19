import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'newproduct.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'My Shop', home: MyShop());
  }
}

class MyShop extends StatefulWidget {
  @override
  _MyShopState createState() => _MyShopState();
}

class _MyShopState extends State<MyShop> {
  String titlecenter = "Loading...";
  List _listproduct;

  void initState() {
    super.initState();
    _loadProducts();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Product'),
      ),
      body: Center(
          child: Column(
        children: [
          _listproduct == null
              ? Flexible(child: Center(child: Text(titlecenter)))
              : Flexible(
                  child: Container(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                          child: GridView.count(
                              crossAxisCount: 2,
                              children:
                                  List.generate(_listproduct.length, (index) {
                                return Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Card(
                                        child: SingleChildScrollView(
                                            child: Column(
                                      mainAxisAlignment:MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: CachedNetworkImage(
                                              imageUrl:
                                                  "https://crimsonwebs.com/s270737/myshop/images/${_listproduct[index]['id']}.png",
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) =>
                                                  new Transform.scale(
                                                      scale: 1,
                                                      child:
                                                          CircularProgressIndicator()),
                                             ),
                                        ),
                                        SizedBox(height: 20),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text("Product Name:",
                                                  style:
                                                      TextStyle(fontSize: 16)),
                                              SizedBox(height: 30),
                                              GestureDetector(
                                                child: Text(
                                                    _listproduct[index]
                                                        ["prname"],
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color:
                                                            Colors.teal[900])),
                                              ),
                                            ]),
                                        
                                        
                                      ],
                                    ))));
                              })))
                    ],
                  )),
                ),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => NewProduct()));
        },
      ),
    );
  }

  void _loadProducts() async {
    http.post(
        Uri.parse(
            'https://crimsonwebs.com/s270737/myshop/php/loadproducts.php'),
        body: {}).then((response) {
      if (response.body == "nodata") {
        titlecenter = "Sorry product available";
      } else {
        var jsondata = json.decode(response.body);
        _listproduct = jsondata["products"];

        setState(() {
          print(_listproduct);
        });
      }
    });
  }
}
