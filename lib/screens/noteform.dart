import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/controllers/controller.dart';

class NoteForm extends StatefulWidget {
  NoteForm({
    super.key,
  });

  @override
  State<NoteForm> createState() => _NoteFormState();
}

class _NoteFormState extends State<NoteForm> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String description = "";

  @override
  Widget build(BuildContext context) {
    final NoteController controller = Get.find();

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Add Notes",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              onSaved: (value) {
                description = value!;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Description cannot be empty';
                }
                return null;
              },
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black87)),
                border: OutlineInputBorder(),
                hintText: "Add description",
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.black87),
                      shape: WidgetStateProperty.all(
                          const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6))))),
                  onPressed: () {
                    if (_formkey.currentState?.validate() ?? false) {
                      _formkey.currentState?.save();
                      controller.addNote(description);
                      Get.back();
                    }
                  },
                  child: Text(
                    "Add Note",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.white),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
