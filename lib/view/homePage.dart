import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqlapi/controller/Apiclass.dart';
import 'package:sqlapi/controller/DBhelper.dart';
import 'package:sqlapi/controller/homeController.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController hmc = Get.put(HomeController());
  TextEditingController id = TextEditingController();

  @override
  void initState() {
    super.initState();
    hmc.getData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  return Add();
                },
                icon: Icon(Icons.add))
          ],
        ),
        body: Obx(
          ()=> ListView.builder(
            itemCount: hmc.l1.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Text("${hmc.l1[index]['postId']}"),
                title: Text("${hmc.l1[index]['name']}"),
                // subtitle: Text("${hmc.l1[index]['name']}"),
                // trailing: Text("${hmc.l1[index]['body']}"),
              );
            },
          ),
        ),
      ),
    );
  }

  void Add() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              TextField(
                controller: id,
                decoration: InputDecoration(
                  hintText: "id",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () async {
                    var list = await Apiclass().GetData(id.text);

                    for (int i = 0; i < list.length; i++) {
                      DBHelper.ints.insertDB(
                        id: list[i].postId,
                        body: list[i].body,
                        email: list[i].email,
                        name: list[i].name,
                        postId: list[i].postId,
                      );
                      hmc.getData();
                    }
                  },
                  child: Text("add")),
            ],
          );
        });
  }
}
