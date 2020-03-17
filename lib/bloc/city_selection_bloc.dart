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
        yield CitySelected(event.cityId);
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

  CitySelectedEvent(this.cityId);
}

class CitiesListLoadedEvent extends CitySelectionEvent{}

/// States
class CitySelectionState{}

class CitiesLoading  extends CitySelectionState{}
class EmptySelection extends CitySelectionState{}
class CitySelected extends CitySelectionState{
  final int cityId;

  CitySelected(this.cityId);
}
class CityError extends CitySelectionState{}
