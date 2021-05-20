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
  double screenHeight, screenWidth;
  String titlecenter = "Loading...";
  List _listproduct;

  @override
  void initState() {
    super.initState();
    _loadproduct();
  }

  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
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
                        child: Center(
                            child: GridView.count(
                                crossAxisCount: 2,
                                childAspectRatio:
                                    (screenWidth / screenHeight) / 0.9,
                                children:
                                    List.generate(_listproduct.length, (index) {
                                  return Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Card(
                                          child: SingleChildScrollView(
                                              child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
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
                                          Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 0, 0, 0),
                                              child: Text(
                                                  "Name: " +
                                                      _listproduct[index]
                                                          ['name'],
                                                  style:
                                                      TextStyle(fontSize: 20))),
                                          SizedBox(height: 10),
                                          Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 0, 0, 0),
                                              child: Text(
                                                  "Type: " +
                                                      _listproduct[index]
                                                          ['type'],
                                                  style:
                                                      TextStyle(fontSize: 20))),
                                          SizedBox(height: 10),
                                          Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 0, 0, 0),
                                              child: Text(
                                                  "Price:RM " +
                                                      _listproduct[index]
                                                          ['price'],
                                                  style:
                                                      TextStyle(fontSize: 20))),
                                          SizedBox(height: 10),
                                          Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 0, 0, 0),
                                              child: Text(
                                                  "Quantity: " +
                                                      _listproduct[index]
                                                          ['quantity'],
                                                  style:
                                                      TextStyle(fontSize: 20))),
                                        ],
                                      ))));
                                }))),
                      )
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

  void _loadproduct() {
    http.post(
        Uri.parse("https://crimsonwebs.com/s270737/myshop/php/loadproduct.php"),
        body: {}).then((response) {
      print(response.body);
      if (response.body == "nodata") {
        titlecenter = "Sorry no product";
        return;
      } else {
        var jsondata = json.decode(response.body);
        _listproduct = jsondata["products"];
        setState(() {});
        print(_listproduct);
      }
    });
  }
}
