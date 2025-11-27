// bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/data/repositories/anime_repository.dart';
import 'package:flutter_app/presentation/home_page/bloc/state.dart';
import 'package:flutter_app/presentation/home_page/bloc/events.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState>{
  final AnimeRepository repo;

  HomeBloc(this.repo) : super(const HomeState()){
    on<HomeLoadDataEvent>(_onLoadData);
    on<HomeSearchDataEvent>(_onSearchData);
    on<HomeLoadMoreEvent>(_onLoadMore);
  }

  void _onLoadData(HomeLoadDataEvent event, Emitter<HomeState> emit) async {
    final page = event.loadMore ? state.currentPage + 1 : 1;

    if (!event.loadMore) {
      emit(state.copyWith(
        isLoading: true,
        searchQuery: event.search,
      ));
    } else {
      emit(state.copyWith(isPaginationLoading: true));
    }

    String? error;

    try {
      final data = await repo.loadData(
        page: page,
        onError: (e) => error = e,
      );

      if (data != null) {
        final newData = event.loadMore && state.data != null
            ? [...state.data!, ...data.data!]
            : data.data;

        emit(state.copyWith(
          isLoading: false,
          isPaginationLoading: false,
          data: newData,
          hasNextPage: data.hasNextPage,
          currentPage: page,
          error: error,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        isPaginationLoading: false,
      ));
    }
  }

  void _onSearchData(HomeSearchDataEvent event, Emitter<HomeState> emit) async {
    if (event.search.isEmpty) {
      add(const HomeLoadDataEvent());
      return;
    }

    final page = event.loadMore ? state.currentPage + 1 : 1;

    if (!event.loadMore) {
      emit(state.copyWith(
        isLoading: true,
        searchQuery: event.search,
      ));
    } else {
      emit(state.copyWith(isPaginationLoading: true));
    }

    try {
      final searchResults = await repo.searchData(
        q: event.search,
        page: page,
      );

      if (searchResults != null) {
        final newData = event.loadMore && state.data != null
            ? [...state.data!, ...searchResults.data!]
            : searchResults.data;

        emit(state.copyWith(
          isLoading: false,
          isPaginationLoading: false,
          data: newData,
          hasNextPage: searchResults.hasNextPage,
          currentPage: page,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        isPaginationLoading: false,
      ));
    }
  }

  void _onLoadMore(HomeLoadMoreEvent event, Emitter<HomeState> emit) async {
    if (state.isPaginationLoading || !state.hasNextPage) return;

    if (state.searchQuery?.isNotEmpty == true) {
      add(HomeSearchDataEvent(
        state.searchQuery!,
        loadMore: true,
      ));
    } else {
      add(const HomeLoadDataEvent(
        loadMore: true,
      ));
    }
  }
}