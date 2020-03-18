import 'package:flutter/material.dart';

class _IconData extends IconData {
  const _IconData(int codePoint)
      : super(
          codePoint,
          fontFamily: 'WeatherIcons',
        );
}
/// Exposes specific weather icons
/// Has all weather conditions specified by open weather maps API
/// https://openweathermap.org/weather-conditions
// hex values and ttf file from https://erikflowers.github.io/weather-icons/
class WeatherIcons {

   static const IconData no_clouds = const _IconData(0xf00d);
  static const IconData light_clouds = const _IconData(0xf00c);
  static const IconData medium_clouds = const _IconData(0xf002);
  static const IconData heavy_clouds = const _IconData(0xf013);
  static const IconData humidity = const _IconData(0xf07a);
  static const IconData barometer = const _IconData(0xf079);
  static const IconData app_icon = const _IconData(0xf003);


   static IconData mapCloudinessInPercentToIcon(int cloudiness){
     if(cloudiness >= 95)  return WeatherIcons.heavy_clouds;
       else if(cloudiness >= 40) return WeatherIcons.medium_clouds;
       else if(cloudiness >= 1) return WeatherIcons.light_clouds;
       else if(cloudiness == 0) return WeatherIcons.no_clouds;

   }

   static String mapCloudinessInPercentToText(int cloudiness){
     if(cloudiness >= 95)  return 'повышенная облачность';
       else if(cloudiness >= 40) return 'средняя облачность';
       else if(cloudiness >= 1) return 'низкая облачность';
       else if(cloudiness == 0) return 'ясно';

   }
}
