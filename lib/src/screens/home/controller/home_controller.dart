import 'package:get/get.dart';

import '../../../models/category_model.dart';
import '../../../services/utils_service.dart';
import '../repository/home_repository.dart';
import '../result/home_result.dart';

class HomeController extends GetxController {
  final homeRepoitory = HomeRepository();
  final utilsService = UtilsService();

  bool isLoading = false;

  List<CategoryModel> allCategories = [];

  void setLoading(bool value) {
    isLoading = value;

    update();
  }

  @override
  onInit() {
    super.onInit();
    getAllCategories();
  }

  Future<void> getAllCategories() async {
    setLoading(true);
    HomeResult<CategoryModel> homeResult =
        await homeRepoitory.getAllCategories();
    setLoading(false);

    homeResult.when(
      success: (data) {
        allCategories.assignAll(data);
        print('Todas as categorias: $allCategories');
      },
      error: (message) {
        print('Erro ao carregar a categorias: $message');
        utilsService.showToast(
          message: message,
          isError: true,
        );
      },
    );
  }
}
