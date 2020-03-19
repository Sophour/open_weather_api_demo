import 'package:flutter/services.dart' show rootBundle;
import 'dart:async' show Future;
import 'dart:convert';
import 'dart:collection';


class CitiesNamesExtractor{

// TODO handle exceptions
  Future<LinkedHashMap<String, int>> getCitiesNamesMap() async{

    Map allCities = new LinkedHashMap<String, int>();

    try {
      List citiesInRussian = await _extractCitiesFromJson( );

      citiesInRussian.forEach( ( city ) {
        if (city['id'] != null && city['name'] != null)
          allCities[city['name']] = city['id'];
      } );

      return allCities;
    }catch(err)
    {
      throw(err.toString());
    }
  }

  Future<List> _extractCitiesFromJson( ) async {
    List data = json.decode(
        await rootBundle.loadString( 'assets/cities_ru.json' ) );

    return data;
  }
}