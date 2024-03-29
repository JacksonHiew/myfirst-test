import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:map_exam/common/models/models.dart';
import 'package:map_exam/common/providers/note_provider.dart';
import 'package:map_exam/common/router/router.gr.dart';
import 'package:map_exam/global.dart';
import 'package:provider/provider.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _deleteNote(String id) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(Global.authState.userData!.uid)
        .collection('notes')
        .doc(id)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('My Notes'),
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
                  trailing: value.showingTool == note.id
                      ? SizedBox(
                          width: 110.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon:
                                    const Icon(Icons.edit, color: Colors.blue),
                                onPressed: () {
                                  context.router.push(
                                    EditScreenRoute(
                                      note: note,
                                    ),
                                  );
                                },
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.blue,
                                ),
                                onPressed: () {
                                  _deleteNote(note.id);
                                },
                              ),
                            ],
                          ),
                        )
                      : const SizedBox(),
                  title: Text(note.title),
                  subtitle:
                      value.expanded ? Text(note.content) : const SizedBox(),
                  onTap: () {
                    context.router.push(
                      EditScreenRoute(
                        note: note,
                        viewMode: true,
                      ),
                    );
                  },
                  onLongPress: () {
                    value.toggleToolVisibility(note.id);
                  },
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
                  heroTag: "Tag1",
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
            heroTag: "Tag2",
            child: const Icon(Icons.add),
            tooltip: 'Add a new note',
            onPressed: () {
              context.router.push(
                EditScreenRoute(
                  note: null,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
