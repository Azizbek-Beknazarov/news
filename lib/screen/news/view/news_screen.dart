import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_tz/application/home/news_bloc.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
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
        _scrollController.offset > (450 - kToolbarHeight);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state.articleFromId == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              //2
              SliverAppBar(
                backgroundColor: theme.primaryColor,
                expandedHeight: 495.0,
                pinned: true,
                snap: false,
                floating: false,
                leading: IconButton(
                  color: isShrink ? Colors.black : Colors.white,
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(state.articleFromId?.title ?? "",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 20,
                        height: 1.2,
                        fontFamily: 'SF Pro Display',
                        fontWeight: FontWeight.w400,
                        color: isShrink ? Colors.black : Colors.white,
                      ),
                      textScaleFactor: 1),
                  titlePadding: EdgeInsets.only(
                      left: 48, right: 58, bottom: isShrink ? 16 : 40),
                  background: CachedNetworkImage(
                    imageUrl: state.articleFromId?.imageUrl ?? "",
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            blurRadius: 20,
                            offset: const Offset(4, 4),
                          ),
                        ],
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: imageProvider,
                        ),
                      ),
                      child: Container(
                        height: 495,
                        width: double.infinity,
                        alignment: Alignment.bottomLeft,
                        padding: const EdgeInsets.only(
                            left: 20, right: 40, bottom: 40),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    placeholder: (context, url) => const SizedBox(
                        width: double.infinity,
                        height: 495,
                        child: Center(
                            child: CircularProgressIndicator.adaptive())),
                    errorWidget: (context, url, error) => const SizedBox(
                      width: double.infinity,
                      height: 495,
                      child: Center(
                        child: Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
              ),
              //3
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 20,
                ),
              ),

              //4
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 21),
                  child: Text(
                    (state.articleFromId?.description ?? "")
                        .replaceAll(RegExp(r'\n'), "\n\n"),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'SF Pro Display',
                      fontWeight: FontWeight.w400,
                      height: 0,
                      letterSpacing: 0.1,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: CachedNetworkImage(
                  imageUrl: state.articleFromId?.imageUrl ?? "",
                  imageBuilder: (context, imageProvider) => Container(
                    width: double.infinity,
                    height: 155,
                    margin: const EdgeInsets.only(
                        left: 21, right: 21, top: 20, bottom: 500),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: imageProvider,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => const SizedBox(
                      width: double.infinity,
                      height: 155,
                      child:
                          Center(child: CircularProgressIndicator.adaptive())),
                  errorWidget: (context, url, error) => const SizedBox(
                    width: double.infinity,
                    height: 155,
                    child: Center(
                      child: Icon(Icons.error),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
