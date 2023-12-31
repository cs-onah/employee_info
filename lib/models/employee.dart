import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';

part 'employee.g.dart';

@HiveType(typeId: 1)
class Employee extends Equatable {
  /// Autogenerated id based on DateTime
  @HiveField(1)
  final int id;
  @HiveField(2)
  final String? employeeName;
  @HiveField(3)
  final String? employeeRole;
  @HiveField(4)
  final DateTime? startDate;
  @HiveField(5)
  final DateTime? endDate;

  const Employee({
    this.employeeName,
    this.employeeRole,
    this.startDate,
    this.endDate,
    required this.id,
  });

  Employee.create({
    this.employeeName,
    this.employeeRole,
    this.startDate,
    this.endDate,
  }) : id = DateTime.now().millisecondsSinceEpoch;

  Employee copyWith({
    String? employeeName,
    String? employeeRole,
    DateTime? startDate,
    DateTime? endDate,
  }) =>
      Employee(
        employeeName: employeeName ?? this.employeeName,
        employeeRole: employeeRole ?? this.employeeRole,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        id: id,
      );

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        employeeName: json["employeeName"],
        employeeRole: json["employeeRole"],
        startDate: json["startDate"] == null
            ? null
            : DateTime.parse(json["startDate"]),
        endDate:
            json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "employeeName": employeeName,
        "employeeRole": employeeRole,
        "startDate": startDate?.toIso8601String(),
        "endDate": endDate?.toIso8601String(),
        "id": id,
      };

  @override
  List<Object?> get props => [id];
}
