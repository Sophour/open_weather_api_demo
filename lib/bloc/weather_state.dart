import 'package:meta/meta.dart';
import 'package:weatherapidemo/model/weather.dart';

abstract class WeatherState{}



/// states: initial/clean, citySelection, loading (API call), weatherDisplayed (reload is active & other city can be selected),
///

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherError extends WeatherState {
  final String errorMsg;

  WeatherError(this.errorMsg);
}

class WeatherLoaded extends WeatherState {
  final Weather weather;

   WeatherLoaded({@required this.weather});
}