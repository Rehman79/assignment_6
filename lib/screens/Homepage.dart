import 'package:flutter/material.dart';

import '../Model/Animal_list.dart';
import 'addanimal.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<String> _animalNames = [
    'Lion',
    'Tiger',
    'Elephant',
    'Giraffe',
    'Zebra',
    'Leopard',
    'Cheetah',
    'Panda',
    'Kangaroo',
    'Gorilla',
  ];

  Widget _buildItem(String animal, Animation<double> animation, int index) {
    return AnimalListItem(
      animal: animal,
      animation: animation,
      onRemove: () => _removeItem(index),
    );
  }

  void _removeItem(int index) {
    final removedItem = _animalNames.removeAt(index);
    _listKey.currentState!.removeItem(
      index,
          (context, animation) => _buildItem(removedItem, animation, index),
      duration: const Duration(milliseconds: 600),
    );
  }

  bool _addItem(String newItem) {
    final lowerCaseNewItem = newItem.toLowerCase();

    if (_animalNames.any((animal) => animal.toLowerCase() == lowerCaseNewItem)) {
      return false;
    }

    final index = _animalNames.length;
    _animalNames.add(newItem);
    _listKey.currentState!.insertItem(index);
    return true;
  }

  void _navigateToAddAnimalPage() async {
    final result = await Navigator.of(context).push<String>(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: AddAnimalPage(onAdd: _addItem),
          );
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);
          return SlideTransition(position: offsetAnimation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animated List of Animals'),
      ),
      body: AnimatedList(
        key: _listKey,
        initialItemCount: _animalNames.length,
        itemBuilder: (context, index, animation) {
          return _buildItem(_animalNames[index], animation, index);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddAnimalPage,
        child: Icon(Icons.add),
      ),
    );
  }
}
