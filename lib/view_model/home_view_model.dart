

import 'package:flutter/cupertino.dart';
import 'package:mvvm/data/response/api_response.dart';
import 'package:mvvm/repository/home_repository.dart';
import 'package:mvvm/model/movies_model.dart';

class HomeViewViewModel with ChangeNotifier{

  final _myRepo= HomeRepository();

  ApiResponse<ProductListModel> productlist = ApiResponse.loading();

  setMoviesList(ApiResponse<ProductListModel> response){
    productlist= response;
    notifyListeners();
  }

  Future<void> fetchMoviesListApi ()async{

    setMoviesList(ApiResponse.loading());

    _myRepo.fetchMoviesListApi().then((value){

      setMoviesList(ApiResponse.completed(value));

    }).onError((error, stackTrace){

      setMoviesList(ApiResponse.error(error.toString()));

    });

  }

}