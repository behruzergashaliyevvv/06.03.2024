import 'package:flutter/foundation.dart';

class Plan {
  final String id;
  final String title;
  final String description;

  Plan({required this.id, required this.title, required this.description});
}

class PlanController with ChangeNotifier {
  List<Plan> _plans = [];

  List<Plan> get plans => _plans;

  void addPlan(String title, String description) {
    final newPlan = Plan(
      id: DateTime.now().toString(),
      title: title,
      description: description,
    );
    _plans.add(newPlan);
    notifyListeners();
  }

  void deletePlan(String id) {
    _plans.removeWhere((plan) => plan.id == id);
    notifyListeners();
  }
  
}
