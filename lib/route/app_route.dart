import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_tz/application/home/news_bloc.dart';
import 'package:test_tz/screen/news/view/news_screen.dart';

class AppRoutes {
  static MaterialPageRoute news(BuildContext context, {required String id}) =>
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: BlocProvider.of<NewsBloc>(context)
            ..add(NewsEvent.getArticle(id)),
          child: const NewsScreen(),
        ),
      );
}
