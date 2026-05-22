import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xpense_tracker/cubits/list_expenses/list_expenses_cubit.dart';
import 'package:xpense_tracker/presentation/splash_screen.dart';

import 'cubits/add_expense/add_expense_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AddExpenseCubit()),
        BlocProvider(
          create: (context) => ListExpensesCubit(
            addExpenseCubit: context.read<AddExpenseCubit>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Xpense tracer',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
