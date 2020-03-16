import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:weatherapidemo/bloc/weather_bloc.dart';
import 'package:weatherapidemo/bloc/weather_event.dart';
import 'package:weatherapidemo/bloc/weather_state.dart';
import 'package:weatherapidemo/data/cities_names_extractor.dart';
import 'package:weatherapidemo/data/open_weather_api_client.dart';
import 'package:weatherapidemo/model/weather.dart';
import 'dart:collection';
import 'package:flutter/material.dart';


class OpenDemoApiPage extends StatefulWidget {
  @override
  _OpenDemoApiPageState createState() => _OpenDemoApiPageState();
}

class _OpenDemoApiPageState extends State<OpenDemoApiPage> {

  OpenWeatherApiClient client = new OpenWeatherApiClient();
  //Weather currentWeather;
  String selectedValue;

  List<DropdownMenuItem> items = new List();
  Map _allCities = new LinkedHashMap<String, int>();


  @override

  void initState() {

    super.initState();
    setCitiesDropdownListValues();
    //currentWeather = new Weather(0, 0, 0, 0, 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('Open Weather Api Demo', style: TextStyle(color: Colors.black54),),
        ),
        body:  BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state){
            if(state is WeatherInitial)
              {
                print('С О С Т О Я Н И Е: init');
                return Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        SearchableDropdown.single(
                          items: items,
                          value: selectedValue,
                          hint: "Выберите город",
                          searchHint: "Выберите город",
                          onChanged: (key) {
                            selectedValue = _allCities[key].toString();
                          },
                          isExpanded: true,
                        ),

                        RaisedButton(
                          child: Text('Запросить погоду'),
                          onPressed: (){
                            if( selectedValue!= null)
                              BlocProvider.of<WeatherBloc>(context)
                                  .add(FetchWeather(cityName: selectedValue));
//                            setState(() {
//                              getCurrentWeather( );
//                            });
                          },
                        ),
                        Text('Температура: ? C'),
                        Text('Облачность: ? %'),
                        Text('Давление: ? мм рт.ст'),
                        Text('Влажность: ? %'),
                      ],
                    ));
              }
            if(state is WeatherLoading)
              {
                print('С О С Т О Я Н И Е: loading');
                return Center(child: CircularProgressIndicator());
              }
            if(state is WeatherLoaded)
            {
              print('С О С Т О Я Н И Е: display');
              return Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      SearchableDropdown.single(
                        items: items,
                        value: selectedValue,
                        hint: "Выберите город",
                        searchHint: "Выберите город",
                        onChanged: (key) {
                          selectedValue = _allCities[key].toString();
                          if( selectedValue!= null)
                            BlocProvider.of<WeatherBloc>(context)
                                .add(FetchWeather(cityName: selectedValue));
                        },
                        isExpanded: true,
                      ),

                      RaisedButton(
                        child: Text('Запросить погоду'),
                        onPressed: (){
                          if( selectedValue!= null)
                            BlocProvider.of<WeatherBloc>(context)
                                .add(FetchWeather(cityName: selectedValue));
//                          setState(() {
//                            getCurrentWeather( );
//                          });
                        },
                      ),
                      Text('Температура:${state.weather.temperature} C'),
                      Text('Облачность: ${state.weather.clouds} %'),
                      Text('Давление: ${state.weather.pressure} мм рт.ст'),
                      Text('Влажность: ${state.weather.humidity} %'),
                    ],
                  ));
            }
            if(state is WeatherError)
              {
                print('С О С Т О Я Н И Е: error');
                return Text(
                  'Где-то проёбка!',
                  style: TextStyle(color: Colors.red),
                );
              }
            return null;
        }
        ));
  }

//  getCurrentWeather() async{
//    currentWeather = await client.getCurrentWeather(int.parse(selectedValue));
//    print('Weather: temp = ${currentWeather.temperature}');
//  }

  setCitiesDropdownListValues() async {

    CitiesNamesExtractor extractor = new CitiesNamesExtractor();
    _allCities = await extractor.getCitiesNamesMap();

    _allCities.forEach((k,v){
      items.add(DropdownMenuItem(
        child: Text(k),
        value: k,
      )
      );

    });

    while(!mounted){
      print('Warning: cannot set cities dropdown list cause widget is building');
    }
    setState(()=>{});

  }

}
