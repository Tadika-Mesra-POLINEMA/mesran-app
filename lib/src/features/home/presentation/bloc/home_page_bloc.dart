import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mesran_app/src/features/home/domain/use_case/get_home_events_use_case.dart';
import 'package:mesran_app/src/features/home/presentation/bloc/home_page_event.dart';
import 'package:mesran_app/src/features/home/presentation/bloc/home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final GetHomeEventsUseCase getHomeEventsUseCase;

  HomePageBloc(this.getHomeEventsUseCase) : super(HomePageState.initial()) {
    on<HomePageEventLoad>(_onHomePageLoad);
  }

  void _onHomePageLoad(
      HomePageEventLoad event, Emitter<HomePageState> emit) async {
    emit(HomePageLoading());

    // Load data from repository
    try {
      final result = await getHomeEventsUseCase.call();
      result.fold((failure) => emit(HomePageLoaded([])),
          (events) => emit(HomePageLoaded(events)));
    } catch (error) {}
  }
}
