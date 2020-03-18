import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapidemo/bloc/weather_bloc.dart';
import 'package:weatherapidemo/bloc/weather_event.dart';
import 'package:weatherapidemo/bloc/weather_state.dart';
import 'package:weatherapidemo/data/open_weather_api_client.dart';

import 'package:flutter/material.dart';
import 'package:weatherapidemo/widgets/city_selection_widget.dart';
import 'package:weatherapidemo/widgets/weather_conditions_display.dart';

class OpenDemoApiPage extends StatefulWidget {
  @override
  _OpenDemoApiPageState createState() => _OpenDemoApiPageState();
}

class _OpenDemoApiPageState extends State<OpenDemoApiPage> {
  OpenWeatherApiClient client = new OpenWeatherApiClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//        appBar: AppBar(
//          title: Text('Open Weather Api Demo'),
//        ),
    backgroundColor: Colors.black45,
        body: BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
          if (state is WeatherInitial) {
//            return Padding(
//                padding: EdgeInsets.all(16.0),
//                child: Column(
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: <Widget>[
                   return SelectCityPage(
                      onCitySelected: (selectedCityId, selectedCityName) {
                        BlocProvider.of<WeatherBloc>(context).add(FetchWeather(
                            cityId: selectedCityId,
                            cityName: selectedCityName));
                      },
                    );
//                    Text('Температура: ? C'),
//                    Text('Облачность: ? %'),
//                    Text('Давление: ? мм рт.ст'),
//                    Text('Влажность: ? %'),
//                  ],
//                ));
          }
          if (state is WeatherLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is WeatherLoaded) {
            return Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SelectCityPage(
                      onCitySelected: (selectedCityId, selectedCityName) {
                        BlocProvider.of<WeatherBloc>(context).add(FetchWeather(
                            cityId: selectedCityId,
                            cityName: selectedCityName));
                      },
                    ),
                    SizedBox(
                      height: 100.0,
                    ),
//                        Text( 'Температура:${state.weather.temperature} C' ),
//                        Text( 'Облачность: ${state.weather.clouds} %' ),
//                        Text( 'Давление: ${state.weather.pressure} мм рт.ст' ),
//                        Text( 'Влажность: ${state.weather.humidity} %' ),
                    WeatherConditionsDisplay(weather: state.weather)
                  ],
                ));
          }
          if (state is WeatherError) {
            return Text(
              'Где-то проёбка с погодой!\n${state.errorMsg}',
              style: TextStyle(color: Colors.red),
            );
          }
          return null;
        }));
  }
}
