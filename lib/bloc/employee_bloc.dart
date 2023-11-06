import 'package:employee_list_assessment/models/employee.dart';
import 'package:employee_list_assessment/services/local_storage_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, List<Employee>> {
  LocalStorage storage = LocalStorage.instance;
  EmployeeBloc() : super([]) {
    on<AddEmployeeEvent>(addEmployee);
    on<EditEmployeeEvent>(editEmployee);
    on<DeleteEmployeeEvent>(deleteEmployee);
    on<FetchEmployeeEvent>(fetchEmployees);

    add(FetchEmployeeEvent()); // Initialize data from local db
  }

  void addEmployee(AddEmployeeEvent event, Emitter emit) async {
    await storage.addEmployee(event.employee);
    add(FetchEmployeeEvent());
  }

  void deleteEmployee(DeleteEmployeeEvent event, Emitter emit) async {
    await storage.deleteEmployee(event.employee);
    add(FetchEmployeeEvent());
  }

  void editEmployee(EditEmployeeEvent event, Emitter emit) async {
    await storage.addEmployee(event.employee);
    add(FetchEmployeeEvent());
  }

  void fetchEmployees(_, Emitter emit) {
    final employees = List.from(storage.employees);
    emit(List<Employee>.from(employees));
  }
}

/// -------------- Employee Events ----------------
abstract class EmployeeEvent {}

class FetchEmployeeEvent extends EmployeeEvent {}

class AddEmployeeEvent extends EmployeeEvent {
  final Employee employee;
  AddEmployeeEvent(this.employee);
}

class EditEmployeeEvent extends EmployeeEvent {
  final Employee employee;
  EditEmployeeEvent(this.employee);
}

class DeleteEmployeeEvent extends EmployeeEvent {
  final Employee employee;
  DeleteEmployeeEvent(this.employee);
}
