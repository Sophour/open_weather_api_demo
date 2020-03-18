import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapidemo/bloc/city_selection_bloc.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'dart:collection';

import 'package:weatherapidemo/data/cities_names_extractor.dart';
import 'package:weatherapidemo/utils/weather_icon_mapper.dart';

class SelectCityPage extends StatefulWidget {
  final onCitySelected;

  const SelectCityPage({Key key, this.onCitySelected}) : super(key: key);

  @override
  _SelectCityPageState createState() => _SelectCityPageState(onCitySelected);
}

class _SelectCityPageState extends State<SelectCityPage> {
  /// Mess
  Function onCitySelectedAction;

  void exec(Function onCitySelectedAction) {
    onCitySelectedAction(_selectedCityId, _selectedCityName);
  }

  /// Mess end (no)

  int _selectedCityId;
  String _selectedCityName;
  List<DropdownMenuItem> items = new List();
  Map _allCities = new LinkedHashMap<String, int>();

  _SelectCityPageState(this.onCitySelectedAction);

  @override
  void initState() {
    super.initState();
    setCitiesDropdownListValues();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CitySelectionBloc, CitySelectionState>(
        builder: (context, state) {
      if (state is CitiesLoading) {
        print('С О С Т О Я Н И Е: loading');
        return Center(child: CircularProgressIndicator());
      }
      if (state is EmptySelection) {
        print('С О С Т О Я Н И Е: ready');
        return Center(
            child: Container(
          height: 350,
          margin: EdgeInsets.only(left: 30.0, right: 30.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.0),
            color: Colors.grey[50],
          ),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 250,
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
              ),
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
                child: SearchableDropdown.single(
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
                ),
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
                    exec(onCitySelectedAction);
                  }
                },
              ),
            ],
          )),
        ));
//            Container(
//            padding: EdgeInsets.all(16.0),
//            child: Column(
//
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: <Widget>[
//                SearchableDropdown.single(
//                  items: items,
//                  value: _selectedCityId,
//                  hint: "Выберите город",
//                  searchHint: "Выберите город",
//                  onChanged: (key) {
//                    _selectedCityName = key;
//                    _selectedCityId = _allCities[key];
//                  },
//                  isExpanded: true,
//                ),
//
//                RaisedButton(
//                  child: Text('Запросить погоду'),
//                  onPressed: (){
//                    if(_selectedCityId != null) {
//                      BlocProvider.of<CitySelectionBloc>( context )
//                          .add( CitySelectedEvent( _selectedCityId, _selectedCityName ) );
//                      exec( onCitySelectedAction );
//                    }
//                  },
//                ),
//              ],
//            ),
//          );
      }
      if (state is CitySelected) {
        print('С О С Т О Я Н И Е: selected');

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
          ),
//            child: Column(
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: <Widget>[
//                SearchableDropdown.single(
//                  items: items,
//                  value: _selectedCityId,
//                  hint: "Выберите город",
//                  searchHint: "Выберите город",
//                  onChanged: (key) {
//                    _selectedCityName = key;
//                    _selectedCityId = _allCities[key];
//                  },
//                  isExpanded: true,
//                ),
//                RaisedButton(
//                  child: Text('Обновить данные'),
//                  onPressed: (){
//                    if(_selectedCityId != null) {
//                      BlocProvider.of<CitySelectionBloc>( context )
//                          .add( CitySelectedEvent( _selectedCityId, _selectedCityName ) );
//                      exec( onCitySelectedAction );
//                    }
//                  },
//                ),
//              ],
//            ),
        );
      }
      if (state is CityError) {
        print('С О С Т О Я Н И Е: err');
        return Text(
          'Где-то проёбка с городом!',
          style: TextStyle(color: Colors.red),
        );
      }
      return null;
    });
  }

  setCitiesDropdownListValues() async {
    CitiesNamesExtractor extractor = new CitiesNamesExtractor();
    _allCities = await extractor.getCitiesNamesMap();

    _allCities.forEach((k, v) {
      items.add(DropdownMenuItem(
        child: Text(k),
        value: k,
      ));
    });

    BlocProvider.of<CitySelectionBloc>(context).add(CitiesListLoadedEvent());
  }
}
