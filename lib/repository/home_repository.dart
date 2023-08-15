
import 'package:mvvm/data/network/base_api_services.dart';
import 'package:mvvm/data/network/network_api_service.dart';
import 'package:mvvm/model/movies_model.dart';
import 'package:mvvm/res/app_urls.dart';

class HomeRepository {

  Future<ProductListModel> fetchMoviesListApi() async{
    BaseApiServices _apiServices= NetworkApiService();

    try{
      dynamic response= await _apiServices.getGetApiResponse(AppUrl.moviesListEndPoint);
      return response = ProductListModel.fromJson(response);
    }
    catch(e){
      throw e ;
    }
  }

}