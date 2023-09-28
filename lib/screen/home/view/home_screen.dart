import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_tz/application/home/news_bloc.dart';
import 'package:test_tz/repositories/news/mock_news_repository.dart';
import 'package:test_tz/screen/home/widgets/latest_card.dart';

import '../../../route/app_route.dart';
import '../widgets/featured_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  bool lastStatus = true;

  _scrollListener() {
    if (isShrink != lastStatus) {
      setState(() {
        lastStatus = isShrink;
      });
    }
  }

  bool get isShrink {
    return _scrollController.hasClients &&
        _scrollController.offset > (105 - kToolbarHeight);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        backgroundColor: theme.primaryColor,
        body: BlocProvider(
          create: (context) => NewsBloc(MockNewsRepository())
            ..add(const NewsEvent.getFeaturedArticles())
            ..add(const NewsEvent.getLatestArticles()),
          child: BlocBuilder<NewsBloc, NewsState>(
            builder: (context, state) {
              if (state.featureArticleList == null ||
                  state.latestArticleList == null) {
                return const Center(child: CircularProgressIndicator());
              }
              final featureList = state.featureArticleList;
              final latestList = state.latestArticleList;
              return CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverAppBar(
                    backgroundColor: theme.primaryColor,
                    title: const Text('Notifications',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'SF Pro Display',
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        )),
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () {},
                    ),
                    actions: [
                      TextButton(
                        child: const Text(
                          'Mark all read',
                          style: TextStyle(
                            fontFamily: 'SF Pro Display',
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        onPressed: () {
                          context
                              .read<NewsBloc>()
                              .add(const NewsEvent.allReaded());
                        },
                      ),
                    ],
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 20)),
                  const SliverToBoxAdapter(
                      child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 28),
                    child: Text(
                      "Featured",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'SF Pro Display',
                          fontWeight: FontWeight.w400),
                    ),
                  )),
                  const SliverToBoxAdapter(child: SizedBox(height: 20)),
                  SliverToBoxAdapter(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      onEnd: () {},
                      height: isShrink ? 123 : 300,
                      child: PageView.builder(
                        clipBehavior: Clip.hardEdge,
                        physics: const ClampingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: state.featureArticleList?.length ?? 2,
                        itemBuilder: (context, index) {
                          return isShrink
                              ? LatestCard(
                                  title: featureList?[index].title ?? "",
                                  imageUrl: featureList?[index].imageUrl ?? "",
                                  onPressed: () {
                                    context.read<NewsBloc>().add(
                                        NewsEvent.readed(
                                            latestList?[index].id ?? ""));
                                    Navigator.of(context).push(AppRoutes.news(
                                        context,
                                        id: featureList?[index].id ?? ""));
                                  },
                                  isReaded: featureList?[index].readed ?? false,
                                  date: featureList?[index].publicationDate,
                                )
                              : FeaturedCard(
                                  title: featureList?[index].title ?? "",
                                  imageUrl: featureList?[index].imageUrl ?? "",
                                  onPressed: () {
                                    context.read<NewsBloc>().add(
                                        NewsEvent.readed(
                                            latestList?[index].id ?? ""));
                                    Navigator.of(context).push(AppRoutes.news(
                                        context,
                                        id: featureList?[index].id ?? ""));
                                  },
                                );
                        },
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 20)),
                  const SliverToBoxAdapter(
                      child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 28),
                    child: Text(
                      "Latest news",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'SF Pro Display',
                          fontWeight: FontWeight.w400),
                    ),
                  )),
                  const SliverToBoxAdapter(child: SizedBox(height: 10)),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return LatestCard(
                          isReaded: latestList?[index].readed ?? false,
                          date: latestList?[index].publicationDate,
                          title: latestList?[index].title ?? "",
                          imageUrl: latestList?[index].imageUrl ?? "",
                          onPressed: () {
                            context.read<NewsBloc>().add(
                                NewsEvent.readed(latestList?[index].id ?? ""));
                            Navigator.of(context).push(AppRoutes.news(context,
                                id: latestList?[index].id ?? ""));
                          },
                        );
                      },
                      childCount: latestList?.length ?? 2,
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 200)),
                ],
              );
            },
          ),
        ));
  }
}
