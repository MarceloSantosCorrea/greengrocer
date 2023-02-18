import '../../../constants/endpoints.dart';
import '../../../models/category_model.dart';
import '../../../services/http_manager.dart';
import '../result/home_result.dart';

class HomeRepository {
  final _httpManager = HttpManager();

  getAllCategories() async {
    final result = await _httpManager.restRequest(
      url: Endpoints.getAllCategories,
      method: HttpMethods.get,
    );

    if (result['result'] != null) {
      List<CategoryModel> data =
          (result['result'] as List<Map<String, dynamic>>)
              .map(CategoryModel.fronJson)
              .toList();

      return HomeResult<CategoryModel>.success(data);
    } else {
      return HomeResult.error(
          'Ocorreu um erro inesperado ao recuperar as categorias.');
    }
  }
}
