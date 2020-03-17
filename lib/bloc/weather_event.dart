import 'package:meta/meta.dart';
class WeatherEvent{
}

class FetchWeather extends WeatherEvent{
  final int cityId;

  FetchWeather({@required this.cityId});
}