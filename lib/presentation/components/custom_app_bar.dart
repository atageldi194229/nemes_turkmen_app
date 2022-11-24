import 'package:flutter/material.dart';
import 'package:nemes/data/models/app_data_model.dart';
import 'package:nemes/data/models/category_model.dart';
import 'package:nemes/data/models/translation_model.dart';
import 'package:nemes/data/repositories/app_repository.dart';
import 'package:nemes/presentation/components/suggestion_list.dart';
import 'package:nemes/presentation/components/toast.dart';
import 'package:nemes/presentation/pages/translation_page/body.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    this.title = "",
    this.enableCancel = true,
  })  : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  final String title;
  final bool enableCancel;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  final Size preferredSize;
}

class _CustomAppBarState extends State<CustomAppBar> {
  final _controller = ScrollController();
  late _MySearchDelegate _delegate;

  @override
  void initState() {
    super.initState();

    _delegate = _MySearchDelegate();

    // Setup the listener.
    _controller.addListener(() {
      if (_controller.position.atEdge) {
        bool isTop = _controller.position.pixels == 0;
        if (isTop) {
        } else {
          // context.read<HomeScreenProvider>().loadPosts();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(widget.title),
      leading: widget.enableCancel
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            )
          : null,
      actions: [
        IconButton(
          tooltip: 'Search',
          icon: const Icon(Icons.search),
          onPressed: () async {
            final String? selected = await showSearch<String>(
              context: context,
              delegate: _delegate,
            );

            if (selected != null && selected.isNotEmpty) {
              (() => showToast(context, selected))();
            }
          },
        ),
      ],
    );
  }
}

class _MySearchDelegate extends SearchDelegate<String> {
  List<String> _lastFetchedSuggestions = [];

  _MySearchDelegate() : super();

  @override
  List<Widget>? buildActions(BuildContext context) {
    List<Widget> actions = [
      IconButton(
        tooltip: 'Search',
        icon: const Icon(Icons.search),
        onPressed: () {
          showResults(context);
        },
      ),
    ];

    if (query.isNotEmpty) {
      actions.add(
        IconButton(
          tooltip: 'Clear',
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
        ),
      );
    }

    return actions;
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        // SearchDelegate.close() can return values, similar to Navigator.pop().
        // context.read<PostSearchProvider>().setSearch("");
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // context.read<PostSearchProvider>().setSearch(query);

    return FutureBuilder<AppDataModel>(
      future: AppRepository().getAppData(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          final data = snapshot.data!;

          List<TranslationModel> translations = [];

          for (var cat in data.categories) {
            for (var e in cat.translations) {
              bool a = e.sentence.toLowerCase().contains(query.toLowerCase());
              bool b =
                  e.translation.toLowerCase().contains(query.toLowerCase());

              if (a || b) {
                translations.add(e);
              }
            }
          }

          CategoryModel category = CategoryModel(
              name: "Search: $query",
              translations: translations,
              image: "empty");

          return Body(category: category);
        } else if (snapshot.hasError) {
          return const Center(child: Text("Load error"));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return SuggestionList(
      query: query,
      onSelect: (String suggestion) async {
        query = suggestion;

        showResults(context);
      },
      fetchSuggestions: () async {
        if (query.isEmpty) {
          return [];
          //   return (await _prefs).getStringList('suggestion_history') ?? [];
        }

        final data = await AppRepository().getAppData();

        List<String> result = [];

        for (var cat in data.categories) {
          for (var e in cat.translations) {
            result.add(e.sentence);
            result.add(e.translation);
          }
        }

        result = result
            .where((e) => e.toLowerCase().contains(query.toLowerCase()))
            .toList();

        if (result.isEmpty) {
          return _lastFetchedSuggestions;
        }

        _lastFetchedSuggestions = result;
        return result;
      },
    );
  }
}
