import 'package:employee_list_assessment/bloc/employee_bloc.dart';
import 'package:employee_list_assessment/constants/app_colors.dart';
import 'package:employee_list_assessment/models/employee.dart';
import 'package:employee_list_assessment/screens/add_employee_screen.dart';
import 'package:employee_list_assessment/screens/employee_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldGreyColor,
      appBar: AppBar(
        title: const Text("Employee List"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const AddEmployeeScreen()),
        ),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<EmployeeBloc, List<Employee>>(
        builder: (context, state) {
          if (state.isNotEmpty) {
            return EmployeeListScreen(employees: state);
          }

          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset("assets/empty_illus.svg"),
                const SizedBox(height: 10),
                const Text("No employee records found"),
              ],
            ),
          );
        },
      ),
    );
  }
}
