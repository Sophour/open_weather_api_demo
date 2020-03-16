class Weather{

  static const hPa_to_mmHg_factor = 0.750062; // гектопаскали в миллиметры ртутного столба

  final  clouds;
  final _pressure;
  final humidity;
  final temperature;
  final  cityId;
  int get pressure => _pressure != null? ( _pressure * hPa_to_mmHg_factor).round() : '' ;

  Weather( this.clouds, this._pressure, this.humidity, this.temperature,
      this.cityId);


  getCloudinessStateFromPercent(int percent){
    //TODO case
  }

}
//
//enum WeatherCondition {
//  snow,
//  sleet,
//  hail,
//  thunderstorm,
//  heavyRain,
//  lightRain,
//  showers,
//  heavyCloud,
//  lightCloud,
//  clear,
//  unknown
//}