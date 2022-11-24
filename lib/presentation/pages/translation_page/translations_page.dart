import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nemes/data/models/category_model.dart';
import 'package:nemes/presentation/components/custom_app_bar.dart';
import 'package:nemes/presentation/pages/translation_page/body.dart';

class TranslationsPage extends HookWidget {
  const TranslationsPage({
    Key? key,
    required this.category,
  }) : super(key: key);

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: category.name,
        ),
        body: Body(category: category),
      ),
    );
  }
}
