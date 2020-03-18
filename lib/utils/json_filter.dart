import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async' show Future;

class JsonFilter {




  // Used this method to filter out unneeded city fields
  // from 9,6MB JSON file provided by Open Weather API
  // and create a slimmer cities_ru.json
  Future<List<City>> _parseLargeJson( ) async {
    List<City> citiesInRussian = new List( );

    List data = json.decode(
        await rootBundle.loadString( 'assets/cities.json' ) );

    // manual deserialization is not recommended but it's quick
    data.forEach( ( v ) {
      if (v['id'] != null && v['langs'] != null) {

        List langsFields = v['langs'];
        langsFields.forEach( ( obj ) {
          if (obj['ru'] != null)
            citiesInRussian.add( new City( v['id'], obj['ru'] ) );
        } );
      }
    } );
    return citiesInRussian;
  }

  serialize( ) async {
    List<City> citiesInRussian = await _parseLargeJson( );
    String resultJson = jsonEncode( citiesInRussian );
  }
}

// PODO for serialization
class City{
  int id;
  String name;
  City( this.id, this.name );

  Map<String,dynamic> toJson(){
    return {
      'id' : this.id,
      'name' : this.name
    };
  }
}