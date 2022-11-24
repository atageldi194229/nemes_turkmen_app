import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nemes/data/models/app_data_model.dart';
import 'package:nemes/data/repositories/app_repository.dart';
import 'package:nemes/presentation/components/custom_app_bar.dart';
import 'package:nemes/presentation/constants/contants.dart';
import 'package:nemes/presentation/pages/translation_page/translations_page.dart';

class HomePage extends HookWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(
          title: "Nemes dilini öwren! Offline",
          enableCancel: false,
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
                      childAspectRatio: 5 / 4,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ),
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
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  // color: Colors.amber,
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    image: AssetImage(category.image),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                child: const Text(" "),
                              ),
                            ),
                            const SizedBox(height: defaultPadding),
                            Text(
                              "${category.name} (${category.translations.length})",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
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
