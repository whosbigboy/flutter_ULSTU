abstract class HomeEvent{
  const HomeEvent();
}

class HomeLoadDataEvent extends HomeEvent{
  final String? search;
  const HomeLoadDataEvent({this.search});
}

class HomeSearchDataEvent extends HomeEvent{
  final String search;
  const HomeSearchDataEvent(this.search);
}