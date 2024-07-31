import 'package:flutter/material.dart';

import 'package:notes_app/controllers/controller.dart';
import 'package:get/get.dart';
import 'package:notes_app/models/notes.dart';
import 'package:notes_app/screens/noteform.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final NoteController controller = Get.find();
    print("build");
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black87,
        title: const Text(
          "Notes App",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: GetBuilder<NoteController>(
        builder: (controller) {
          return controller.notes.isEmpty ?
          
           const Center(
              child: Text("write your notes here😊"),
            ):
          ListView.builder(
                itemCount: controller.notes.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 5,horizontal: 16),
                    child: ListTile(
                      
                      shape: RoundedRectangleBorder(side: BorderSide(color: Colors.black),borderRadius: BorderRadius.circular(8)),
                      tileColor: controller.notes[index].isCompleted?Colors.green[200]:Colors.black87.withOpacity(.1),
                      leading: Checkbox(
                        shape:CircleBorder(),
                        checkColor: Colors.white,
                        activeColor: Colors.black87,
                        value: controller.notes[index].isCompleted,
                        onChanged: (value) {
                          controller.changeStatus(controller.notes[index]);
                        },
                      ),
                      title: Text(
                        controller.notes[index].description.toString(),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          controller.notes[index].id.toString();
                          controller.deleteNote(controller.notes[index].id);
                        },
                      ),
                    ),
                  );
                });
          
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black87,
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return SafeArea(child: NoteForm());
              });
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
