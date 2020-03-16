
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:weatherapidemo/model/weather.dart';

class OpenWeatherApiClient{

  final _APIKEY = '9b794803e4f2e2eb52db008b599847b6';
  static const baseUrl = 'http://api.openweathermap.org/data/2.5/weather?';

//  final http.Client httpClient;
//
//  OpenWeatherApiClient({
//    @required this.httpClient,
//  }) : assert(httpClient != null);

  Future<Weather> getCurrentWeather(int cityId) async{
    //units=metric - Celsius
    var response = await http.get('${baseUrl}id=$cityId&APPID=$_APIKEY&units=metric');

    //TODO handle exceptions
    if(response.statusCode==200) {
      print( response.body );
      var parsedJson = jsonDecode(response.body);

      return Weather(
        parsedJson['clouds']['all'],
          parsedJson['main']['pressure'],
          parsedJson['main']['humidity'],
          parsedJson['main']['temp'],
          cityId
      );

    }
    return null;
  }

}