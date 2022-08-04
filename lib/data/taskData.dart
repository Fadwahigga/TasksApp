// ignore_for_file: file_names, duplicate_ignore
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:todo/data/sqdb.dart';

class TaskData extends ChangeNotifier {
  SqlDb sqlDb = SqlDb();
  List tasks = [];
  bool isloading = true;
  bool val = false;
  TextEditingController task = TextEditingController();
  @override
  notifyListeners();

  bool? mounted;
  Future read() async {
    List<Map> response = await sqlDb.read("tasks");
    tasks.addAll(response);
    isloading = false;
    if (mounted!) {
      notifyListeners();
    }
  }
}
