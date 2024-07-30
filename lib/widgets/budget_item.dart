import 'package:flutter/material.dart';
import 'package:myapp/models/budget.dart';

class BudgetItem extends StatelessWidget {
  final Budget budget;

  const BudgetItem({super.key, required this.budget});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.category),
        title: Text(budget.title),
        subtitle: Text('Spent: ₹${budget.spent.toStringAsFixed(2)} of ₹${budget.total.toStringAsFixed(2)}'),
        trailing: Icon(Icons.more_vert),
      ),
    );
  }
}