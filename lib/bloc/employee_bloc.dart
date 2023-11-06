import 'package:employee_list_assessment/models/employee.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, List<Employee>> {
  EmployeeBloc() : super([]) {
    on<AddEmployeeEvent>(addEmployee);
  }

  List<Employee> _employees = [];

  void addEmployee(AddEmployeeEvent event, Emitter emit) {
    // add to db
    _employees.add(event.employee);
    emit(_employees);
  }

}

abstract class EmployeeEvent {}
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