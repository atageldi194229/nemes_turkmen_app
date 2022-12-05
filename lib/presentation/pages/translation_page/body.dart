import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nemes/data/models/category_model.dart';
import 'package:nemes/presentation/constants/contants.dart';

class Body extends HookWidget {
  const Body({
    Key? key,
    required this.category,
  }) : super(key: key);

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState(-1);

    const style = TextStyle(fontWeight: FontWeight.bold);

    return SingleChildScrollView(
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
                    child: Text(
                      t.sentence,
                      style: style,
                    ),
                  );
                },
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (t.audio != null)
                      IconButton(
                        onPressed: () async {
                          final player = AudioPlayer();
                          await player.play(AssetSource(t.audio!));
                          // await player.setSource();
                        },
                        icon: const Icon(Icons.audio_file),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: Text(
                        t.translation,
                        textAlign: TextAlign.left,
                        style: style,
                      ),
                    ),
                  ],
                ),
                isExpanded: selectedIndex.value == index,
              );
            },
          ),
        ),
      ),
    );
  }
}
