import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/data/repositories/mock_repository.dart';
import 'package:flutter_app/domain/models/card.dart';
import 'package:flutter_app/presentation/home_page/bloc/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_app/presentation/details_page/details_page.dart';
import 'package:flutter_app/presentation/home_page/bloc/bloc.dart';
import 'package:flutter_app/presentation/home_page/bloc/events.dart';

import '../../data/repositories/anime_repository.dart';

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

class _Card extends StatefulWidget {
  final String text;
  final String descriptionText;
  final IconData icon;
  final String? imageUrl;
  final OnLikeCallBack onLike;
  final VoidCallback? onTap;

  const _Card(
    this.text, {
    this.icon = Icons.face,
    required this.descriptionText,
    this.imageUrl,
    this.onLike,
    this.onTap,
  });

  factory _Card.fromData(
    CardData data, {
    OnLikeCallBack onLike,
    VoidCallback? onTap,
  }) => _Card(
    data.text,
    descriptionText: data.descriptionText,
    icon: data.icon,
    imageUrl: data.imageUrl,
    onLike: onLike,
    onTap: onTap,
  );

  @override
  State<_Card> createState() => _CardState();
}

class _CardState extends State<_Card> {
  bool isLiked = false;
  final Color niceOrange = Color.fromRGBO(255, 94, 51, 100);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
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
          color: niceOrange,
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
                    widget.imageUrl ?? "",
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
                        widget.text,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        widget.descriptionText,
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
                    onTap: () {
                      setState(() {
                        isLiked = !isLiked;
                      });
                      widget.onLike?.call(widget.text, isLiked);
                    },
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
  Timer? _debounce;

  @override
  void initState(){
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeBloc>().add(const HomeLoadDataEvent());
    });
    super.initState();
  }

  @override
  void dispose(){
    searchController.dispose();
    _debounce?.cancel();
    super.dispose();
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
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: CupertinoSearchTextField(
              controller: searchController,
              onChanged: _onSearchChanged,
              placeholder: 'Search anime...',
            ),
          ),
          BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                final items = state.data ?? [];

                if (items.isEmpty && searchController.text.isNotEmpty) {
                  return const Expanded(
                    child: Center(
                      child: Text(
                        'No results found',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  );
                }

                return Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final data = items[index];
                      return _Card.fromData(
                        data,
                        onLike: (title, isLiked) =>
                            _showSnackBar(context, title, isLiked),
                        onTap: () => _navToDetails(context, data),
                      );
                    },
                  ),
                );
              }
          ),
        ],
      ),
    );
  }

  void _showSnackBar(BuildContext context, String title, bool isLiked) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(
            child: Text(
              'goddam u ${isLiked ? "liked $title" : "disliked $title :("}',
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
}
