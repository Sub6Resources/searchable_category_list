import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:searchable_category_list/searchable_category_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SearchableCategoryList Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String _search;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SearchableCategoryList"),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _search = value;
                });
              },
            ),
          ),
          Expanded(
            child: SearchableCategoryList.builder(
              searchQuery: _search,
              itemCount: 120,
              itemBuilder: (context, index) {
                return ListTile(
                  key: Key("Alphabet $index"),
                  title: Text("Alphabet $index"),
                );
              },
              categoryBuilder: (index) {
                if(index < 10)
                  return "A";
                else if(index < 50)
                  return "Z";
                else
                  return "Quail";
              },
              categoryItem: (context, category) {
                return ListTile(
                  dense: true,
                  title: Text(category),
                );
              },
              emptyState: Dialog(child: Text("There is no list...")),
            ),
          ),
        ],
      ),
    );
  }
}
