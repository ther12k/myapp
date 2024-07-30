import 'package:flutter/material.dart';

class BudgetsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Budgets'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total Budget', style: TextStyle(fontSize: 16)),
                    Text('₹700.00',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total Spent', style: TextStyle(fontSize: 16)),
                    Text('₹300.00',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Balance', style: TextStyle(fontSize: 16)),
                    Text('₹400.00',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            LinearProgressIndicator(
              value: 0.6, // Represents 60% used
              backgroundColor: Colors.grey[300],
              color: Colors.blue,
              minHeight: 10,
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('List of budgets',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    // Implement search functionality
                  },
                ),
              ],
            ),
            Expanded(
              child: ListView(
                children: [
                  BudgetItem(title: 'Food', spent: 50, total: 100),
                  BudgetItem(title: 'Home', spent: 50, total: 100),
                  BudgetItem(title: 'Bills', spent: 50, total: 100),
                  BudgetItem(title: 'Beauty', spent: 50, total: 100),
                ],
              ),
            ),
            FloatingActionButton(
              onPressed: () {
                // Navigate to add new budget screen
              },
              child: Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}

class BudgetItem extends StatelessWidget {
  final String title;
  final double spent;
  final double total;

  const BudgetItem({
    Key? key,
    required this.title,
    required this.spent,
    required this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.category),
        title: Text('$title'),
        subtitle: Text('Spent: ₹$spent.00 of ₹$total.00'),
        trailing: Icon(Icons.more_vert),
      ),
    );
  }
}
