import 'package:mesran_app/src/features/home/domain/entity/event.dart';
import 'package:mesran_app/src/features/home/domain/entity/user.dart';

class HomePageState {
  final bool isLoading;
  final List<EventHome> items;
  final User? user;

  HomePageState(
      {required this.isLoading, required this.items, required this.user});

  factory HomePageState.initial() {
    return HomePageState(isLoading: false, items: [], user: null);
  }

  HomePageState copyWith(
      {required bool isLoading,
      required List<EventHome> items,
      required User user}) {
    return HomePageState(
      isLoading: isLoading,
      items: items,
      user: user,
    );
  }
}

class HomePageLoading extends HomePageState {
  HomePageLoading(User? user) : super(isLoading: true, items: [], user: user);
}

class HomePageLoaded extends HomePageState {
  final List<EventHome> events;

  HomePageLoaded(this.events, User? user)
      : super(isLoading: false, items: events, user: user);
}

class HomePageError extends HomePageState {
  final String message;

  HomePageError(this.message, User? user)
      : super(isLoading: false, items: [], user: user);
}
