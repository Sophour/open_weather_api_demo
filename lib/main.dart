import 'package:flutter/material.dart';
import 'package:weatherapidemo/pages/weather_display_page/weather_display_page.dart';
import 'package:weatherapidemo/simple_bloc_delegate.dart';
import 'data/open_weather_api_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapidemo/bloc/weather_bloc.dart';


main(){
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(OpenWeatherApiDemoApp());
}


class OpenWeatherApiDemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Open Weather Api Demo',
      theme: ThemeData.light(),
      home:  BlocProvider(
        create: (context) => WeatherBloc(OpenWeatherApiClient()),
        child: OpenDemoApiPage(),
      ),

    );
  }
}
