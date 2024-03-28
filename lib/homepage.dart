import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/addtask.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:todo/edittask.dart';

late String title;
late String date;
late String prio;

List<String> taskList = [];
List<String> datesList = [];
List<String> priosList = [];
List<bool> checkedList = [];

final TextEditingController titlecontroller = TextEditingController();
final TextEditingController datecontroller = TextEditingController();
final TextEditingController prioritycontroller = TextEditingController();

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    fetchTasks();
    fetchCheckboxStates(); 
  }

  Future<void> fetchTasks() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? titles = prefs.getStringList("taskTitleList");
    List<String>? dates = prefs.getStringList("datesValueList");
    List<String>? prios = prefs.getStringList("prioValueList");

    setState(() {
      taskList = titles ?? [];
      datesList = dates ?? [];
      priosList = prios ?? [];
      checkedList = List.generate(taskList.length, (index) => false);
    });
  }

  Future<void> fetchCheckboxStates() async {
    final prefs = await SharedPreferences.getInstance();
    List<bool?>? checkboxStates = [];
    for (int i = 0; i < taskList.length; i++) {
      bool? isChecked = prefs.getBool('checkedList$i');
      checkboxStates.add(isChecked);
    }
    setState(() {
      checkedList = checkboxStates.map((state) => state ?? false).toList();
    });
  }

  void saveCheckboxState(int index, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('checkedList$index', value);
  }

  Future<String?> getTask() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('taskTitleList');
  }

  Future<String?> getDate() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('dateValueList');
  }

  Future<String?> getPrio() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('prioValueList');
  }

  var time = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 1),
            child: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {},
            ),
          ),
          title: const Center(
            child: Padding(
              padding: EdgeInsets.only(right: 20),
              child: Text('TODO'),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                ThemeData(primaryColorDark: Colors.black);
              },
              icon: const Icon(
                Icons.dark_mode_outlined,
                color: Colors.white,
              ),
            ),
          ],
          backgroundColor: Theme.of(context).colorScheme.background),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 39, top: 35),
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade900,
                          spreadRadius: 1,
                          blurRadius: 12,
                          offset: const Offset(0, 7),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 35,
                      backgroundColor: const Color.fromARGB(241, 12, 4, 4),
                      child: Image.asset('assets/profile.png'),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40, left: 45),
              child: Column(
                children: [
                  const Row(
                    children: [
                      Text(
                        'Hello, Amjad.',
                        style: TextStyle(color: Colors.white, fontSize: 29),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Row(
                      children: [
                        Text(
                          'Looks like feel good.',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.50),
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'You have ${taskList.length} task${taskList.length == 1 ? '' : 's'} to do today',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.50),
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      Text(
                        'TODAY : ${time.day}-${time.month}-${time.year}',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 410,
              height: 380,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: taskList.length,
                itemBuilder: (
                  context,
                  index,
                ) {
                  return Container(
                    height: 370,
                    width: 300,
                    color: const Color.fromARGB(0, 252, 252, 252),
                    child: Card(
                      color: Colors.white,
                      elevation: 25,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(
                                  Icons.task,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                                const SizedBox(
                                  width: 112,
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.edit,
                                  ),
                                  onPressed: () {
                                    titlecontroller.text = taskList[index];
                                    datecontroller.text = datesList[index];
                                    prioritycontroller.text = priosList[index];
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditTaskPage(
                                          index: index,
                                          title: titlecontroller.text,
                                          date: datecontroller.text,
                                          prio: prioritycontroller.text,
                                        ),
                                      ),
                                    ).then((result) {
                                      if (result != null &&
                                          result is Map<String, String>) {
                                        setState(() {
                                          taskList[index] = result['title']!;
                                          datesList[index] = result['date']!;
                                          priosList[index] = result['prio']!;
                                        });
                                      }
                                    });
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text("Delete Task"),
                                          content: const Text(
                                              "Are you sure you want to delete this task?"),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text("Cancel"),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  taskList.removeAt(index);
                                                  datesList.removeAt(index);
                                                  priosList.removeAt(index);
                                                });
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text("Delete"),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 150),
                            Row(
                              children: [
                                Text(
                                  datesList[index],
                                  style: TextStyle(
                                      fontSize: 15,
                                      overflow: TextOverflow.fade,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.withOpacity(0.85)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                Text(
                                  priosList[index],
                                  style: TextStyle(
                                      fontSize: 17,
                                      overflow: TextOverflow.fade,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black.withOpacity(0.65)),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  taskList[index],
                                  style: TextStyle(
                                      fontSize: 35,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.w500,
                                      overflow: TextOverflow.fade),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                if (checkedList[index])
                                  const Text(
                                    'COMPLETED',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                if (!checkedList[index])
                                  const Text(
                                    'NOT COMPLETED',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                                Checkbox(
                                  value: checkedList[index],
                                  activeColor:
                                      const Color.fromARGB(218, 17, 202, 33),
                                  onChanged: (newValue) {
                                    setState(() =>
                                        checkedList[index] = newValue ?? false);
                                        saveCheckboxState(index, newValue ?? true);
                                  },
                                  side: const BorderSide(
                                      color: Color.fromARGB(255, 2, 2, 2)),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTaskPage()),
          );
        },
        child: const Icon(
          Icons.add,
          color: Color.fromARGB(255, 45, 92, 233),
        ),
      ),
    );
  }
  }
