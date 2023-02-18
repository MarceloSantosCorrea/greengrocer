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

  bool isCategoryLoading = false;
  bool isProductLoading = true;
  List<CategoryModel> allCategories = [];
  CategoryModel? currentCategory;

  List<ItemModel> get allProducts => currentCategory?.items ?? [];

  void setLoading(bool value, {bool isProduct = false}) {
    if (!isProduct) {
      isCategoryLoading = value;
    } else {
      isProductLoading = value;
    }

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
    if (currentCategory!.items.isNotEmpty) return;
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
    setLoading(true, isProduct: true);
    Map<String, dynamic> body = {
      'page': currentCategory!.pagination,
      // 'title': null,
      'categoryId': currentCategory!.id,
      'itemsPerPage': itemsPerPage,
    };
    HomeResult<ItemModel> homeResult = await homeRepoitory.getAllProducts(body);
    setLoading(false, isProduct: true);

    homeResult.when(
      success: (data) {
        currentCategory!.items = data;
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
