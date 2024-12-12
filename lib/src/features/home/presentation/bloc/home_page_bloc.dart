import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mesran_app/src/features/home/domain/use_case/get_home_events_use_case.dart';
import 'package:mesran_app/src/features/home/domain/use_case/get_user_profile_use_case.dart';
import 'package:mesran_app/src/features/home/presentation/bloc/home_page_event.dart';
import 'package:mesran_app/src/features/home/presentation/bloc/home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final GetHomeEventsUseCase getHomeEventsUseCase;
  final GetUserProfileUseCase getUserProfileUseCase;

  HomePageBloc(this.getHomeEventsUseCase, this.getUserProfileUseCase)
      : super(HomePageState.initial()) {
    on<HomePageEventLoad>(_onHomePageLoad);
  }

  Future<void> _onHomePageLoad(
      HomePageEventLoad event, Emitter<HomePageState> emit) async {
    emit(HomePageLoading(state.user));

    try {
      final result = await getHomeEventsUseCase.call();
      final user = await getUserProfileUseCase.call();

      result.fold((failure) => emit(HomePageLoaded([], state.user)),
          (events) => emit(HomePageLoaded(events, state.user)));

      user.fold((failure) => emit(HomePageLoaded(state.items, null)),
          (user) => emit(HomePageLoaded(state.items, user)));
    } catch (error) {
      emit(HomePageError('Gagal memuat data', state.user));
    }
  }
}
