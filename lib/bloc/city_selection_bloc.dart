import 'package:flutter_bloc/flutter_bloc.dart';

class CitySelectionBloc extends Bloc<CitySelectionEvent, CitySelectionState>{

  @override
  get initialState => CitiesLoading();

  @override
  Stream<CitySelectionState> mapEventToState(event) async* {
    try {
      if (event is CitiesListReadyEvent) {
        yield EmptySelection();
      }
      else if(event is CitySelectedEvent){
        yield CitySelected(event.cityId, event.cityName);
      }
    }catch(error){
      yield CityError(error.toString());
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

class CitiesListReadyEvent extends CitySelectionEvent{}

/// States
class CitySelectionState{}

class CitiesLoading  extends CitySelectionState{}
class EmptySelection extends CitySelectionState{}
class CitySelected extends CitySelectionState{
  final int cityId;
  final String cityName;

  CitySelected(this.cityId, this.cityName);
}
class CityError extends CitySelectionState{
  final String errorMessage;

  CityError(this.errorMessage);
}
