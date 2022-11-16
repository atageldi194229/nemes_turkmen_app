import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nemes/data/models/app_data_model.dart';
import 'package:nemes/data/repositories/app_repository.dart';
import 'package:nemes/presentation/constants/contants.dart';
import 'package:nemes/presentation/pages/translations_page.dart';

class HomePage extends HookWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("nemes"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: FutureBuilder<AppDataModel>(
            future: AppRepository().getAppData(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                final data = snapshot.data!;

                return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 3 / 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20),
                    itemCount: data.categories.length,
                    itemBuilder: (BuildContext ctx, index) {
                      final category = data.categories[index];
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => TranslationsPage(
                                category: category,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            "${category.name} ${category.translations.length}",
                          ),
                        ),
                      );
                    });
              } else if (snapshot.hasError) {
                return const Center(child: Text("Load error"));
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}