import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/data/taskData.dart';

class Tasks extends StatefulWidget {
  const Tasks({Key? key}) : super(key: key);

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskdata, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton(
            backgroundColor: const Color.fromARGB(255, 43, 9, 168),
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Column(
                        children: [
                          MaterialButton(
                            onPressed: () async {
                              await taskdata.sqlDb.mydeletedatabase();
                            },
                            child: const Text("delete database"),
                          ),
                          const Text(
                            "Task",
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold),
                          ),
                          TextFormField(
                            controller: taskdata.task,
                            textAlign: TextAlign.center,
                            autofocus: true,
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          GestureDetector(
                            onTap: (() async {
                              int response = await taskdata.sqlDb.insert(
                                  "tasks", {"task": taskdata.task.text});
                              if (response > 0) {
                                // ignore: use_build_context_synchronously
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => const Tasks()),
                                    (route) => false);
                              }
                            }),
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              color: const Color.fromARGB(255, 43, 9, 168),
                              child: const Text("Add Task",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20)),
                            ),
                          )
                        ],
                      ),
                    );
                  });
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 43, 9, 168),
          body: SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Icon(
                      Icons.edit_note,
                      color: Colors.white,
                      size: 50,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Tasks",
                      style: TextStyle(color: Colors.white, fontSize: 40),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text("Do it!",
                    style: TextStyle(color: Colors.white, fontSize: 25)),
                const SizedBox(
                  height: 20,
                ),
                Container(
                    height: 570,
                    width: 500,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: ListView.builder(
                      itemCount: taskdata.tasks.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            "${taskdata.tasks[index]['task']}",
                            style: const TextStyle(fontSize: 20),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Checkbox(
                                  value: taskdata.val,
                                  onChanged: (newval) {
                                    /* setState(() {
                                      taskdata.val = newval!;
                                    });*/
                                  }),
                              IconButton(
                                  onPressed: () async {
                                    int response = await taskdata.sqlDb
                                        .delete("tasks", "id");
                                    if (response > 0) {
                                      taskdata.tasks.removeWhere((element) =>
                                          element['id'] ==
                                          taskdata.tasks[index]['id']);
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ))
                            ],
                          ),
                        );
                      },
                    ))
              ],
            ),
          )),
        );
      },
    );
  }
}
