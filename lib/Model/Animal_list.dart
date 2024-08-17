import 'package:flutter/material.dart';

class AnimalListItem extends StatelessWidget {
  final String animal;
  final Animation<double> animation;
  final VoidCallback onRemove;

  AnimalListItem({
    required this.animal,
    required this.animation,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: animation.drive(Tween<Offset>(
        begin: const Offset(-1, 0),
        end: Offset.zero,
      )),
      child: Card(
        child: ListTile(
          title: Text(animal),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: onRemove,
          ),
        ),
      ),
    );
  }
}
