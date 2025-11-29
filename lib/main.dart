import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/like_bloc/like_bloc.dart';
import 'package:flutter_app/presentation/locale_bloc/locale_bloc.dart';
import 'package:flutter_app/presentation/locale_bloc/locale_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/data/repositories/anime_repository.dart';
import 'package:flutter_app/presentation/home_page/bloc/bloc.dart';
import 'package:flutter_app/presentation/home_page/home_page.dart';

import 'components/locale/l10n/app_locale.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final Color whiteChocolate = Color.fromRGBO(239, 231, 211, 100);
    return BlocProvider<LocaleBloc>(
      lazy: false,
      create: (context) => LocaleBloc(Locale(Platform.localeName)),
      child: BlocBuilder<LocaleBloc, LocaleState>(
        builder: (context, state){
          return MaterialApp(
            title: 'Baryshev Dima PIbd-33',
            localizationsDelegates: AppLocale.localizationsDelegates,
            supportedLocales: AppLocale.supportedLocales,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
              scaffoldBackgroundColor: whiteChocolate,
            ),
            home: RepositoryProvider<AnimeRepository>(
                lazy:true,
                create: (_) => AnimeRepository(),
                child: BlocProvider<LikeBloc>(
                  lazy: false,
                  create: (context) => LikeBloc(),
                    child: BlocProvider<HomeBloc>(
                    lazy: false,
                    create: (context) => HomeBloc(context.read<AnimeRepository>()),
                    child: const MyHomePage(title: 'Baryshev Dima PIbd-33',),
                )
              )
            )
          );
        }
      ),
    );
  }
}
