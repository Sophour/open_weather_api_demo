class Weather{

  static const hPa_to_mmHg_factor = 0.750062; // гектопаскали в миллиметры ртутного столба

  final int clouds;
  final _pressure;
  final int humidity;
  final double temperature;
  final int cityId;
  int get pressure => _pressure != null? ( _pressure * hPa_to_mmHg_factor).round() : 0 ;

  Weather( this.clouds, this._pressure, this.humidity, this.temperature,
      this.cityId);


  getCloudinessStateFromPercent(int percent){
    //TODO case
  }

}