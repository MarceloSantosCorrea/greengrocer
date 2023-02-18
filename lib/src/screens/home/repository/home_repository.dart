import '../../../constants/endpoints.dart';
import '../../../services/http_manager.dart';

class HomeRepository {
  final _httpManager = HttpManager();

  getAllCategories() async {
    final result = await _httpManager.restRequest(
      url: Endpoints.getAllCategories,
      method: HttpMethods.get,
    );

    if (result['result'] != null) {}
  }
}
