// state.dart
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_app/domain/models/card.dart';

@CopyWith()
class HomeState extends Equatable{
  final List<CardData>? data;
  final bool isLoading;
  final bool isPaginationLoading;
  final bool hasNextPage;
  final int currentPage;
  final String? searchQuery;
  final String? error;

  const HomeState({
    this.data,
    this.isLoading = false,
    this.isPaginationLoading = false,
    this.hasNextPage = false,
    this.currentPage = 1,
    this.searchQuery,
    this.error
  });

  HomeState copyWith({
    List<CardData>? data,
    bool? isLoading,
    bool? isPaginationLoading,
    bool? hasNextPage,
    int? currentPage,
    String? searchQuery,
    String? error,
  }) => HomeState(
    data: data ?? this.data,
    isLoading: isLoading ?? this.isLoading,
    isPaginationLoading: isPaginationLoading ?? this.isPaginationLoading,
    hasNextPage: hasNextPage ?? this.hasNextPage,
    currentPage: currentPage ?? this.currentPage,
    searchQuery: searchQuery ?? this.searchQuery,
  );

  @override
  List<Object?> get props => [
    data,
    isLoading,
    isPaginationLoading,
    hasNextPage,
    currentPage,
    searchQuery,
    error,
  ];
}