import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/homepage.dart';


class AddTaskPage extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController priorityController = TextEditingController();
  

  AddTaskPage({Key? key}) : super(key: key);

  Future<void> saveTask(BuildContext context) async {
    if (titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a title.'),duration:Durations.short1,
        ),
      );
      return;
    }
    try {
      final prefs = await SharedPreferences.getInstance();
      taskList.add(titleController.text);
      await prefs.setStringList('taskTitleList', taskList);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Task added successfully.'),
          duration:Duration(seconds: 1),
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error saving task: $error'),
        ),
      );
    }
  }

  Future<void> saveDate(BuildContext context) async {
    if (dateController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter Date.'),
        ),
      );
      return;
    }
    try {
      final prefs = await SharedPreferences.getInstance();
      datesList.add(dateController.text);
      await prefs.setStringList('datesValueList', datesList);

    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error saving task: $error'),
        ),
      );
    }
  }

  Future<void> savePrio(BuildContext context) async {
    if (priorityController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter PRIORITY.'),
        ),
      );
      return;
    }
    try {
      final prefs = await SharedPreferences.getInstance();
      priosList.add(priorityController.text);
      await prefs.setStringList('prioValueList', priosList);

    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error saving priority: $error'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Homepage()),
            );
          },
        ),
        centerTitle: true,
        title: const Text(
          'Add Task',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 70),
              Stack(
                children: <Widget>[
                  Container(
                    width: 330,
                    height: 80,
                    margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                    padding: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color:Theme.of(context).colorScheme.secondary, width: 1),
                      borderRadius: BorderRadius.circular(20),
                      shape: BoxShape.rectangle,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: TextField(
                            controller: titleController,
                            decoration:
                                const InputDecoration(border: InputBorder.none),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 30,
                    top: 12,
                    child: Container(
                      padding: const EdgeInsets.only(
                          bottom: 10, left: 10, right: 10),
                      color: Theme.of(context).colorScheme.background,
                      child: const Text(
                        'Title',
                        style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0), fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
              Stack(
                children: <Widget>[
                  Container(
                    width: 330,
                    height: 80,
                    margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                    padding: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).colorScheme.secondary, width: 1),
                      borderRadius: BorderRadius.circular(20),
                      shape: BoxShape.rectangle,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: TextField(
                            controller: dateController,
                            decoration:
                                const InputDecoration(border: InputBorder.none),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 30,
                    top: 12,
                    child: Container(
                      padding: const EdgeInsets.only(
                          bottom: 10, left: 10, right: 10),
                      color: Theme.of(context).colorScheme.background,
                      child: const Text(
                        'Date',
                        style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0), fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
              Stack(
                children: <Widget>[
                  Container(
                    width: 330,
                    height: 80,
                    margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                    padding: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).colorScheme.secondary, width: 1),
                      borderRadius: BorderRadius.circular(20),
                      shape: BoxShape.rectangle,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: TextField(
                            controller: priorityController,
                            decoration:
                                const InputDecoration(border: InputBorder.none),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 30,
                    top: 12,
                    child: Container(
                      padding: const EdgeInsets.only(
                          bottom: 10, left: 10, right: 10),
                      color: Theme.of(context).colorScheme.background,
                      child: const Text(
                        'Priority',
                        style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0), fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                height: 60,
                width: 280,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(255, 45, 92, 233),
                ),
                child: IconButton(
                  onPressed: () async {
                    await saveTask(context);
                    await saveDate(context);
                    await savePrio(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Homepage()),
                    );
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}