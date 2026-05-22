import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xpense_tracker/bloc/add_expense_bloc/add_expense_bloc.dart';
import 'package:xpense_tracker/bloc/list_expense_bloc/list_expense_bloc.dart';
import 'package:xpense_tracker/presentation/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AddExpenseBloc()),
        BlocProvider(
          create: (context) => ListExpenseBloc(
            addExpenseBloc: context.read<AddExpenseBloc>(),
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
