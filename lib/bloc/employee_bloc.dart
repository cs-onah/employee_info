import 'package:employee_list_assessment/models/employee.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, List<Employee>> {
  EmployeeBloc() : super([]) {
    on<AddEmployeeEvent>(addEmployee);
    on<EditEmployeeEvent>(editEmployee);
    on<DeleteEmployeeEvent>(deleteEmployee);
    on<FetchEmployeeEvent>(fetchEmployees);

    add(FetchEmployeeEvent()); // Initialize data from local db
  }

  List<Employee> employees = [];

  void addEmployee(AddEmployeeEvent event, Emitter emit) {
    // add to db
    employees.add(event.employee);
    emit(List<Employee>.from(employees));
  }

  void deleteEmployee(DeleteEmployeeEvent event, Emitter emit) {
    // add to db
    employees.remove(event.employee);
    emit(List<Employee>.from(employees));
  }

  void editEmployee(EditEmployeeEvent event, Emitter emit) {
    // add to db
    employees[employees.indexOf(event.employee)] = event.employee;
    emit(List<Employee>.from(employees));
  }

  void fetchEmployees(_, Emitter emit) {
    // fetch from db
    employees = List.from([]);
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
