import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapidemo/bloc/city_selection_bloc.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'dart:collection';

import 'package:weatherapidemo/data/cities_names_extractor.dart';

class SelectCityTopWidget extends StatelessWidget {

  final Function onCitySelected;

  const SelectCityTopWidget({Key key, this.onCitySelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CitySelectionBloc(),
      child: SelectCityWidget(onCitySelected: onCitySelected,),
    );
  }
}


class SelectCityWidget extends StatefulWidget {

  final onCitySelected;

  const SelectCityWidget({Key key, this.onCitySelected}) : super(key: key);

  @override
  _SelectCityWidgetState createState() => _SelectCityWidgetState(onCitySelected);
}

class _SelectCityWidgetState extends State<SelectCityWidget> {

  Function onCitySelectedAction;

  void exec(Function onCitySelectedAction) {
   onCitySelectedAction(selectedCityId);
  }

  int selectedCityId;
  List<DropdownMenuItem> items = new List();
  Map _allCities = new LinkedHashMap<String, int>();

  _SelectCityWidgetState(this.onCitySelectedAction);

  @override
  void initState() {
    super.initState();
    setCitiesDropdownListValues();
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CitySelectionBloc, CitySelectionState>(
      builder: (context,state){
        if(state is CitiesLoading){
          print('С О С Т О Я Н И Е: loading');
          return Center(child: CircularProgressIndicator());
        }
        if(state is EmptySelection){
          print('С О С Т О Я Н И Е: ready');
          return Container(
            padding: EdgeInsets.all(16.0),
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SearchableDropdown.single(
                  items: items,
                  value: selectedCityId,
                  hint: "Выберите город",
                  searchHint: "Выберите город",
                  onChanged: (key) {
                    selectedCityId = _allCities[key];

                  },
                  isExpanded: true,
                ),

                RaisedButton(
                  child: Text('Запросить погоду'),
                  onPressed: (){
                    if(selectedCityId != null) {
                      BlocProvider.of<CitySelectionBloc>( context )
                          .add( CitySelectedEvent( selectedCityId ) );
                      exec( onCitySelectedAction );
                    }
                  },
                ),
              ],
            ),
          );
        }
        if(state is CitySelected){
          print('С О С Т О Я Н И Е: selected');
          return Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SearchableDropdown.single(
                  items: items,
                  value: selectedCityId,
                  hint: "Выберите город",
                  searchHint: "Выберите город",
                  onChanged: (key) {
                    selectedCityId = _allCities[key];
                  },
                  isExpanded: true,
                ),
                RaisedButton(
                  child: Text('Обновить данные'),
                  onPressed: (){
                    if(selectedCityId != null) {
                      BlocProvider.of<CitySelectionBloc>( context )
                          .add( CitySelectedEvent( selectedCityId ) );
                      exec( onCitySelectedAction );
                    }
                  },
                ),
              ],
            ),
          );
        }
        if(state is CityError){
          print('С О С Т О Я Н И Е: err');
          return Text(
            'Где-то проёбка с городом!',
            style: TextStyle(color: Colors.red),
          );
        }
        return null;
      }

    );
  }


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

    BlocProvider.of<CitySelectionBloc>(context)
        .add(CitiesListLoadedEvent());

  }

}


