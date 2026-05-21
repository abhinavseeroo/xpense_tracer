import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/add_expense/add_expense_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController amountController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: const Column(
        children: [
          SizedBox(
            height: 20,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        shape: const CircleBorder(),
        onPressed: () {
          addExpenseSheet(context, amountController, descriptionController);
        },
        child: const Icon(
          Icons.add,
          size: 35,
          color: Colors.yellow,
        ),
      ),
    );
  }

  Future addExpenseSheet(
      BuildContext context,
      TextEditingController amountController,
      TextEditingController descriptionController) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: AlertDialog(
              title: const Text(
                "Add your expenses here",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 15,vertical: 40),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: amountController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: "Enter amount"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter description"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightGreen,
                        shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                      ),
                      onPressed: () {
                        context.read<AddExpenseCubit>().addExpense(
                            amountController.text.trim(),
                            descriptionController.text.trim());
                      },
                      child: const Text(
                        "Submit",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: Colors.grey),
                      ))
                ],
              ),
            ),
          );
        });
  }
}
