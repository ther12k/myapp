import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'SmartTrack',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Card(
                color: Colors.blue[100],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Current balance',
                        style: TextStyle(fontSize: 16, color: Colors.blue[800]),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '₹10,000.00',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[800],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Text('Add Income'),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Text('Add Expense'),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Text(
                'Recent Transactions',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Expanded(
                child: ListView(
                  children: [
                    TransactionItem(
                      icon: Icons.shopping_cart,
                      title: 'Groceries',
                      amount: -500,
                      date: 'Today',
                      color: Colors.orange,
                    ),
                    TransactionItem(
                      icon: Icons.attach_money,
                      title: 'Salary',
                      amount: 50000,
                      date: 'Yesterday',
                      color: Colors.green,
                    ),
                    TransactionItem(
                      icon: Icons.restaurant,
                      title: 'Restaurant',
                      amount: -1200,
                      date: '2 days ago',
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.pie_chart), label: 'Analytics'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet), label: 'Budget'),
        ],
      ),
    );
  }
}

class TransactionItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final double amount;
  final String date;
  final Color color;

  const TransactionItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.amount,
    required this.date,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.2),
          child: Icon(icon, color: color),
        ),
        title: Text(title),
        subtitle: Text(date),
        trailing: Text(
          '${amount >= 0 ? '+' : ''}₹${amount.abs()}',
          style: TextStyle(
            color: amount >= 0 ? Colors.green : Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
