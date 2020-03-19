import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapidemo/bloc/weather_bloc.dart';
import 'package:weatherapidemo/widgets/error_widget.dart';
import 'package:weatherapidemo/widgets/weather_conditions_display.dart';


class WeatherDisplayWidget extends StatefulWidget {
  @override
  _WeatherDisplayWidgetState createState() => _WeatherDisplayWidgetState();
}

class _WeatherDisplayWidgetState extends State<WeatherDisplayWidget> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
      if (state is WeatherInitial) {
        return Container();
      }
      if (state is WeatherLoading) {
        return Container(
          padding: EdgeInsets.only(top:300),
            child: CircularProgressIndicator());
      }
      if (state is WeatherLoaded) {

        return Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top:160.0),
                  child: WeatherConditionsDisplay(weather: state.weather),
                ),

                _refreshButton(state.weather.cityId, state.weather.cityName ),

              ],
            ));
      }
      if (state is WeatherError) {

        Future.microtask(()=>
          ErrorSnackBar('Ошибка при отображении погоды.\n ${state.errorMsg}',
          context).show());

        return Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 0.0),
              child: Image.asset(
                'assets/images/error_icon.png',
                alignment: Alignment.center,
                height: 300,
              ),
            ),
            Text('Что-то пошло\nне так! ;(',
            style: TextStyle(color: Colors.white70,
                fontSize: 36,
            fontWeight: FontWeight.w300),
            textAlign: TextAlign.center,),
          ],
        ));
            }
      return Container();
    });
  }

  Widget _refreshButton(int cityId, String cityName) {
    return Container(
      alignment: Alignment.bottomRight,
      margin: EdgeInsets.only(top:30, right: 30.0, bottom: 30.0),
      child: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(Icons.refresh, size: 30,),
        onPressed: (){
          BlocProvider.of<WeatherBloc>(context).add(
              FetchWeatherEvent(
                  cityId: cityId,
                  cityName:cityName ));
        },
      ),
    );
  }



}
