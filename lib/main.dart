import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'dart:io';

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async' show Future, StreamController;


main()=>runApp(OpenWeatherApiDemoApp());


class OpenWeatherApiDemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Open Weather Api Demo',
      theme: ThemeData.light(),
      home: OpenDemoApiPage(),
    );
  }
}

class OpenDemoApiPage extends StatefulWidget {
  @override
  _OpenDemoApiPageState createState() => _OpenDemoApiPageState();
}

class _OpenDemoApiPageState extends State<OpenDemoApiPage> {

  final _APIKEY = '9b794803e4f2e2eb52db008b599847b6';
  static const hPa_to_mmHg_factor = 0.750062; // гектопоскали в миллиметры ртутного столба

  var _clouds;
  var _pressure;
  var _humidity;
  var _temperature;

  static final Map<int, String> map = {
    0: "zero",
    1: "one",
    2: "two",
    3: "three",
    4: "four",
    5: "five",
    6: "six",
    7: "seven",
    8: "eight",
    9: "nine",
    10: "ten",
    11: "eleven",
    12: "twelve",
    13: "thirteen",
    14: "fourteen",
    15: "fifteen",
  };
  String selectedValue;
  List<DropdownMenuItem> items = new List();

  @override

  void initState() {
    map.keys.forEach((key){
      items.add(DropdownMenuItem(
        child: Text(map[key]),
        value: map[key],
      )
      );
    }
    );
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Open Weather Api Demo', style: TextStyle(color: Colors.black54),),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          SearchableDropdown.single(
            items: items,
            value: selectedValue,
            hint: "Выберите город",
            searchHint: "Выберите город",
            onChanged: (value) {
              setState(() {
                selectedValue = value;
              });
            },
            isExpanded: true,
          ),

          RaisedButton(
            child: Text('Запросить погоду'),
            onPressed: (){
              _getCurrentWeather();
            },
          ),
    Text('Температура: $_temperature C'),
    Text('Облачность: $_clouds %'),
    Text('Давление: $_pressure мм рт.ст'),
    Text('Влажность: $_humidity %'),
        ],
      )
    ));
  }


  _getCurrentWeather() async{
    //units=metric - Celsius
    var response = await http.get('http://api.openweathermap.org/data/2.5/weather?id=524901&APPID=$_APIKEY&units=metric');
    if(response.statusCode==200) {
      print( response.body );
      var parsedJson = jsonDecode(response.body);
      setState(() {
        _temperature = parsedJson['main']['temp'];
            _humidity = parsedJson['main']['humidity'];
            _pressure = (parsedJson['main']['pressure'] * hPa_to_mmHg_factor).round();
            _clouds = parsedJson['clouds']['all'];
      });
    }
  }

}


class ExampleNumber {
  int number;

  static final Map<int, String> map = {
    0: "zero",
    1: "one",
    2: "two",
    3: "three",
    4: "four",
    5: "five",
    6: "six",
    7: "seven",
    8: "eight",
    9: "nine",
    10: "ten",
    11: "eleven",
    12: "twelve",
    13: "thirteen",
    14: "fourteen",
    15: "fifteen",
  };

  String get numberString {
    return (map.containsKey(number) ? map[number] : "unknown");
  }

  ExampleNumber(this.number);

  String toString() {
    return ("$number $numberString");
  }

  static List<ExampleNumber> get list {
    return (map.keys.map((num) {
      return (ExampleNumber(num));
    })).toList();
  }
}

