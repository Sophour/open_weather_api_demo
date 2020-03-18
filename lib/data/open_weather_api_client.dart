import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:weatherapidemo/model/weather.dart';

class OpenWeatherApiClient{

  //TODO hide key
  final _APIKEY = '9b794803e4f2e2eb52db008b599847b6';
  static const baseUrl = 'http://api.openweathermap.org/data/2.5/weather?';


  Future<Weather> getCurrentWeather(int cityId, String cityName) async{
    //units=metric - Celsius
    var response = await http.get('${baseUrl}id=$cityId&APPID=$_APIKEY&units=metric');

  if (response.statusCode == 200) {

    var parsedJson = jsonDecode( response.body );

    Weather currentWeather = Weather(
        parsedJson['clouds']['all'],
        parsedJson['main']['pressure'],
        parsedJson['main']['humidity'],
        parsedJson['main']['temp'],
        cityName);

    if(currentWeather == null
        || currentWeather.temperature == null
        || currentWeather.clouds == null
        || currentWeather.humidity == null
        || currentWeather.pressure == null
        || currentWeather.cityName == null)
      _handleBadWeatherMapping(currentWeather, response);

    return currentWeather;
  }
  else{
     _handleBadStatusCode(response);
  }

  }

  _handleBadStatusCode(http.Response response){
    String reason;

      if( response.statusCode>=500)
        reason = 'Ошибка сервера';
      else if( response.statusCode>=400)
        reason = 'Ошибка клиента';
      else if( response.statusCode>=300)
        reason = 'Запрос перенаправлен';
      else
        reason = 'Неизвестно';

    throw ('Ошибка запроса! Причина: $reason ,  ${response.reasonPhrase}');

  }

   _handleBadWeatherMapping(Weather currentWeather, http.Response response) {
     throw ('Ошибка формата данных погоды! Имеющиеся данные: '
         '$currentWeather . Данные с сервера: ${response.body}');
   }

}