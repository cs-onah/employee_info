import 'package:employee_list_assessment/models/employee.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocalStorage {
  static LocalStorage get instance => LocalStorage._();
  factory LocalStorage() => instance;
  LocalStorage._();

  static late Box _employeeBox;

  static Future init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(EmployeeAdapter());
    _employeeBox = await Hive.openBox("EMPLOYEE_BOX");
  }

  Future addEmployee(Employee employee) async {
    await _employeeBox.put(employee.id, employee);
  }
  Future deleteEmployee(Employee employee) async {
    await _employeeBox.delete(employee.id);
  }

  Future clearEmployeeStorage() async => await _employeeBox.clear();

  List<Employee> get employees => _employeeBox.values.cast<Employee>().toList();
}
