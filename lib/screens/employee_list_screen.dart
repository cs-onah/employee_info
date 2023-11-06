import 'package:employee_list_assessment/bloc/employee_bloc.dart';
import 'package:employee_list_assessment/constants/app_colors.dart';
import 'package:employee_list_assessment/models/employee.dart';
import 'package:employee_list_assessment/screens/add_employee_screen.dart';
import 'package:employee_list_assessment/utils/context_extension.dart';
import 'package:employee_list_assessment/utils/date_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeeListScreen extends StatefulWidget {
  final List<Employee> employees;
  const EmployeeListScreen({super.key, required this.employees});

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  /// Employees that do not have end date, or have end dates after today
  List<Employee> get currentEmployees => widget.employees.where((element) {
        return element.endDate == null ||
            element.endDate!.isAfter(DateTime.now());
      }).toList();

  /// Employees that are not in [currentEmployees]
  List<Employee> get prevEmployees => widget.employees
      .where((element) => !currentEmployees.contains(element))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          listSection("Current Employees", currentEmployees),
          listSection("Previous Employees", prevEmployees),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Swipe left to delete",
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget listSection(String title, List<Employee> employees) {
    if (employees.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryBlueColor,
            ),
          ),
        ),
        ...employees.map(
          (employee) {
            return Dismissible(
              confirmDismiss: (direction) async =>
                  direction == DismissDirection.endToStart,
              onDismissed: (direction) {
                if (direction == DismissDirection.endToStart) {
                  context
                      .read<EmployeeBloc>()
                      .add(DeleteEmployeeEvent(employee));
                  context.showMessage("Employee data has been deleted.");
                }
              },
              background: Container(
                color: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Icon(Icons.delete_outline, color: Colors.white),
                  ],
                ),
              ),
              key: Key(employee.id.toString()),
              child: InkWell(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => AddEmployeeScreen(employee: employee),
                  ),
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(color: AppColors.outlineGreyColor),
                    ),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(),
                      Text(
                        employee.employeeName ?? "--",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        employee.employeeRole ?? "--",
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      const SizedBox(height: 6),
                      Builder(builder: (_) {
                        if (employee.startDate != null &&
                            employee.endDate != null) {
                          return Text(
                            "${employee.startDate.dateReadableWithComma} - ${employee.endDate.dateReadableWithComma}",
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          );
                        }

                        return Text(
                          "From ${employee.startDate.dateReadableWithComma}",
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 14),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
