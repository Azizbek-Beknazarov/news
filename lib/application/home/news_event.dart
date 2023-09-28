part of 'news_bloc.dart';

@freezed
abstract class NewsEvent with _$NewsEvent {
  const factory NewsEvent.getLatestArticles() = _GetLatestArticles;
  const factory NewsEvent.getArticle(String id) = _GetArticle;
  const factory NewsEvent.getFeaturedArticles() = _GetFeaturedArticles;
  const factory NewsEvent.readed(String id) = _ReadedNews;
  const factory NewsEvent.allReaded() = _AllReadedNews;
}
