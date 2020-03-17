import 'package:bloc/bloc.dart';
import 'package:weatherapidemo/bloc/weather_event.dart';
import 'package:weatherapidemo/bloc/weather_state.dart';
import 'package:weatherapidemo/data/open_weather_api_client.dart';
import 'package:weatherapidemo/model/weather.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final OpenWeatherApiClient _client;

  WeatherBloc(this._client);

  @override
  WeatherState get initialState => WeatherInitial();

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {

    if (event is FetchWeather) {
      yield WeatherLoading();
      try {
        final Weather weather = await _client.getCurrentWeather(event.cityId);
        yield WeatherLoaded(weather: weather);
      } catch (errMsg) {
        yield WeatherError(errMsg.toString());
      }
    }
  }


}