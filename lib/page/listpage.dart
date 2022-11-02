import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_listview/page/edit.dart';

// ignore: unused_import
import './../models/task.dart';
import './../service/tasklist.dart';

class MyListPage extends StatefulWidget {
  const MyListPage({super.key});

  @override
  State<MyListPage> createState() => _MyListPageState();
}

class _MyListPageState extends State<MyListPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<Tasklist>().fetchTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dynamic Listview dengan provider"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: context.watch<Tasklist>().taskList.length,
                itemBuilder: (context, index) {
                  // jika nanti di tap maka akan bisa
                  final item = context.read<Tasklist>().taskList[index].name;
                  return Dismissible(
                    // Each Dismissible must contain a Key. Keys allow Flutter to
                    // uniquely identify widgets.
                    key: Key(item),
                    // Provide a function that tells the app
                    // what to do after an item has been swiped away.
                    direction: DismissDirection.horizontal,
                    confirmDismiss: (DismissDirection direction) async {
                      if (direction == DismissDirection.startToEnd) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditTaskPage(
                                    taskName: context
                                        .watch<Tasklist>()
                                        .taskList[index]!
                                        .name)));
                        return false;
                      } else {
                        context.read<Tasklist>().deleteTask(item);

                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('$item dismissed')));
                        return true;
                      }
                    },
                    background: const ColoredBox(
                      color: Color.fromARGB(255, 13, 201, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                        ),
                      ),
                    ),
                    secondaryBackground: const ColoredBox(
                      color: Colors.red,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                        ),
                      ),
                    ),
                    child: ListTile(
                      title:
                          Text(context.watch<Tasklist>().taskList[index].name),
                    ),
                  );
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // context.read<Tasklist>().addTask();
                      Navigator.pushNamed(context, "/addTask");
                    },
                    child: const Text("Halaman Tambah"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
