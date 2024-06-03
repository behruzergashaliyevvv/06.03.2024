import 'package:flutter/foundation.dart';

class Note {
  final String id;
  final String productName;
  final double price;
  final int amount;

  Note({
    required this.id,
    required this.productName,
    required this.price,
    required this.amount,
  });
}

class NoteController with ChangeNotifier {
  List<Note> _notes = [];

  List<Note> get notes => _notes;

  void addNote(String productName, double price, int amount) {
    final newNote = Note(
      id: DateTime.now().toString(),
      productName: productName,
      price: price,
      amount: amount,
    );
    _notes.add(newNote);
    notifyListeners();
  }

  void deleteNote(String id) {
    _notes.removeWhere((note) => note.id == id);
    notifyListeners();
  }
}
