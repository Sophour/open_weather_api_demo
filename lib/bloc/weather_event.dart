import 'package:meta/meta.dart';
class WeatherEvent{
}

class FetchWeather extends WeatherEvent{
  final String cityName;

  FetchWeather({@required this.cityName});
}