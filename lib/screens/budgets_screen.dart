// lib/screens/budgets_screen.dart
import 'package:flutter/material.dart';
import '../models/budget.dart';
import '../widgets/budget_item.dart';
import 'add_budget_screen.dart';

class BudgetsScreen extends StatefulWidget {
  const BudgetsScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BudgetsScreenState createState() => _BudgetsScreenState();
}

class _BudgetsScreenState extends State<BudgetsScreen> {
  final List<Budget> _budgets = [
    Budget(title: 'Food', spent: 50, total: 100),
    Budget(title: 'Home', spent: 50, total: 100),
    Budget(title: 'Bills', spent: 50, total: 100),
    Budget(title: 'Beauty', spent: 50, total: 100),
  ];

  double get _totalBudget =>
      _budgets.fold(0, (sum, budget) => sum + budget.total);
  double get _totalSpent =>
      _budgets.fold(0, (sum, budget) => sum + budget.spent);
  double get _balance => _totalBudget - _totalSpent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Budgets'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBudgetSummary(),
            const SizedBox(height: 20),
            _buildBudgetList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewBudget,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBudgetSummary() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildSummaryItem('Total Budget', _totalBudget),
            _buildSummaryItem('Total Spent', _totalSpent),
            _buildSummaryItem('Balance', _balance),
          ],
        ),
        const SizedBox(height: 10),
        LinearProgressIndicator(
          value: _totalSpent / _totalBudget,
          backgroundColor: Colors.grey[300],
          color: Colors.blue,
          minHeight: 10,
        ),
      ],
    );
  }

  Widget _buildSummaryItem(String title, double amount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 16)),
        Text('₹${amount.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildBudgetList() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('List of budgets',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  // Implement search functionality
                },
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _budgets.length,
              itemBuilder: (context, index) {
                return BudgetItem(budget: _budgets[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _addNewBudget() async {
    final newBudget = await Navigator.push<Budget>(
      context,
      MaterialPageRoute(builder: (context) => AddBudgetScreen()),
    );
    if (newBudget != null) {
      setState(() {
        _budgets.add(newBudget);
      });
    }
  }
}
