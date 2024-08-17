import 'package:flutter/material.dart';

class AddAnimalPage extends StatefulWidget {
  final Function(String) onAdd;

  AddAnimalPage({required this.onAdd});

  @override
  _AddAnimalPageState createState() => _AddAnimalPageState();
}

class _AddAnimalPageState extends State<AddAnimalPage> {
  final TextEditingController _controller = TextEditingController();

  void _submit() {
    final newItem = _controller.text.trim();

    if (newItem.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Animal name cannot be empty')),
      );
      return;
    }

    if (widget.onAdd(newItem)) {
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Animal name already exists')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Animal'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Animal Name'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submit,
              child: Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
