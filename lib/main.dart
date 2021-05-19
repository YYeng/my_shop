import 'package:flutter/material.dart';

void main() => runApp(MyShop());

class MyShop extends StatefulWidget {
  @override
  _MyShopState createState() => _MyShopState();
}

class _MyShopState extends State<MyShop> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My Shop'),
        ),
        body: Center(
          child: Container(
            child: Text('Hello '),
            
          ),
        ),
         floatingActionButton: FloatingActionButton(
            onPressed: () {
              // Add onPressed code here
            
            },
            child: const Icon(Icons.add),
            backgroundColor: Colors.blue,
          ),
      ),
      
    );
  }
}
