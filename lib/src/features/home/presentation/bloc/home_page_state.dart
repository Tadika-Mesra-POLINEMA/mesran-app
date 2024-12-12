import 'package:mesran_app/src/features/home/domain/entity/event.dart';

class HomePageState {
  final bool isLoading;
  final List<EventHome> items;

  HomePageState({required this.isLoading, required this.items});

  factory HomePageState.initial() {
    return HomePageState(isLoading: false, items: []);
  }

  HomePageState copyWith(
      {required bool isLoading, required List<EventHome> items}) {
    return HomePageState(
      isLoading: isLoading,
      items: items,
    );
  }
}

class HomePageLoading extends HomePageState {
  HomePageLoading() : super(isLoading: true, items: []);
}

class HomePageLoaded extends HomePageState {
  final List<EventHome> events;

  HomePageLoaded(this.events) : super(isLoading: false, items: events);
}

class HomePageError extends HomePageState {
  final String message;

  HomePageError(this.message) : super(isLoading: false, items: []);
}
