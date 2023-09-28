import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_tz/repositories/news/mock_news_repository.dart';
import 'package:test_tz/repositories/news/models/article.dart';

part 'news_bloc.freezed.dart';
part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final MockNewsRepository _mockNewsRepository;

  NewsBloc(this._mockNewsRepository) : super(const _NewsState()) {
    on<_GetLatestArticles>(getLatestArticles);
    on<_GetArticle>(_getArticle);
    on<_GetFeaturedArticles>(_getFeaturedArticles);
    on<_ReadedNews>(_readedNews);
    on<_AllReadedNews>(_allReadedNews);
  }

  FutureOr<void> getLatestArticles(
    _GetLatestArticles event,
    Emitter<NewsState> emit,
  ) async {
    final res = await _mockNewsRepository.getLatestArticles();
    if (res.isNotEmpty) {
      emit(state.copyWith(latestArticleList: res));
    }
  }

  FutureOr<void> _readedNews(
    _ReadedNews event,
    Emitter<NewsState> emit,
  ) async {
    List<Article>? latestArticleList = state.latestArticleList;
    latestArticleList = latestArticleList?.map((e) {
      if (event.id == e.id) {
        return Article(
            readed: true,
            id: e.id,
            title: e.title,
            publicationDate: e.publicationDate,
            imageUrl: e.imageUrl);
      }
      return e;
    }).toList();

    emit(state.copyWith(latestArticleList: latestArticleList));
  }

  FutureOr<void> _allReadedNews(
    _AllReadedNews event,
    Emitter<NewsState> emit,
  ) async {
    List<Article>? latestArticleList = state.latestArticleList;
    latestArticleList = latestArticleList?.map((e) {
      return Article(
          readed: true,
          id: e.id,
          title: e.title,
          publicationDate: e.publicationDate,
          imageUrl: e.imageUrl);
    }).toList();

    emit(state.copyWith(latestArticleList: latestArticleList));
  }

  FutureOr<void> _getArticle(
    _GetArticle event,
    Emitter<NewsState> emit,
  ) async {
    final res = await _mockNewsRepository.getArticle(event.id);
    emit(state.copyWith(articleFromId: res));
  }

  FutureOr<void> _getFeaturedArticles(
    _GetFeaturedArticles event,
    Emitter<NewsState> emit,
  ) async {
    final res = await _mockNewsRepository.getFeaturedArticles();
    if (res.isNotEmpty) {
      emit(state.copyWith(featureArticleList: res));
    }
  }
}
