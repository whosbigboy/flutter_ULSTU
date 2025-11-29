import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/components/extensions/context_x.dart';
import 'package:flutter_app/components/utils/debounce.dart';
import 'package:flutter_app/data/repositories/mock_repository.dart';
import 'package:flutter_app/domain/models/card.dart';
import 'package:flutter_app/presentation/home_page/bloc/state.dart';
import 'package:flutter_app/presentation/like_bloc/like_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_app/presentation/details_page/details_page.dart';
import 'package:flutter_app/presentation/home_page/bloc/bloc.dart';
import 'package:flutter_app/presentation/home_page/bloc/events.dart';

import '../../data/repositories/anime_repository.dart';
import '../common/svg_objects.dart';
import '../like_bloc/like_event.dart';
import '../like_bloc/like_state.dart';
import '../locale_bloc/locale_bloc.dart';
import '../locale_bloc/locale_events.dart';
import '../locale_bloc/locale_state.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Color darkblue = Color.fromRGBO(26, 0, 137, 100);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkblue,
        title: Center(
          child: Text(
            widget.title,
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
      ),
      body: Body(),
    );
  }
}

typedef OnLikeCallback = void Function(String? id, String title, bool isLiked)?;

class _Card extends StatelessWidget {
  final String text;
  final String descriptionText;
  final IconData icon;
  final String? imageUrl;
  final OnLikeCallback onLike;
  final VoidCallback? onTap;
  final String? id;
  final bool isLiked;

  const _Card(
      this.text, {
        this.icon = Icons.ac_unit_outlined,
        required this.descriptionText,
        this.imageUrl,
        this.onLike,
        this.onTap,
        this.id,
        this.isLiked = false,
      });

  factory _Card.fromData(
      CardData data, {
        OnLikeCallback onLike,
        VoidCallback? onTap,
        bool isLiked = false,
      }) =>
      _Card(
        data.text,
        descriptionText: data.descriptionText,
        icon: data.icon,
        imageUrl: data.imageUrl,
        onLike: onLike,
        onTap: onTap,
        isLiked: isLiked,
        id: data.id,
      );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(16),
        constraints: const BoxConstraints(minHeight: 150),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 3,
              offset: const Offset(0, 5),
              blurRadius: 8,
            ),
          ],
          color: Colors.deepOrangeAccent //переделать на норм орандж,
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  topLeft: Radius.circular(16),
                ),
                child: SizedBox(
                  height: double.infinity,
                  width: 150,
                  child: Image.network(
                    imageUrl ?? "",
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Image.network(
                      'https://i.pinimg.com/736x/09/72/f1/0972f1465684046cc884eca70fdde096.jpg',
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        text,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        descriptionText,
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 8.0,
                    right: 16,
                    bottom: 16,
                  ),
                  child: GestureDetector(
                    onTap: () => onLike?.call(id, text, isLiked),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: isLiked
                          ? const Icon(
                        Icons.favorite,
                        color: Color.fromRGBO(102, 2, 60, 100),
                        key: ValueKey<int>(0),
                      )
                          : const Icon(
                        Icons.favorite_outline,
                        key: ValueKey<int>(1),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final searchController = TextEditingController();
  final scrollController = ScrollController();
  Timer? _debounce;

  @override
  void initState() {
    SvgObjects.init();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeBloc>().add(const HomeLoadDataEvent());
      context.read<LikeBloc>().add(const LoadLikesEvent());
    });

    scrollController.addListener(_onNextPageListener);
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    scrollController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onNextPageListener() {
    if (scrollController.offset > scrollController.position.maxScrollExtent*0.9) {
      final bloc = context.read<HomeBloc>();
      if (!bloc.state.isPaginationLoading){
        bloc.add(HomeLoadDataEvent(
          search: searchController.text,
          loadMore: true
        ));
      }
    }
  }

  void _onSearchChanged(String search) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (search.isEmpty) {
        context.read<HomeBloc>().add(const HomeLoadDataEvent());
      } else {
        context.read<HomeBloc>().add(HomeSearchDataEvent(search));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: CupertinoSearchTextField(
                    controller: searchController,
                    placeholder: context.locale.search,
                    onChanged: (search) {
                      Debounce.run(
                              () => context.read<HomeBloc>().add(HomeLoadDataEvent(search: search)));
                    },
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => context.read<LocaleBloc>().add(const ChangeLocaleEvent()),
                child: SizedBox.square(
                  dimension: 50,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: BlocBuilder<LocaleBloc, LocaleState>(
                      builder: (context, state) {
                        return state.currentLocale.languageCode == 'ru'
                            ? const SvgRu()
                            : const SvgUk();
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) => state.error != null
            ? Text(
              state.error ?? '',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.red),
            )
          : state.isLoading
            ? const CircularProgressIndicator()
                : BlocBuilder<LikeBloc, LikeState>(
                  builder: (context, likeState) {
                    return Expanded(
                        child: RefreshIndicator(
                          onRefresh: _onRefresh,
                          child: ListView.builder(
                            controller: scrollController,
                            padding: EdgeInsets.zero,
                            itemCount: (state.data?.length ?? 0) + (state.hasNextPage ? 1 : 0),
                            itemBuilder: (context, index) {
                                  final data = state.data?.data?[index];
                                  return data != null
                                      ? _Card.fromData(
                                      data,
                                      onLike: _onLike,
                                      isLiked: likeState.likedIds?.contains(data.id) == true,
                                      onTap: () => _navToDetails(context, data),
                                )
                                    : const SizedBox.shrink();
                            }
                          )
                      )
                    );
                  },
                BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) => state.isPaginationLoading
                ? const CircularProgressIndicator()
                    : const SizedBox.shrink(),
                                ),
                  ),
                                ),
                )
          ),
        ],
      ),
    );
  }

  Future<void> _onRefresh() {
    final state = context.read<HomeBloc>().state;
    if (state.searchQuery?.isNotEmpty == true) {
      context.read<HomeBloc>().add(HomeSearchDataEvent(state.searchQuery!));
    } else {
      context.read<HomeBloc>().add(const HomeLoadDataEvent());
    }
    return Future.value(null);
  }

  void _showSnackBar(BuildContext context, String title, bool isLiked) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(
            child: Text(
              '${isLiked ? context.locale.liked : context.locale.disliked} $title',
              style: TextStyle(fontSize: 17, color: Colors.white),
            ),
          ),
          backgroundColor: Color.fromRGBO(26, 0, 137, 100),
          duration: const Duration(milliseconds: 1500),
        ),
      );
    });
  }

  void _navToDetails(BuildContext context, CardData data) {
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => DetailsPage(data)),
    );
  }

  void _onLike(String? id, String title, bool isLiked){
    if (id != null) {
      context.read<LikeBloc>().add(ChangeLikeEvent(id));
      _showSnackBar(context, title, !isLiked);
    }
  }
}
