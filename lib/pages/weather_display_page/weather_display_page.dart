import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapidemo/bloc/weather_bloc.dart';
import 'package:weatherapidemo/bloc/weather_event.dart';
import 'package:weatherapidemo/bloc/weather_state.dart';
import 'package:weatherapidemo/data/cities_names_extractor.dart';
import 'package:weatherapidemo/data/open_weather_api_client.dart';
import 'package:weatherapidemo/model/weather.dart';

import 'package:flutter/material.dart';
import 'package:weatherapidemo/pages/weather_display_page/city_select_widget.dart';


class OpenDemoApiPage extends StatefulWidget {
  @override
  _OpenDemoApiPageState createState() => _OpenDemoApiPageState();
}

class _OpenDemoApiPageState extends State<OpenDemoApiPage> {

  OpenWeatherApiClient client = new OpenWeatherApiClient( );


  @override
  Widget build( BuildContext context ) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text( 'Open Weather Api Demo',
            style: TextStyle( color: Colors.black54 ), ),
        ),
        body: BlocBuilder<WeatherBloc, WeatherState>(
            builder: ( context, state ) {
              if (state is WeatherInitial) {
                return Padding(
                    padding: EdgeInsets.all( 16.0 ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SelectCityTopWidget(
                          onCitySelected: (selectedCityId){
                            BlocProvider.of<WeatherBloc>(context)
                              .add(FetchWeather(cityId: selectedCityId));},
                        ),
                        Text( 'Температура: ? C' ),
                        Text( 'Облачность: ? %' ),
                        Text( 'Давление: ? мм рт.ст' ),
                        Text( 'Влажность: ? %' ),
                      ],
                    ) );
              }
              if (state is WeatherLoading) {
                return Center( child: CircularProgressIndicator( ) );
              }
              if (state is WeatherLoaded) {
                return Padding(
                    padding: EdgeInsets.all( 16.0 ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SelectCityTopWidget(
                          onCitySelected: (selectedCityId){
                            print('УРА БЛЯТЬ, функция передалась в блок');
                            BlocProvider.of<WeatherBloc>(context)
                                .add(FetchWeather(cityId: selectedCityId));},
                        ),
                        Text( 'Температура:${state.weather.temperature} C' ),
                        Text( 'Облачность: ${state.weather.clouds} %' ),
                        Text( 'Давление: ${state.weather.pressure} мм рт.ст' ),
                        Text( 'Влажность: ${state.weather.humidity} %' ),
                      ],
                    ) );
              }
              if (state is WeatherError) {
                return Text(
                  'Где-то проёбка с погодой!\n${state.errorMsg}',
                  style: TextStyle( color: Colors.red ),
                );
              }
              return null;
            }
        ) );
  }


}