import 'package:choach_debate/core/theme/color.dart';
import 'package:choach_debate/features/Topics/presentation/bloc/topics_bloc.dart';
import 'package:choach_debate/features/Topics/presentation/widgets/category_chips.dart';
import 'package:choach_debate/features/Topics/presentation/widgets/error_state.dart';
import 'package:choach_debate/features/Topics/presentation/widgets/topic_list.dart';
import 'package:choach_debate/features/Topics/presentation/widgets/topic_search_bar.dart';
import 'package:choach_debate/shared/utils/debouncer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopicPage extends StatefulWidget {
  const TopicPage({super.key});

  @override
  State<TopicPage> createState() => _TopicPageState();
}

class _TopicPageState extends State<TopicPage> {
  final TextEditingController _search = TextEditingController();
  final Debouncer _debounce = Debouncer();
  int? _lastTopicCount;
  String? _selectedCategory;
  List<String>? _categories;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _onRefresh(context);
    });
  }

  @override
  void dispose() {
    _debounce.dispose();
    _search.dispose();
    super.dispose();
  }

  void _onSearchChanged(String _) {
    _debounce(() {
      if (mounted) setState(() {});
    });
  }

  Future<void> _onRefresh(BuildContext context) async {
    final bloc = context.read<TopicsBloc>();
    if (bloc.state is TopicsLoadingState) {
      await bloc.stream.firstWhere(
        (s) =>
            s is GetCategoriesState ||
            s is GetTopicsState ||
            s is TopicsErrorState,
      );
      return;
    }

    setState(() {
      _selectedCategory = null;
    });
    bloc.add(const GetTopicsEvent());
    await bloc.stream.firstWhere(
      (s) => s is GetCategoriesState || s is TopicsErrorState,
    );
  }

  void _onCategorySelected(String category) {
    setState(() {
      _selectedCategory = category;
      _search.clear();
    });
    context.read<TopicsBloc>().add(GetCategoryTopicsEvent(category: category));
  }

  @override
  Widget build(BuildContext context) {
    final errorMessage = context.select<TopicsBloc, String?>((bloc) {
      final s = bloc.state;
      return s is TopicsErrorState ? s.message : null;
    });

    if (errorMessage != null) {
      return Scaffold(
        backgroundColor: AppColor.background,
        body: SafeArea(
          child: ErrorState(
            message: errorMessage,
            onRetry: () => _onRefresh(context),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocListener<TopicsBloc, TopicsState>(
            listener: (context, state) {
              if (state is GetTopicsState) {
                _lastTopicCount = state.topics.length;
              } else if (state is GetCategoriesState) {
                _categories = state.categories;

                if (state.categories.isNotEmpty && _selectedCategory == null) {
                  _selectedCategory = state.categories.first;

                  context.read<TopicsBloc>().add(
                    GetCategoryTopicsEvent(category: state.categories.first),
                  );
                }
              }
            },
            child: RefreshIndicator.adaptive(
              onRefresh: () => _onRefresh(context),
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  // Search Bar
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16, top: 8),
                      child: TopicSearchBar(
                        controller: _search,
                        onChanged: _onSearchChanged,
                      ),
                    ),
                  ),

                  // Category Chips
                  BlocBuilder<TopicsBloc, TopicsState>(
                    builder: (context, state) {
                      final isLoading = state is TopicsLoadingState;

                      if (_categories != null && _categories!.isNotEmpty) {
                        return SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: CategoryChips(
                              categories: _categories!,
                              selectedCategory: _selectedCategory,
                              isLoading: isLoading,
                              onCategorySelected: _onCategorySelected,
                            ),
                          ),
                        );
                      }
                      return const SliverToBoxAdapter(child: SizedBox.shrink());
                    },
                  ),

                  // Topic List
                  BlocSelector<TopicsBloc, TopicsState, List<dynamic>?>(
                    selector: (state) =>
                        state is GetTopicsState ? state.topics : null,
                    builder: (context, topics) {
                      final isLoading = context.select<TopicsBloc, bool>(
                        (bloc) => bloc.state is TopicsLoadingState,
                      );

                      return TopicList(
                        topics: topics,
                        isLoading: isLoading,
                        selectedCategory: _selectedCategory,
                        searchQuery: _search.text,
                        lastTopicCount: _lastTopicCount,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
