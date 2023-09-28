part of 'news_bloc.dart';

@immutable
@freezed
class NewsState with _$NewsState {
  const NewsState._();

  const factory NewsState({
    @Default(null) List<Article>? latestArticleList,
    @Default(null) Article? articleFromId,
    @Default(null) List<Article>? featureArticleList,
  }) = _NewsState;
}
