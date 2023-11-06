import 'package:employee_list_assessment/bloc/employee_bloc.dart';
import 'package:employee_list_assessment/constants/app_colors.dart';
import 'package:employee_list_assessment/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => EmployeeBloc())],
      child: MaterialApp(
        title: 'Employee List',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: const AppBarTheme(elevation: 0, centerTitle: false),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(elevation: 0),
          ),
          iconTheme: const IconThemeData(color: AppColors.primaryBlueColor),
          inputDecorationTheme: InputDecorationTheme(
            isDense: true,
            prefixIconColor: AppColors.primaryBlueColor,
            suffixIconColor: AppColors.primaryBlueColor,
            contentPadding: const EdgeInsets.all(8),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: AppColors.outlineGreyColor),
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              backgroundColor: AppColors.accentBlueColor,
              textStyle: const TextStyle(color: AppColors.primaryBlueColor),
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: const HomeScreen(),
      ),
    );
  }
}
