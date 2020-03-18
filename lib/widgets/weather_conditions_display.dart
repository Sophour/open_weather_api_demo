import 'package:flutter/material.dart';
import 'package:weatherapidemo/model/weather.dart';
import 'package:weatherapidemo/utils/weather_icon_mapper.dart';

Color _weatherColorAccent = Colors.white70;

class WeatherConditionsDisplay extends StatelessWidget {

  final Weather weather;
  const WeatherConditionsDisplay({Key key, this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
//TODO fix неудовлетворительная обработка слишком длинных названий городов
        Text(weather.cityName.toUpperCase(),
          softWrap: false,
          overflow: TextOverflow.fade,
          style: TextStyle(
            fontWeight: FontWeight.w600,
          fontSize: 34.0,
          letterSpacing: 5.0,
          color: Colors.white,
          ),),
        CloudinessDisplay(cloudinessInPercent: weather.clouds,),
        Text(
          '${(this.weather.temperature).round()}C°',
          style: TextStyle(
              fontSize: 100,
              fontWeight: FontWeight.w100,
              color: _weatherColorAccent),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          ValueTile("мм рт.ст",
              '${this.weather.pressure}',
          iconData: WeatherIcons.barometer,),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Center(
                child: Container(
              width: 1,
              height: 50,
              color:
                  _weatherColorAccent.withAlpha(50),
            )),
          ),
          ValueTile("влажность",
              '${this.weather.humidity}',
          iconData: WeatherIcons.humidity,),
        ]),
      ],
    );
  }
}

class ValueTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData iconData;

  ValueTile(this.label, this.value, {this.iconData});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          this.value,
          style:
          TextStyle(color: _weatherColorAccent, fontSize: 34.0),
        ),
        Text(
          this.label,
          style: TextStyle(
              color: _weatherColorAccent
                  .withAlpha(80)),
        ),
        Container(
            child: this.iconData != null
                ? Icon(
              iconData,
              color: _weatherColorAccent,
              size: 30,

            )
                : Container(),
        ),
      ],
    );
  }
}

/// Определяет внешний вид иконки облачности
/// в завиимости от полученного с сервера значения
class CloudinessDisplay extends StatelessWidget {

  final int cloudinessInPercent;

  const CloudinessDisplay({Key key, this.cloudinessInPercent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(WeatherIcons.mapCloudinessInPercentToText(cloudinessInPercent),
          style: TextStyle(color: _weatherColorAccent),),
        Padding(
          padding: EdgeInsets.only(top: 10.0, bottom: 20.0),
          child: Icon(
            WeatherIcons.mapCloudinessInPercentToIcon(cloudinessInPercent),
            color: Colors.white,
            size: 70,

          ),
        ),
      ],
    );
  }
}

