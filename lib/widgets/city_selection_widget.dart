import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapidemo/bloc/city_selection_bloc.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:weatherapidemo/bloc/weather_bloc.dart';
import 'dart:collection';
import 'package:weatherapidemo/data/cities_names_extractor.dart';

class CitySelectionWidget extends StatefulWidget {

  @override
  _CitySelectionWidgetState createState() => _CitySelectionWidgetState();
}

class _CitySelectionWidgetState extends State<CitySelectionWidget> {
  int _selectedCityId;
  String _selectedCityName;
  List<DropdownMenuItem> items = new List();
  Map _allCities = new LinkedHashMap<String, int>();

  @override
  void initState() {
    super.initState();
    _setCitiesDropdownListValues();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CitySelectionBloc, CitySelectionState>(
        builder: (context, state) {
      if (state is CitiesLoading) {
        return Center(child:
        Padding(
          padding: EdgeInsets.only(top: 300),
            child:CircularProgressIndicator()) );
      }
      if (state is EmptySelection) {
        //TODO roll-in animation from the top
        return Center(
            child: Container(
          height: 350,
          margin: EdgeInsets.only(left: 30.0, right: 30.0, top:200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.0),
            color: Colors.grey[50],
          ),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
             _getLogoWidget(250),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(36.0),
                  border: Border.all(
                    color: Colors.black54,
                  ),
                ),
                height: 60,
                width: 250,
                margin: EdgeInsets.all(10.0),

                //padding: EdgeInsets.only(bottom:10.0),
                child: _getCitiesDropdownWidget(),
              ),
              RaisedButton(
                child: Container(
                    height: 40,
                    width: 220,
                    alignment: Alignment.center,
                    child: Text(
                      'Запросить погоду',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w300),
                    )),
//                borderSide: BorderSide(color: Colors.black54),
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(36.0)),
                elevation: 0.0,
                color: Colors.black,
                onPressed: () {
                  if (_selectedCityId != null) {
                    BlocProvider.of<CitySelectionBloc>(context).add(
                        CitySelectedEvent(_selectedCityId, _selectedCityName));
                    //exec(onCitySelectedAction);
                    BlocProvider.of<WeatherBloc>(context).add(FetchWeatherEvent(
                        cityName: _selectedCityName, cityId: _selectedCityId));
                  }
                },
              ),
            ],
          )),
        ));
      }
      if (state is CitySelected) {

        return Padding(
          padding: EdgeInsets.only(top:60),
            child: GestureDetector(
                child: _getLittleSearchBar(),
                onTap: (){
                  BlocProvider.of<CitySelectionBloc>(context).add(
                      CitiesListReadyEvent());
                  BlocProvider.of<WeatherBloc>(context).add(ClearWeatherEvent());
                },
                ));
      }
      if (state is CityError) {
        //TODO fix too
        Scaffold.of( context ).showSnackBar(
            SnackBar(
              duration: Duration( seconds: 8 ),
              content: Text(
                  'Ошибка возникла при выборе города.',
                style: TextStyle( color: Colors.pink[200] ),
              ), ) );
      }
      return null;
    });
  }

  _setCitiesDropdownListValues() async {
    CitiesNamesExtractor extractor = new CitiesNamesExtractor();
    _allCities = await extractor.getCitiesNamesMap();

    _allCities.forEach((k, v) {
      items.add(DropdownMenuItem(
        child: Text(k),
        value: k,
      ));
    });

    BlocProvider.of<CitySelectionBloc>(context).add(CitiesListReadyEvent());
  }

  Widget _getLittleSearchBar(){
    return Container(
      height: 30,
      margin: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Row(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Center(
                child: Icon(Icons.search, color: Colors.black54),
              )),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Center(
                child: Container(
                  width: 1,
                  height: 20,
                  color: Colors.black54,
                )),
          ),
          Text(
            'Другой город',
            style: TextStyle(color: Colors.black54),
          )
        ],
      ),);
  }

  Widget _getLogoWidget(double width) {
    return  SizedBox(
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image.asset(
            'assets/images/logo.png',
            alignment: Alignment.center,
            height: 100,
          ),
          Text(
            'Open\nWeather\nAPI'.toUpperCase(),
            style: TextStyle(color: Colors.black, fontSize: 24),
          ),
        ],
      ),
    );
  }

  Widget _getCitiesDropdownWidget(){
    return SearchableDropdown.single(
      displayClearIcon: false,
//                  iconEnabledColor: Colors.black54,
      //underline: '', // leads to a bug, but if uncommented spoils the appearance
      isExpanded: true,
      items: items,
      value: _selectedCityId,
      hint: Text(
        "Выберите город",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black54, fontSize: 18),
      ),
      onChanged: (key) {
        _selectedCityName = key;
        _selectedCityId = _allCities[key];
      },
    );
  }
}
