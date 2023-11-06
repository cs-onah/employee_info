// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EmployeeAdapter extends TypeAdapter<Employee> {
  @override
  final int typeId = 1;

  @override
  Employee read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Employee(
      employeeName: fields[2] as String?,
      employeeRole: fields[3] as String?,
      startDate: fields[4] as DateTime?,
      endDate: fields[5] as DateTime?,
      id: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Employee obj) {
    writer
      ..writeByte(5)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.employeeName)
      ..writeByte(3)
      ..write(obj.employeeRole)
      ..writeByte(4)
      ..write(obj.startDate)
      ..writeByte(5)
      ..write(obj.endDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmployeeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
