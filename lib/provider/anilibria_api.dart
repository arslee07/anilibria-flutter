import 'package:anilibria/model/title_model.dart';
import 'package:get/get.dart';

const baseUrl = 'http://api.wwnd.space/v2/';

class AnilibriaApi extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = baseUrl;
    httpClient.userAgent = 'curl';
  }

  Future<Response<List<TitleModel>>> getUpdates({
    int limit = 25,
    int after = 0,
  }) async {
    return await get(
      'getUpdates?playlist_type=array&limit=$limit&after=$after',
      decoder: (data) => TitleModel.listFromJson(data),
    );
  }

  Future<Response<List<TitleModel>>> searchTitles({
    required String search,
  }) async {
    return await get(
      'searchTitles?playlist_type=array&search=$search',
      decoder: (data) => TitleModel.listFromJson(data),
    );
  }
}
