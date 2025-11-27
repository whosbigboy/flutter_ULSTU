// events.dart
abstract class HomeEvent{
  const HomeEvent();
}

class HomeLoadDataEvent extends HomeEvent{
  final String? search;
  final int page;
  final bool loadMore;

  const HomeLoadDataEvent({
    this.search,
    this.page = 1,
    this.loadMore = false,
  });
}

class HomeSearchDataEvent extends HomeEvent{
  final String search;
  final int page;
  final bool loadMore;

  const HomeSearchDataEvent(
      this.search, {
        this.page = 1,
        this.loadMore = false,
      });
}

class HomeLoadMoreEvent extends HomeEvent {
  const HomeLoadMoreEvent();
}