class Weather{

  static const double hPa_to_mmHg_factor = 0.750062; // гектопаскали в миллиметры ртутного столба

  final int clouds;
  final int _pressure;
  final int humidity;
  final temperature;
  final String cityName;
  int get pressure => _pressure != null? ( _pressure * hPa_to_mmHg_factor).round() : 0 ;

  Weather( this.clouds, this._pressure, this.humidity, this.temperature,
      this.cityName);

}