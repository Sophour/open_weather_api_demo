import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapidemo/bloc/weather_bloc.dart';
import 'package:weatherapidemo/widgets/weather_conditions_display.dart';


class WeatherDisplayWidget extends StatefulWidget {
  @override
  _WeatherDisplayWidgetState createState() => _WeatherDisplayWidgetState();
}

class _WeatherDisplayWidgetState extends State<WeatherDisplayWidget> {
  //TODO lastCityId and Name vars

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
        return Container(

            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 100.0,
                ),

                WeatherConditionsDisplay(weather: state.weather),

                //TODO make a decent refresh button
//             FloatingActionButton(
//                    backgroundColor: Colors.white,
//                    child: Icon(Icons.refresh, size: 30,),
//                    onPressed: (){
//                      BlocProvider.of<WeatherBloc>(context).add(
//                          FetchWeatherEvent(cityId: 565764,cityName:state.weather.cityName ));
//                    },
//                  ),


              ],
            ));
      }
      if (state is WeatherError) {
        //TODO fix setState exception
          Scaffold.of( context ).showSnackBar(
              SnackBar(
                duration: Duration( seconds: 8 ),
                content: Text(
                  'Ошибка при отображении погоды.\n${state.errorMsg}',
                  style: TextStyle( color: Colors.pink[200] ),
                ), ) );
            }
      return Container();
    });
  }
}
