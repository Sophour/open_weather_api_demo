import 'package:meta/meta.dart';
class WeatherEvent{
}

class FetchWeather extends WeatherEvent{
  final int cityId;
  final String cityName;

  FetchWeather({@required this.cityId, @required this.cityName});
}
//TODO add RefreshWeather