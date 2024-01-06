import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:map_exam/common/models/models.dart';
import 'package:map_exam/global.dart';

@RoutePage()
class EditScreen extends StatefulWidget {
  const EditScreen({
    Key? key,
    this.note,
    this.viewMode = false,
  }) : super(key: key);

  final Note? note;
  final bool? viewMode;

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  Future<void> _saveNote() async {
    CollectionReference ref = FirebaseFirestore.instance
        .collection('users')
        .doc(Global.authState.userData!.uid)
        .collection('notes');

    if (widget.note == null) {
      ref.add(
        Note(
          id: widget.note?.id,
          title: _titleController.text,
          content: _descriptionController.text,
        ).toJsonWithoutId(),
      );
    } else {
      ref.doc(widget.note?.id).update(
            Note(
              id: widget.note?.id,
              title: _titleController.text,
              content: _descriptionController.text,
            ).toJsonWithoutId(),
          );
    }

    Fluttertoast.showToast(
      msg: "Note ${widget.note == null ? 'Created' : 'Updated'}",
    );
  }

  @override
  void initState() {
    super.initState();

    _titleController.text = widget.note?.title ?? "";
    _descriptionController.text = widget.note?.content ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        centerTitle: true,
        title: const Text('App Bar Title'),
        actions: [
          IconButton(
              icon: const Icon(
                Icons.check_circle,
                size: 30,
              ),
              onPressed: () async {
                await _saveNote();
              },
            ),
          IconButton(
              icon: const Icon(
                Icons.cancel_sharp,
                size: 30,
              ),
            onPressed: () {
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              initialValue: null,
              enabled: true,
              decoration: const InputDecoration(
                hintText: 'Type the title here',
              ),
              onChanged: (value) {},
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: TextFormField(
                  controller: _descriptionController,
                  enabled: true,
                  initialValue: null,
                  maxLines: null,
                  expands: true,
                  decoration: const InputDecoration(
                    hintText: 'Type the description',
                  ),
                  onChanged: (value) {}),
            ),
          ],
        ),
      ),
    );
  }
}
