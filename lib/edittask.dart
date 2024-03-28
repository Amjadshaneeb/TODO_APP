import 'package:flutter/material.dart';
// import 'package:todo/homepage.dart';

class EditTaskPage extends StatefulWidget {
  const EditTaskPage({
    Key? key,
    required this.title,
    required this.date,
    required this.prio,
    required this.index,
  }) : super(key: key);

  final String title;
  final String date;
  final String prio;
  final int index;

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  late TextEditingController dateController;
  late TextEditingController titleController;
  late TextEditingController priorityController;

  @override
  void initState() {
    super.initState();
    dateController = TextEditingController(text: widget.date);
    titleController = TextEditingController(text: widget.title);
    priorityController = TextEditingController(text: widget.prio);
    // print("$taskList , $datesList , $priosList");
  }

  @override
  Widget build(BuildContext context) {
    // print("$taskList , $datesList , $priosList");

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Task',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: <Widget>[
                  Container(
                    width: 330,
                    height: 80,
                    margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                    padding: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).colorScheme.secondary,
                          width: 1),
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
                          color: Theme.of(context).colorScheme.secondary,
                          width: 1),
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
                            keyboardType: TextInputType.datetime,
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
                          color: Theme.of(context).colorScheme.secondary,
                          width: 1),
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
              const SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, {
                        'title': titleController.text,
                        'date': dateController.text,
                        'prio': priorityController.text,
                      });
                    },
                    child: const Text('Update Task'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
