library searchable_category_list;

import 'package:flutter/material.dart';

typedef IndexedCategoryBuilder = String Function(int);
typedef StringWidgetBuilder = Widget Function(BuildContext, String);

class SearchableCategoryList extends StatelessWidget {
  final String searchQuery;
  final bool caseSensitive;
  final bool ignoreWhitespace;
  final IndexedWidgetBuilder itemBuilder;
  final IndexedCategoryBuilder categoryBuilder;
  final StringWidgetBuilder categoryItem;
  final int itemCount;
  final Widget emptyState;
  final ScrollController scrollController;

  SearchableCategoryList.builder({
    this.searchQuery,
    this.caseSensitive = false,
    this.ignoreWhitespace = false,
    @required this.itemBuilder,
    @required this.categoryBuilder,
    @required this.categoryItem,
    @required this.itemCount,
    this.emptyState,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List<Widget>();
    Map<String, List<int>> itemCategories = Map<String, List<int>>();
    for (int i = 0; i < itemCount; i++) {
      Widget item = itemBuilder(context, i);
      if (itemMeetsSearchCriteria(item.key, searchQuery)) {
        items.add(item);

        String category = categoryBuilder(i);
        if (itemCategories[category] == null) {
          itemCategories[category] = new List<int>();
        }
        itemCategories[category].add(items.length - 1);
      }
    }

    List<Widget> categoryList = List<Widget>();

    itemCategories.forEach((key, value) {
      categoryList.add(categoryItem(context, key));
      categoryList.addAll(value.map((i) => items[i]));
    });

    if (categoryList.isEmpty && emptyState != null) {
      return emptyState;
    }

    return ListView(
      children: categoryList,
      controller: scrollController,
    );
  }

  bool itemMeetsSearchCriteria(ValueKey key, String searchQuery) {
    if (searchQuery == null || searchQuery.isEmpty) {
      return true;
    }
    if (ignoreWhitespace) {
      searchQuery = searchQuery.trim();
    }
    if (caseSensitive) {
      if ((key?.value?.toString() ?? "").contains(searchQuery)) {
        return true;
      }
    } else {
      if ((key.value.toString().toLowerCase() ?? "")
          .contains(searchQuery.toLowerCase())) {
        return true;
      }
    }
    return false;
  }
}
