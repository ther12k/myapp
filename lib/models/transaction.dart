// lib/models/transaction.dart
import 'package:flutter/material.dart';

class Transaction {
  final IconData icon;
  final String title;
  final double amount;
  final DateTime date;
  final Color color;

  Transaction({
    required this.icon,
    required this.title,
    required this.amount,
    required this.date,
    required this.color,
  });
}
