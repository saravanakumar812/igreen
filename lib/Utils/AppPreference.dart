import 'package:get_storage/get_storage.dart';

class AppPreference {
  static const STORAGE_NAME = 'igreen';
  final _storage = GetStorage(STORAGE_NAME);

  Future<void> init() async {
    await _storage.initStorage;
  }

  static const empId = 'EmployeeId';
  static const empName = 'EmployeeName';
  static const mobNumber = 'MobileNum';
  static const depId = 'DepartmentId';
  static const attendanceValueId = 'AttendanceId';

  updateEmpId(int employeeId) {
    _storage.write(empId, employeeId);
  }

  int get getEmpId {
    try {
      return _storage.read(empId);
    } catch (e) {
      return 0;
    }
  }

  updateDepId(int departmentId) {
    _storage.write(depId, departmentId);
  }

  int get getDepId {
    try {
      return _storage.read(depId);
    } catch (e) {
      return 0;
    }
  }

  updateEmpName(String employeeName) {
    _storage.write(empName, employeeName);
  }

  String get getEmpName {
    try {
      return _storage.read(empName);
    } catch (e) {
      return '';
    }
  }

  updateMobileNumber(String mobileNumber) {
    _storage.write(mobNumber, mobileNumber);
  }

  String get getMobileNumber {
    try {
      return _storage.read(mobNumber);
    } catch (e) {
      return '';
    }
  }

  updateAttendanceId(String attendanceID) {
    _storage.write(attendanceValueId, attendanceID);
  }

  String get getAttendanceId {
    try {
      return _storage.read(attendanceValueId);
    } catch (e) {
      return '';
    }
  }

  clearData() {
    _storage.erase();
  }
}
