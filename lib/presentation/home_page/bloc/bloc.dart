import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/data/repositories/anime_repository.dart';
import 'package:flutter_app/presentation/home_page/bloc/state.dart';
import 'package:flutter_app/presentation/home_page/bloc/events.dart';

import '../../../domain/models/card.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState>{
  final AnimeRepository repo;
  List<CardData>? _originalData;

  HomeBloc(this.repo) : super(const HomeState()){
    on<HomeLoadDataEvent>(_onLoadData);
    on<HomeSearchDataEvent>(_onSearchData);
  }

  void _onLoadData(HomeLoadDataEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isLoading: true));

    final data = await repo.loadData(q: event.search);
    _originalData = data;

    emit(state.copyWith(isLoading: false, data: data));
  }

  void _onSearchData(HomeSearchDataEvent event, Emitter<HomeState> emit) async {
    if (event.search.isEmpty) {
      emit(state.copyWith(data: _originalData));
      return;
    }

    emit(state.copyWith(isLoading: true));

    final searchResults = await repo.searchData(q: event.search);

    emit(state.copyWith(
        isLoading: false,
        data: searchResults ?? _originalData
    ));
  }
}