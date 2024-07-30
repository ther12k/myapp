// lib/widgets/transaction_item.dart
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;

  const TransactionItem({Key? key, required this.transaction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: transaction.color.withOpacity(0.2),
          child: Icon(transaction.icon, color: transaction.color),
        ),
        title: Text(transaction.title),
        subtitle: Text(DateFormat('MMM d, yyyy').format(transaction.date)),
        trailing: Text(
          '${transaction.amount >= 0 ? '+' : ''}₹${transaction.amount.abs().toStringAsFixed(2)}',
          style: TextStyle(
            color: transaction.amount >= 0 ? Colors.green : Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
