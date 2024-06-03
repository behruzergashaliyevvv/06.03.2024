import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/plan_controller.dart';
import '../controllers/note_controller.dart';

class StatisticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final planController = Provider.of<PlanController>(context);
    final noteController = Provider.of<NoteController>(context);

    final int totalPlans = planController.plans.length;
    final int totalNotes = noteController.notes.length;

    return Scaffold(
      appBar: AppBar(title: Text('Statistics')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Plans', style: TextStyle(fontSize: 24)),
            Text('Total Plans: $totalPlans'),
            SizedBox(height: 16),
            Text('Notes', style: TextStyle(fontSize: 24)),
            Text('Total Notes: $totalNotes'),
          ],
        ),
      ),
    );
  }
}
