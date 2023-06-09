import 'package:get/get.dart';

import '../../../constants/storage_keys.dart';
import '../../../models/user_model.dart';
import '../../../screens_routes/app_screens.dart';
import '../../../services/utils_service.dart';
import '../repository/auth_repository.dart';
import '../result/auth_result.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;

  final authRepository = AuthRepository();
  final utilsService = UtilsService();

  UserModel user = UserModel();

  // @override
  // void onInit() {
  //   super.onInit();
  //   validateToken();
  // }

  Future<void> validateToken() async {
    String? token = await utilsService.getLocalData(key: StorageKeys.token);
    if (token == null) {
      Get.offNamed(ScreensRoutes.signInRoute);
      return;
    }

    AuthResult result = await authRepository.validateToken(token);
    result.when(
      success: (user) {
        this.user = user;
        saveTokenAndProceedToBase();
      },
      error: (message) {},
    );
  }

  Future<void> signOut() async {
    user = UserModel();
    await utilsService.removeLocalData(key: StorageKeys.token);
    Get.offNamed(ScreensRoutes.signInRoute);
  }

  void saveTokenAndProceedToBase() {
    utilsService.saveLocalData(key: StorageKeys.token, data: user.token!);
    Get.offNamed(ScreensRoutes.baseRoute);
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    isLoading.value = true;

    AuthResult result = await authRepository.signIn(
      email: email,
      password: password,
    );

    result.when(
      success: (user) {
        this.user = user;
        saveTokenAndProceedToBase();
      },
      error: (message) {
        utilsService.showToast(
          message: message,
          isError: true,
        );
      },
    );

    isLoading.value = false;
  }

  Future<void> signUp() async {
    isLoading.value = true;
    AuthResult result = await authRepository.signUp(user);

    result.when(
      success: (user) {
        this.user = user;
        saveTokenAndProceedToBase();
      },
      error: (message) {
        utilsService.showToast(
          message: message,
          isError: true,
        );
      },
    );

    isLoading.value = false;
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    isLoading.value = true;
    final result = await authRepository.changePassword(
      email: user.email!,
      token: user.token!,
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
    isLoading.value = false;

    if (result) {
      utilsService.showToast(message: 'A senha foi atualizada com sucesso');
      signOut();
    } else {
      utilsService.showToast(
        message: 'A senha atual está incorreta',
        isError: true,
      );
    }
  }

  Future<void> resetPassword(String email) async {
    await authRepository.resetPassword(email);
  }
}
