
import 'package:flutter/material.dart'; 

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
@override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor, 
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        textTheme: TextTheme(
          headline6: TextStyle(
            fontSize: 32,
            color: Colors.red,
          ),
        ),
        title: Text("Just Chat"),
      ),
    );
  }
}
