import 'package:flutter/material.dart';
import 'db.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController truck = TextEditingController();
  TextEditingController entry = TextEditingController();
  TextEditingController exit = TextEditingController();

  List data = [];

  @override
  void initState() {
    super.initState();
    load();
  }

  void load() async {
    data = await DB.getAll();
    setState(() {});
  }

  void save() async {
    if (truck.text.isEmpty || entry.text.isEmpty || exit.text.isEmpty) return;

    await DB.insert(
      truck.text,
      double.parse(entry.text),
      double.parse(exit.text),
    );

    truck.clear();
    entry.clear();
    exit.clear();

    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        title: Text("WeighMaster PRO"),
        backgroundColor: Colors.green,
      ),

      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [

            TextField(
              controller: truck,
              decoration: InputDecoration(labelText: "Truck Number"),
            ),

            TextField(
              controller: entry,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Entry Weight"),
            ),

            TextField(
              controller: exit,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Exit Weight"),
            ),

            SizedBox(height: 10),

            ElevatedButton(
              onPressed: save,
              child: Text("SAVE"),
            ),

            SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (c, i) {

                  return Card(
                    color: Colors.grey[900],
                    child: ListTile(
                      title: Text(
                        data[i]['truck'],
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        "Entry: ${data[i]['entry']} | Exit: ${data[i]['exit']}\nNet: ${data[i]['net']} kg",
                        style: TextStyle(color: Colors.green),
                      ),
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
