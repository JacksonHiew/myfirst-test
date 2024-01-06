import 'package:auto_route/auto_route.dart';
import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:map_exam/common/models/models.dart';
import 'package:map_exam/common/providers/note_provider.dart';
import 'package:map_exam/global.dart';
import 'package:provider/provider.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('My Notes'),
        leading: const SizedBox(),
        elevation: 1,
        actions: [
          CircleAvatar(
            backgroundColor: Colors.blue.shade200,
            child: ChangeNotifierProvider.value(
              value: Global.noteProvider,
              child: Consumer<NoteProvider>(
                builder: (context, value, child) {
                  return Text(
                    "${value.count}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0,
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: ChangeNotifierProvider.value(
        value: Global.noteProvider,
        child: Consumer<NoteProvider>(
          builder: (context, value, child) {
            if (value.count == 0) {
              return Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(
                  bottom: 64,
                ),
                child: EmptyWidget(
                  packageImage: PackageImage.Image_2,
                  title: "No Note",
                  subTitle: "Press the '+' button to add a new note now",
                  hideBackgroundAnimation: true,
                ),
              );
            }

            return ListView.separated(
              itemCount: value.count,
              separatorBuilder: (context, index) => const Divider(
                color: Colors.blueGrey,
              ),
              itemBuilder: (context, index) {
                Note note = value.notes[index];

                return ListTile(
                  trailing: SizedBox(
                    width: 110.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.blue,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  title: Text(note.title),
                  subtitle: Text(note.content),
                  onTap: () {},
                  onLongPress: () {},
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ChangeNotifierProvider.value(
            value: Global.noteProvider,
            child: Consumer<NoteProvider>(
              builder: (context, value, child) {
                return FloatingActionButton(
                  child: value.expanded
                      ? const Icon(Icons.unfold_less)
                      : const Icon(Icons.menu),
                  tooltip: 'Show less. Hide notes content',
                  onPressed: () {
                    value.updateExpanded(!value.expanded);
                  },
                );
              },
            ),
          ),
          FloatingActionButton(
            child: const Icon(Icons.add),
            tooltip: 'Add a new note',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
