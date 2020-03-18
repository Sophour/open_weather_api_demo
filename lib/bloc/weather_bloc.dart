import 'package:bloc/bloc.dart';
import 'package:weatherapidemo/data/open_weather_api_client.dart';
import 'package:weatherapidemo/model/weather.dart';
import 'package:meta/meta.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final OpenWeatherApiClient _client;

  WeatherBloc(this._client);

  @override
  WeatherState get initialState => WeatherInitial();

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {

    if (event is FetchWeatherEvent) {
      yield WeatherLoading();
      try {
        final Weather weather = await _client.getCurrentWeather(event.cityId, event.cityName);
        yield WeatherLoaded(weather: weather);
      } catch (errMsg) {
        yield WeatherError(errMsg.toString());
      }
    }
    else if (event is ClearWeatherEvent)
      yield WeatherInitial();
  }

}

///Events
class WeatherEvent{
}

class FetchWeatherEvent extends WeatherEvent{
  final int cityId;
  final String cityName;

  FetchWeatherEvent({@required this.cityId, @required this.cityName});
}

class ClearWeatherEvent extends WeatherEvent{}

///States
abstract class WeatherState{}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherError extends WeatherState {
  final String errorMsg;

  WeatherError(this.errorMsg);
}

class WeatherLoaded extends WeatherState {
  final Weather weather;

  WeatherLoaded( {@required this.weather} );
}