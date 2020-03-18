import 'package:weatherapidemo/data/open_weather_api_client.dart';
import 'package:flutter/material.dart';
import 'package:weatherapidemo/widgets/city_selection_widget.dart';
import 'package:weatherapidemo/widgets/weather_bloc_widget.dart';

class OpenDemoApiPage extends StatefulWidget {
  @override
  _OpenDemoApiPageState createState() => _OpenDemoApiPageState();
}

class _OpenDemoApiPageState extends State<OpenDemoApiPage> {
  OpenWeatherApiClient client = new OpenWeatherApiClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black45,
        body:
        Column(
        children: <Widget>[
        CitySelectionWidget(),
        WeatherDisplayWidget(),
      ],
    ),

    );
  }

}


