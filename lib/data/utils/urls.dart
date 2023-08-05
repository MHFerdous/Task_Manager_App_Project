class Urls {
  Urls._();
  static const String _baseUrl = 'https://task.teamrabbil.com/api/v1';
  static String registration = '$_baseUrl/registration';
  static String login = '$_baseUrl/login';
  static String createTask = '$_baseUrl/createTask';
  static String taskStatusCount = '$_baseUrl/taskStatusCount';
  static String newTask = '$_baseUrl/listTaskByStatus/New';
  static String inProgressTask = '$_baseUrl/ListTaskByStatus/Progress';
  static String cancelledTask = '$_baseUrl/ListTaskByStatus/Cancelled';
  static String completedTask = '$_baseUrl/ListTaskByStatus/Complete';
  static String deleteTask(String id) => '$_baseUrl/deleteTask/$id';
  static String emailVerification(String email) =>
      '$_baseUrl/ListTaskByStatus/RecoverVerifyEmail/rabbilidlc@gmail.com';
  static String updateTask(String id, String status) =>
      '$_baseUrl/updateTaskStatus/$id/$status';
}
