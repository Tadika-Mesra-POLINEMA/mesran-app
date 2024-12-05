import 'package:dartz/dartz.dart';
import 'package:mesran_app/src/features/events/data/repository/event_repository_impl.dart';
import 'package:mesran_app/src/features/events/domain/entities/pref/create_event_pref.dart';
import 'package:mesran_app/src/features/events/domain/entities/req/create_event_request.dart';
import 'package:mesran_app/src/features/events/domain/entities/res/created_event_response.dart';
import 'package:mesran_app/src/features/events/domain/failures/create_event_failure.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateEventUseCase {
  final EventRepositoryImpl _eventRepositoryImpl;
  final SharedPreferences _sharedPreferences;

  CreateEventUseCase(this._eventRepositoryImpl, this._sharedPreferences);

  Future<Either<CreateEventFailure, CreatedEventResponse>> call(
      CreateEventRequest event) async {
    final response = await _eventRepositoryImpl.createEvent(event);

    return response.fold((errorResponse) {
      return Left(errorResponse);
    }, (successResponse) async {
      try {
        await _clearCreateEventData();
        return Right(successResponse);
      } catch (error) {
        return Left(CreateEventFailure('Unknown error'));
      }
    });
  }

  Future<void> _clearCreateEventData() async {
    _sharedPreferences.remove(CreateEventPref.name);
    _sharedPreferences.remove(CreateEventPref.description);
    _sharedPreferences.remove(CreateEventPref.location);
    _sharedPreferences.remove(CreateEventPref.date);
    _sharedPreferences.remove(CreateEventPref.start);
    _sharedPreferences.remove(CreateEventPref.theme);
    _sharedPreferences.remove(CreateEventPref.dresscode);
  }
}
