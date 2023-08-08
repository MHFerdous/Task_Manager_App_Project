class Urls {
  Urls._();
  static const String _baseUrl = 'https://task.teamrabbil.com/api/v1';
  static String registration = '$_baseUrl/registration';
  static String login = '$_baseUrl/login';
  static String createTask = '$_baseUrl/createTask';
  //static String taskStatusCount = '$_baseUrl/taskStatusCount';
  static String newTask = '$_baseUrl/listTaskByStatus/New';
  static String inProgressTasks = '$_baseUrl/listTaskByStatus/Progress';
  static String cancelledTask = '$_baseUrl/ListTaskByStatus/Cancelled';
  static String completedTask = '$_baseUrl/ListTaskByStatus/Completed';
  static String deleteTask(String id) => '$_baseUrl/deleteTask/$id';
  static String updateProfile = '$_baseUrl/profileUpdate';

  static String sendOtpToEmail(String email) =>
      '$_baseUrl/RecoverVerifyEmail/$email';

  static String otpVerify(String email, String otp) =>
      '$_baseUrl/RecoverVerifyOTP/$email/$otp';

  static String resetPassword = '$_baseUrl/RecoverResetPass';

  static String updateTask(String id, String status) =>
      '$_baseUrl/updateTaskStatus/$id/$status';

  static String updateNewTask = '$_baseUrl/listTaskByStatus/New';
  static String updateInProgressTask = '$_baseUrl/listTaskByStatus/Progress';
  static String updateCancelledTask = '$_baseUrl/listTaskByStatus/Cancelled';
  static String updateCompletedTask = '$_baseUrl/listTaskByStatus/Completed';
}

// https://task.teamrabbil.com/api/v1/listTaskByStatus/Progress
