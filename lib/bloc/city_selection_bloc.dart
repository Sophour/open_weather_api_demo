import 'package:flutter_bloc/flutter_bloc.dart';

class CitySelectionBloc extends Bloc<CitySelectionEvent, CitySelectionState>{

  @override
  get initialState => CitiesLoading();

  @override
  Stream<CitySelectionState> mapEventToState(event) async* {
    try {
      if (event is CitiesListLoadedEvent) {
        yield EmptySelection();
      }
      else if(event is CitySelectedEvent){
        yield CitySelected(event.cityId, event.cityName);
      }
    }catch(_){
      yield CityError();
    }
  }
}

/// Events
class CitySelectionEvent{}

class CitySelectedEvent extends CitySelectionEvent{
  final int cityId;
  final String cityName;

  CitySelectedEvent(this.cityId, this.cityName);
}

class CitiesListLoadedEvent extends CitySelectionEvent{}

/// States
class CitySelectionState{}

class CitiesLoading  extends CitySelectionState{}
class EmptySelection extends CitySelectionState{}
class CitySelected extends CitySelectionState{
  final int cityId;
  final String cityName;

  CitySelected(this.cityId, this.cityName);
}
class CityError extends CitySelectionState{}
