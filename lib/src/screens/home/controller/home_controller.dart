import 'package:get/get.dart';

import '../../../models/category_model.dart';
import '../../../models/item_model.dart';
import '../../../services/utils_service.dart';
import '../repository/home_repository.dart';
import '../result/home_result.dart';

const int itemsPerPage = 6;

class HomeController extends GetxController {
  final homeRepoitory = HomeRepository();
  final utilsService = UtilsService();

  bool isLoading = false;
  List<CategoryModel> allCategories = [];
  CategoryModel? currentCategory;

  List<ItemModel> allProducts = [];

  void setLoading(bool value) {
    isLoading = value;

    update();
  }

  @override
  void onInit() {
    super.onInit();
    getAllCategories();
  }

  void selectCategory(CategoryModel category) {
    currentCategory = category;
    update();
    getAllProducts();
  }

  Future<void> getAllCategories() async {
    setLoading(true);
    HomeResult<CategoryModel> homeResult =
        await homeRepoitory.getAllCategories();
    setLoading(false);

    homeResult.when(
      success: (data) {
        allCategories.assignAll(data);
        if (allCategories.isEmpty) return;
        selectCategory(allCategories.first);
      },
      error: (message) {
        utilsService.showToast(
          message: message,
          isError: true,
        );
      },
    );
  }

  Future<void> getAllProducts() async {
    setLoading(true);
    Map<String, dynamic> body = {
      'page': currentCategory!.pagination,
      // 'title': null,
      'categoryId': currentCategory!.id,
      'itemsPerPage': itemsPerPage,
    };
    HomeResult<ItemModel> homeResult = await homeRepoitory.getAllProducts(body);
    setLoading(false);

    homeResult.when(
      success: (data) {
        print(data);
        allProducts.assignAll(data);
        if (allProducts.isEmpty) return;
      },
      error: (message) {
        utilsService.showToast(
          message: message,
          isError: true,
        );
      },
    );
  }
}
