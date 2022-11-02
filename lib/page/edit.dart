import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// ignore: unused_import
import 'package:provider_listview/models/task.dart';
import 'package:provider_listview/service/tasklist.dart';

class EditTaskPage extends StatefulWidget {
  final String taskName;
  const EditTaskPage({super.key, required this.taskName});

  @override
  // ignore: override_on_non_overriding_member
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  final TextEditingController _textName = TextEditingController();
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Task ${widget.taskName}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Form(
              key: _key,
              child: TextFormField(
                initialValue: widget.taskName,
                decoration: const InputDecoration(
                  hintText: "Edit Task",
                ),
                validator: (String? value) {
                  if (value != '') {
                    if (value!.length < 3) {
                      return 'Inputan harus lebih dari 3';
                    } else {
                      return null;
                    }
                  } else {
                    return "Inputan haus diisi!";
                  }
                },
                onChanged: (value) {
                  context.read<Tasklist>().changeTaskName(value);
                },
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<Tasklist>().updateTask(widget.taskName);
                      Navigator.pop(context);
                    },
                    child: const Text("Edit Task"),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<Tasklist>().deleteTask(widget.taskName);
                      Navigator.pop(context);
                    },
                    child: const Text("Delete Task"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
    ;
  }
}
