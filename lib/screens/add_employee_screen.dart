import 'package:employee_list_assessment/bloc/employee_bloc.dart';
import 'package:employee_list_assessment/constants/app_colors.dart';
import 'package:employee_list_assessment/models/employee.dart';
import 'package:employee_list_assessment/utils/context_extension.dart';
import 'package:employee_list_assessment/utils/date_extension.dart';
import 'package:employee_list_assessment/widgets/date_picker/date_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddEmployeeScreen extends StatefulWidget {
  final Employee? employee;
  const AddEmployeeScreen({super.key, this.employee});
  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  @override
  void initState() {
    super.initState();
    populateFields();
  }

  static const employeeRoles = [
    "Product Designer",
    "Flutter Developer",
    "QA Tester",
    "Product Owner",
  ];

  final nameController = TextEditingController();
  final roleController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  DateTime? startDate = DateTime.now();
  DateTime? endDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? "Edit Employee Detail" : "Add Employee Details"),
        automaticallyImplyLeading: false,
        actions: [
          if (isEdit)
            IconButton(
              onPressed: () {
                if (widget.employee == null) return;
                context
                    .read<EmployeeBloc>()
                    .add(DeleteEmployeeEvent(widget.employee!));
                context.showMessage("Employee data has been deleted.");
                context.pop();
              },
              icon: const Icon(Icons.delete),
            ),
        ],
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                children: [
                  TextFormField(
                    controller: nameController,
                    validator: (value) => value!.isEmpty ? "Enter name" : null,
                    decoration: const InputDecoration(
                      hintText: "Employee name",
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                  ),
                  const SizedBox(height: 23),
                  TextFormField(
                    readOnly: true,
                    controller: roleController,
                    onTap: selectEmployeeRole,
                    validator: (value) => value!.isEmpty ? "Select role" : null,
                    decoration: const InputDecoration(
                      hintText: "Select role",
                      prefixIcon: Icon(Icons.work_outline),
                      suffixIcon: Icon(Icons.arrow_drop_down),
                    ),
                  ),
                  const SizedBox(height: 23),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: startDateController,
                          readOnly: true,
                          onTap: pickStartDate,
                          // validator: (value) =>
                          //     value!.isEmpty ? "Select start date" : null,
                          decoration: const InputDecoration(
                            hintText: "Today",
                            prefixIcon: Icon(Icons.event_outlined),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Icon(Icons.arrow_forward),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: endDateController,
                          readOnly: true,
                          onTap: pickEndDate,
                          decoration: const InputDecoration(
                            hintText: "No date",
                            prefixIcon: Icon(Icons.event_outlined),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 23),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: AppColors.outlineGreyColor),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: Navigator.of(context).pop,
                    child: const Text("Cancel"),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(onPressed: submit, child: const Text("Save")),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void submit() async {
    if (!formKey.currentState!.validate()) return;
    if (startDate == null) {
      context.showErrorSnackBar("Please select a start date");
      return;
    }
    if (endDate != null && !(endDate!.isAfter(startDate!))) {
      context.showErrorSnackBar("End date must be after start date");
      return;
    }

    final bloc = context.read<EmployeeBloc>();
    if (isEdit) {
      int employeeId = widget.employee!.id;
      final employee = Employee(
        id: employeeId,
        employeeName: nameController.text,
        employeeRole: roleController.text,
        startDate: startDate,
        endDate: endDate,
      );
      bloc.add(EditEmployeeEvent(employee));
      context.showMessage("Employee data updated");
    } else {
      final employee = Employee.create(
        employeeName: nameController.text,
        employeeRole: roleController.text,
        startDate: startDate,
        endDate: endDate,
      );
      bloc.add(AddEmployeeEvent(employee));
      context.showMessage("Employee data added.");
    }
    Navigator.of(context).pop();
  }

  void pickStartDate() async {
    final startDate = await showAppDatePicker(
      context,
      pickerOption: PickerOption.full,
      initialDate: this.startDate ?? DateTime.now(),
    );
    if (startDate != null) {
      this.startDate = startDate;
      startDateController.text = textFromDate(startDate);
    }
  }

  void pickEndDate() async {
    final endDate = await showAppDatePicker(
      context,
      pickerOption: PickerOption.limited,
      initialDate: this.endDate,
    );
    this.endDate = endDate;
    endDateController.text = textFromDate(endDate);
  }

  String textFromDate(DateTime? date) {
    if (date == null) return "";
    if (date.isSameDay(DateTime.now())) {
      return "Today";
    } else {
      return date.dateReadable;
    }
  }

  void selectEmployeeRole() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: employeeRoles.map(
          (role) {
            return InkWell(
              onTap: () {
                roleController.text = role;
                Navigator.of(context).pop();
              },
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: AppColors.outlineGreyColor),
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(role, style: const TextStyle(fontSize: 16)),
                  ),
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }

  bool get isEdit => widget.employee != null;

  void populateFields() {
    if (widget.employee == null) return;
    nameController.text = widget.employee?.employeeName ?? "";
    roleController.text = widget.employee?.employeeRole ?? "";
    final employeeStartDate = widget.employee?.startDate;
    if (employeeStartDate != null) {
      startDate = employeeStartDate;
      startDateController.text = textFromDate(employeeStartDate);
    }
    final employeeEndDate = widget.employee?.endDate;
    if (employeeEndDate != null) {
      endDate = employeeEndDate;
      endDateController.text = textFromDate(employeeEndDate);
    }
  }
}
