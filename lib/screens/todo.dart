import 'package:app_assigment_2/screens/About.dart';
import 'package:app_assigment_2/screens/DetailTask.dart';
import 'package:flutter/material.dart';
import 'dart:convert'; // For jsonDecode
import 'package:flutter/services.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoHomePage(),
    );
  }
}

class TodoHomePage extends StatefulWidget {
  const TodoHomePage({super.key});

  @override
  State<TodoHomePage> createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  List<dynamic> tasks = []; // List to store JSON data.

  @override
  void initState() {
    super.initState();
    _fetchTasks();
  }

  Future<void> _fetchTasks() async {
    final String response = await rootBundle.loadString('assets/data/todos.json');
    final List<dynamic> decodedData = json.decode(response);  

    setState(() {
      tasks = decodedData;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 244, 27, 27), 
              ),
              accountName: Text(
                'Fazril Ramadhan',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              accountEmail: Text('fazrilramadhan2000@gmail.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  color: Colors.blue,
                  size: 50,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('Taks'),
              onTap: () {
                
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting
            const Row(
              children: const [
                CircleAvatar(
                  radius: 20,
                  child: Icon(Icons.person),
                ),
                SizedBox(width: 10),
                Text(
                  'Hello, Fazril Swarowsky.\nLooks like feel good.\nYou have some tasks to do today.',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Task cards
            // Column(
            //   children: tasks.map((e) {
            //     return Text(e.toString());
            //   }).toList(),
            // ),
            Expanded(
              child: tasks.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    var e = tasks[index] as Map<String,dynamic>;
                  return GestureDetector(
                    onTap: () {
                      final subtask = (e['subtasks'] as List).map((el) => {'title':el['title'],'status':el['status']}).toList();
                      final subcomments = (e['comments'] as List).map((els) => {'text':els['comment'],'time':els['timestamp']}).toList();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(
                            title: tasks[index]['title'],
                            description: tasks[index]['description'],
                            startDate: tasks[index]['startDate'],
                            endDate: tasks[index]['dueDate'],
                            imagePath: tasks[index]['backgroundImage'],
                            tasks: subtask,
                            comments: subcomments,
                          ),
                        ),
                      );
                    },
                    child: TaskCard(
                      color: Color(int.parse(tasks[index]['color'])),
                      taskName: tasks[index]['title'],
                      tasks: tasks[index]['totalTask'],
                    ),
                  );
                },

                ),
            )
          ],
        ),
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  final Color color;
  final String taskName;
  final int tasks;

  const TaskCard({
    super.key,
    required this.color,
    required this.taskName,
    required this.tasks,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.timer, color: Colors.white),
            const Spacer(),
            Text(
              '$tasks Tasks',
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
            const SizedBox(height: 8),
            Text(
              taskName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: tasks / 10,
              backgroundColor: Colors.white.withOpacity(0.3),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}