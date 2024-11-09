import 'package:dropdown_pro/dropdown_pro.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dropdown Pro Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(),
    );
  }
}

class ItemModel implements DropdownModel {
  final String label;
  ItemModel(this.label);

  @override
  String get title => label;
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Sample data for the dropdown
  List<String> items = [
    'Item 1',
    'Item 2',
    'Item 3',
  ];

  String? selectedItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dropdown Pro Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            DropdownPro<String>(
              itemsList: items,
              enableSearch: true,
              onChanged: (item) {
                setState(() {
                  selectedItem = item;
                });
              },
            ),
            const SizedBox(height: 20),
            // Text(
            //   selectedItem == null
            //       ? 'No item selected'
            //       : 'Selected Item: ${selectedItem?.title}',
            //   style: const TextStyle(fontSize: 16),
            // ),
          ],
        ),
      ),
    );
  }
}
