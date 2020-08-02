import 'package:curativecare/bloc/download_cdm_bloc/download_cdm_progress/download_file_button_event.dart';
import 'package:curativecare/models/download_cdm_model.dart';
import 'package:curativecare/util/api_config.dart';
import 'package:dio/dio.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class GitLabApiClient {

  Future fetchStatesName() async {
    List<String> States = new List();
    BaseOptions options = new BaseOptions(
        connectTimeout: 15 * 1000, // 60 seconds
        receiveTimeout: 15 * 1000 // 60 seconds
    );

    Dio dio = new Dio(options);
    ApiConfig apiConfig=new ApiConfig();
    String url =apiConfig.gitlabApiFetchList+"&per_page=100";
    var response;
    try {
      response = await dio.get(url);
    } on DioError catch (e) {
      if (DioErrorType.RECEIVE_TIMEOUT == e.type ||
          DioErrorType.CONNECT_TIMEOUT == e.type) {
        throw Exception("Please check your internet connection and try again");
      } else if (DioErrorType.DEFAULT == e.type) {
        if (e.message.contains('SocketException')) {
          throw Exception('No Internet Connection');
        }
      } else {
        throw Exception("Problem connecting to the server. Please try again.");
      }
    }

    List<dynamic> responseBody = response.data;
    if (responseBody.length == 0) {
      throw Exception("Problem Connecting to Server, Try Again Later");
    }

    for (int i = 0; i < responseBody.length; i++) {
      Map<String, dynamic> current_hospital = responseBody[i];
      String stateName = current_hospital['name'];
      stateName = stateName.substring(0, stateName.length);
      States.add(stateName);
    }
    return States;
  }

  Future getAvailableCdm(String stateName) async {
    BaseOptions options = new BaseOptions(
        connectTimeout: 15 * 1000, // 60 seconds
        receiveTimeout: 15 * 1000 // 60 seconds
    );

    Dio dio = new Dio(options);

    ApiConfig apiConfig=new ApiConfig();
    String url = apiConfig.gitlabApiFetchList + stateName + "&per_page=100&page=";
    int i = 1;

    var response;
    try {
      response = await dio.get(url + "1");
    } on DioError catch (e) {
      if (DioErrorType.RECEIVE_TIMEOUT == e.type ||
          DioErrorType.CONNECT_TIMEOUT == e.type) {
        throw Exception("Please check your internet connection and try again");
      } else if (DioErrorType.DEFAULT == e.type) {
        if (e.message.contains('SocketException')) {
          throw Exception('No Internet Connection');
        }
      } else {
        throw Exception("Problem connecting to the server. Please try again.");
      }
    }

    var headers = response.headers;
    List<dynamic> responseBody = response.data;
    if (responseBody.length == 0) {
      throw Exception("CDMs Not Available For Your Location");
    }
    // responseBody = responseBody.substring(
    //     responseBody.indexOf("[") + 1, responseBody.lastIndexOf("]"));
    var maxLen = headers["x-total-pages"];
    i++;
    while (i <= int.parse(maxLen[0])) {
      try {
        response = await dio.get(url + i.toString());
      } on DioError catch (e) {
        if (DioErrorType.RECEIVE_TIMEOUT == e.type ||
            DioErrorType.CONNECT_TIMEOUT == e.type) {
          throw Exception(
              "Please check your internet connection and try again");
        } else if (DioErrorType.DEFAULT == e.type) {
          if (e.message.contains('SocketException')) {
            throw Exception('No Internet Connection');
          }
        } else {
          throw Exception(
              "Problem connecting to the server. Please try again.");
        }
      }
      responseBody.addAll(response.data);
      i++;
    }

    return responseBody;
  }

  Future<List<DownloadCdmModel>> parseAvailableCdm(
      List<dynamic> elements) async {
    List<DownloadCdmModel> name = new List();
    for (int i = 0; i < elements.length; i++) {
      Map<String, dynamic> current_hospital = elements[i];
      String hospitalName = current_hospital['name'];
      hospitalName = hospitalName.substring(0, hospitalName.length - 4);
      name.add(DownloadCdmModel(hospitalName, 0));
    }
    return name;
  }

  Future getCSVFileSize( DownloadFileButtonClick event) async {
    String url =
        ApiConfig().gitlabApiGetCDMFileSize +
            "%2F${event.stateName}%2F${event.hospitalName}" +
            ".csv" +
            "?ref=branch-with-data";

    BaseOptions options = new BaseOptions(
        connectTimeout: 15 * 1000, // 60 seconds
        receiveTimeout: 15 * 1000 // 60 seconds
        );
    Dio dio = new Dio(options);

    try {
      var response = await dio.head(url);
      Headers map = response.headers;
      double total = double.parse(map.value('x-gitlab-size'));
      return total;
    } on DioError catch (e) {
      if (DioErrorType.RECEIVE_TIMEOUT == e.type ||
          DioErrorType.CONNECT_TIMEOUT == e.type) {
        throw Exception("Please check your internet connection and try again");
      } else if (DioErrorType.DEFAULT == e.type) {
        if (e.message.contains('SocketException')) {
          throw Exception('Please check your internet connection and try again');
        }
      } else {
        throw Exception("Problem connecting to the server. Please try again.");
      }
    }
  }

  Future downloadCSVFile(
      DownloadFileButtonClick event) async {

    String  url =ApiConfig().downloadCDMApi + "/${event.stateName}/${event.hospitalName}" + ".csv";
    Stream<FileResponse> fileStream;
    fileStream = DefaultCacheManager().getFileStream(url, withProgress: true);
    return fileStream;
  }

}
