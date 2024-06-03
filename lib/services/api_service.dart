import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/plan.dart';
import '../models/note.dart';

class ApiService {
  static const String baseUrl =
      'https://plan-336c2-default-rtdb.firebaseio.com/'; // Replace with your API URL

  static Future<void> savePlan(Plan plan) async {
    final response = await http.post(
      Uri.parse('$baseUrl/plans.json'),
      body: json.encode(plan.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to save plan');
    }
  }

  static Future<void> saveNote(Note note) async {
    final response = await http.post(
      Uri.parse('$baseUrl/notes.json'),
      body: json.encode(note.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to save note');
    }
  }

  static Future<void> deletePlan(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/plans/$id.json'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete plan');
    }
  }

  static Future<void> deleteNote(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/notes/$id.json'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete note');
    }
  }
}
