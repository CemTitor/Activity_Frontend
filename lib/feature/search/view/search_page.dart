import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage._();

  static Route<String> route() {
    return MaterialPageRoute(builder: (_) => const SearchPage._());
  }

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _textController = TextEditingController();

  String get _text => _textController.text;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('City Search')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(30),
              child: TextField(
                controller: _textController,
                style: const TextStyle(fontSize: 40),
                decoration: const InputDecoration(
                  labelText: 'City',
                  labelStyle: TextStyle(fontSize: 40),
                  hintStyle: TextStyle(fontSize: 40),
                  hintText: 'Bursa',
                ),
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.search,
                semanticLabel: 'Submit',
                color: Colors.blue,
                size: 50,
              ),
              onPressed: () => Navigator.of(context).pop(_text),
            )
          ],
        ),
      ),
    );
  }
}
