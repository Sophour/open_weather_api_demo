import 'package:flutter/material.dart';
import 'package:weatherapidemo/bloc/city_selection_bloc.dart';
import 'package:weatherapidemo/pages/weather_display_page/weather_display_page.dart';
import 'package:weatherapidemo/simple_bloc_delegate.dart';
import 'data/open_weather_api_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapidemo/bloc/weather_bloc.dart';

main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(BlocProvider<CitySelectionBloc>(
      create: (context) => CitySelectionBloc(),
      child: OpenWeatherApiDemoApp()));
}

class OpenWeatherApiDemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CitySelectionBloc, CitySelectionState>(
      builder: (context, citySelectionState){
        return MaterialApp(
          title: 'Open Weather Api Demo',
          theme: ThemeData(
            primarySwatch: Colors.grey,
            accentColor: Colors.white,
            highlightColor: Colors.white,
            brightness: Brightness.light,
            backgroundColor: Colors.black38,
            cursorColor: Colors.black38
          ),
          home: BlocProvider(
            create: (context) => WeatherBloc(OpenWeatherApiClient()),
            child: OpenDemoApiPage(),
          ),
        );
      },

    )
;
  }
}
