import 'package:get/get.dart';
import 'package:mobile_application/ui/state_managers/add_new_task_controller.dart';
import 'package:mobile_application/ui/state_managers/cancelled_task_controller.dart';
import 'package:mobile_application/ui/state_managers/delete_task_controller.dart';
import 'package:mobile_application/ui/state_managers/login_controller.dart';
import 'package:mobile_application/ui/state_managers/otp_verification_controller.dart';
import 'package:mobile_application/ui/state_managers/reset_password_controller.dart';
import 'package:mobile_application/ui/state_managers/signup_controller.dart';

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LoginController>(
      LoginController(),
    );
    Get.put<SignUpController>(
      SignUpController(),
    );
    Get.put<OtpVerificationController>(
      OtpVerificationController(),
    );
    Get.put<ResetPasswordController>(
      ResetPasswordController(),
    );
    Get.put<AddNewTaskController>(
      AddNewTaskController(),
    );
    Get.put<CancelledTaskController>(
      CancelledTaskController(),
    );
    Get.put<DeleteTaskController>(
      DeleteTaskController(),
    );
  }
}
