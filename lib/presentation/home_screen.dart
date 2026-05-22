import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:xpense_tracker/bloc/add_expense_bloc/add_expense_bloc.dart';
import 'package:xpense_tracker/cubits/list_expenses/list_expenses_cubit.dart';
import 'package:xpense_tracker/models/expense_model.dart';

import '../cubits/add_expense/add_expense_cubit.dart';
import 'Widgets/delete_confirmation_dialogue.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController amountController = TextEditingController();
    final TextEditingController categoryController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final expenses = context.watch<ListExpensesCubit>().state.expenses;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          expenses.isEmpty
              ? const Expanded(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.receipt_long_outlined,
                          size: 64,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 16),
                        Text(
                          "No expenses yet!",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Tap + to add your first expense",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : ListView.separated(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: expenses.length,
                  itemBuilder: (BuildContext context, int index) {
                    final expense = expenses[index];
                    return Dismissible(
                        key: ValueKey(expense.id),
                        background: showBackGround(0),
                        secondaryBackground: showBackGround(1),
                        confirmDismiss: (direction) async {
                          return await showDialog<bool>(
                            context: context,
                            builder: (context) =>
                                DeleteConfirmationDialog(expense: expense),
                          );
                        },
                        onDismissed: (direction) {
                          context
                              .read<AddExpenseBloc>()
                              .add(RemoveExpenseEvent(expense: expense));
                        },
                        child: ExpenseItemWidget(expense: expense));
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        shape: const CircleBorder(),
        onPressed: () {
          addExpenseSheet(context, amountController, categoryController,
              descriptionController);
        },
        child: const Icon(
          Icons.add,
          size: 35,
          color: Colors.yellow,
        ),
      ),
    );
  }

  Widget showBackGround(int direction) {
    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      color: Colors.red,
      alignment: direction == 0 ? Alignment.centerLeft : Alignment.centerRight,
      child: const Icon(
        Icons.delete,
        size: 30,
        color: Colors.white,
      ),
    );
  }

  Future addExpenseSheet(
      BuildContext context,
      TextEditingController amountController,
      TextEditingController categoryController,
      TextEditingController descriptionController) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 0),
            child: AlertDialog(
              title: const Text(
                "Add your expenses here",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: amountController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Enter amount"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: categoryController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Enter category"),
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
                  ],
                ),
              ),
              actions: [
                Center(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightGreen,
                        shape: const BeveledRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                      onPressed: () {
                        context.read<AddExpenseBloc>().add(NewExpenseAddEvent(
                            amount: amountController.text.trim(),
                            category: categoryController.text.trim(),
                            description: descriptionController.text.trim()));
                        amountController.clear();
                        descriptionController.clear();
                        categoryController.clear();
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Submit",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: Colors.white),
                      )),
                )
              ],
            ),
          );
        });
  }
}

class ExpenseItemWidget extends StatefulWidget {
  final Expense expense;

  const ExpenseItemWidget({super.key, required this.expense});

  @override
  State<ExpenseItemWidget> createState() => _ExpenseItemWidgetState();
}

class _ExpenseItemWidgetState extends State<ExpenseItemWidget> {
  late final TextEditingController amountTextController;
  late final TextEditingController categoryTextController;
  late final TextEditingController descriptionTextController;

  @override
  void initState() {
    super.initState();
    amountTextController = TextEditingController();
    categoryTextController = TextEditingController();
    descriptionTextController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    amountTextController.dispose();
    categoryTextController.dispose();
    descriptionTextController.dispose();
  }

  String formatAmount(String? rawAmount) {
    if (rawAmount == null || rawAmount.isEmpty) return "\$0.00";
    if (rawAmount.startsWith("\$")) {
      return rawAmount;
    }
    return "\$$rawAmount";
  }

  Color getAmountColor(double amount) {
    if (amount >= 1000) return Colors.red;
    if (amount >= 100) return Colors.orangeAccent;
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              bool _error = false;
              descriptionTextController.text = widget.expense.description ?? "";
              amountTextController.text = widget.expense.amount ?? "";
              categoryTextController.text = widget.expense.category ?? "";
              return StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return AlertDialog(
                      title: const Text('Edit Expense'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            keyboardType: TextInputType.number,
                            controller: amountTextController,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Enter amount"),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: categoryTextController,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Enter category"),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: descriptionTextController,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Enter description"),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cancel')),
                        TextButton(
                            onPressed: () {
                              context.read<AddExpenseBloc>().add(
                                  EditExpenseEvent(
                                      id: widget.expense.id,
                                      amount: widget.expense.amount ?? "",
                                      category: widget.expense.category ?? "",
                                      description:
                                          widget.expense.description ?? ""));
                              Navigator.of(context).pop();
                            },
                            child: const Text('Edit')),
                      ]);
                },
              );
            });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: Colors.deepPurple.withOpacity(0.08), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.deepPurple.withOpacity(0.04),
              spreadRadius: 1,
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: Colors.deepPurple.withOpacity(0.06),
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: Lottie.asset(
                  'assets/lottie/coin.json',
                  fit: BoxFit.cover,
                  decoder: (List<int> bytes) {
                    return LottieComposition.decodeZip(
                      bytes,
                      filePicker: (files) {
                        return files.firstWhere(
                          (f) => f.name.endsWith('.json'),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.expense.category ?? "Uncategorized",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.expense.description ?? "",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  formatAmount(widget.expense.amount),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: getAmountColor(
                        double.parse(widget.expense.amount ?? "")),
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.redAccent.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "Expense",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: getAmountColor(
                          double.parse(widget.expense.amount ?? "")),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
