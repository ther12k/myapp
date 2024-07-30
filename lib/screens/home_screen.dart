import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SmartTrack'),
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              // Implement menu functionality
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tips to manage budget!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Card(
                color: Colors.blue[100],
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Current Balance: ₹1000.00',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            style:
                                ElevatedButton.styleFrom(backgroundColor: Colors.red),
                            onPressed: () {
                              // Navigate to add expense screen
                            },
                            child: Text('Add Expense'),
                          ),
                          ElevatedButton(
                            style:
                                ElevatedButton.styleFrom(backgroundColor: Colors.green),
                            onPressed: () {
                              // Navigate to add income screen
                            },
                            child: Text('Add Income'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Navigate to Expenditure chart screen
                        },
                        child: Column(
                          children: [
                            Icon(Icons.pie_chart,
                                size: 50, color: Colors.orange),
                            SizedBox(height: 5),
                            Text('Expenditure chart'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/budgets');
                        },
                        child: Column(
                          children: [
                            Icon(Icons.list, size: 50, color: Colors.blue),
                            SizedBox(height: 5),
                            Text('Budgets'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
