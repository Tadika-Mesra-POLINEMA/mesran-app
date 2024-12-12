import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mesran_app/src/features/events/domain/entities/pref/create_event_pref.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/event_dresscode_event.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/event_dresscode_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventDresscodeBloc
    extends Bloc<EventDresscodeEvent, EventDresscodeState> {
  final SharedPreferences _sharedPreferences;

  EventDresscodeBloc(this._sharedPreferences)
      : super(const EventDresscodeState()) {
    on<ChangeTheme>(_onChangeTheme);
    on<ChangeDresscode>(_onChangeDresscode);
    on<LoadEventDresscode>(_onLoadEventDresscode);
  }

  void _onLoadEventDresscode(
      LoadEventDresscode event, Emitter<EventDresscodeState> emit) {
    final theme = _sharedPreferences.getString(CreateEventPref.theme) ?? '';
    final dresscode = _sharedPreferences.getString(CreateEventPref.dresscode) ?? 'Formal';

    emit(state.copyWith(theme: theme, dresscode: dresscode));
  }

  void _onChangeTheme(ChangeTheme event, Emitter<EventDresscodeState> emit) {
    if (_validateTheme(event.theme)) {
      _sharedPreferences.setString(CreateEventPref.theme, event.theme);

      emit(state.copyWith(theme: event.theme));
    }
  }

  void _onChangeDresscode(
      ChangeDresscode event, Emitter<EventDresscodeState> emit) {
    if (_validateDresscode(event.dresscode)) {
      _sharedPreferences.setString(CreateEventPref.dresscode, event.dresscode);

      emit(state.copyWith(dresscode: event.dresscode));
    }
  }

  bool _validateTheme(String theme) {
    return theme.isNotEmpty;
  }

  bool _validateDresscode(String dresscode) {
    return dresscode.isNotEmpty && dresscode == 'Formal' ||
        dresscode == 'Kasual' ||
        dresscode == 'Olahraga' ||
        dresscode == 'Tradisional' ||
        dresscode == 'Horror' ||
        dresscode == 'Anime';
  }
}
