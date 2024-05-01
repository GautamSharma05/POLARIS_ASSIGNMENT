import 'package:dio/dio.dart';
import 'package:polaris/module/form/model/form_model.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'api_network.g.dart';


const String baseUrl = "https://chatbot-api.grampower.com/";

@RestApi(baseUrl: baseUrl)
abstract class RestClient {
  factory RestClient(Dio dio) = _RestClient;


  @GET('flutter-assignment')
  Future<FormModel> getFormUi();

  @POST('flutter-assignment/push')
  Future<dynamic> submitForm(@Body() body);
}