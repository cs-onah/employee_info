import 'package:employee_list_assessment/constants/app_colors.dart';
import 'package:employee_list_assessment/widgets/date_picker/date_picker.dart';
import 'package:flutter/material.dart';

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({super.key});
  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Employee Details"),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              children: [
                TextFormField(
                  controller: nameController,
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
                TextButton(onPressed: () {}, child: const Text("Cancel")),
                const SizedBox(width: 16),
                ElevatedButton(onPressed: () {}, child: const Text("Save")),
              ],
            ),
          )
        ],
      ),
    );
  }

  void pickStartDate() {
    AppDatePicker.pickDate(context);
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
}
