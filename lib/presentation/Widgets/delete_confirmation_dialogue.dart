import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xpense_tracker/models/expense_model.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  final Expense expense;

  const DeleteConfirmationDialog({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete Expense'),
      content: Text(
        'Are you sure you want to delete "${expense.description}"?',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text(
            'Delete',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}