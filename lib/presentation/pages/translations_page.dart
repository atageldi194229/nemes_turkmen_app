import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nemes/data/models/category_model.dart';
import 'package:nemes/presentation/constants/contants.dart';

class TranslationsPage extends HookWidget {
  const TranslationsPage({
    Key? key,
    required this.category,
  }) : super(key: key);

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState(-1);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(category.name),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: ExpansionPanelList(
              expansionCallback: (int index, bool isExpanded) {
                selectedIndex.value = index == selectedIndex.value ? -1 : index;
              },
              children: List.generate(
                category.translations.length,
                (index) {
                  final t = category.translations[index];

                  return ExpansionPanel(
                    canTapOnHeader: true,
                    headerBuilder: (context, isExpanded) {
                      return Padding(
                        padding: const EdgeInsets.all(defaultPadding),
                        child: Text(t.sentence),
                      );
                    },
                    body: Padding(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: Text(t.translation, textAlign: TextAlign.left),
                    ),
                    isExpanded: selectedIndex.value == index,
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
