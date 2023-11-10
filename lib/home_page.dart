import 'package:crud_operation/title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  List<Add> titles = List.empty(growable: true);

  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Title List"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                textCapitalization: TextCapitalization.sentences,
                controller: titleController,
                maxLength: 12,
                decoration: InputDecoration(
                    hintText: "Add title",
                    labelText: "Title",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                textCapitalization: TextCapitalization.sentences,
                controller: descriptionController,
                maxLines: 3,
                decoration: InputDecoration(
                    hintText: "Add description",
                    labelText: "Description",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  selectedIndex!=-1?ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary:  Colors.black.withOpacity(0.2)
                      ),
                      onPressed: (){

                      },
                      child: Text("Save")): ElevatedButton(
                      onPressed: () {
                        String title = titleController.text.toString();
                        String description =
                            descriptionController.text.toString();
                        if (title.isNotEmpty && description.isNotEmpty) {
                          setState(() {
                            titleController.text = "";
                            descriptionController.text = "";
                            titles.add(
                                Add(title: title, description: description));
                          });
                          showToast('Task Added',
                            context: context,
                            animation: StyledToastAnimation.scale,
                            reverseAnimation: StyledToastAnimation.fade,
                            position: StyledToastPosition.center,
                            animDuration: Duration(seconds: 1),
                            duration: Duration(seconds: 2),
                            curve: Curves.elasticOut,
                            reverseCurve: Curves.linear,
                          );
                        }


                      },
                      child: Text("Save")),
                  selectedIndex == -1
                      ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary:  Colors.black.withOpacity(0.1),

                    ),
                      onPressed: (){

                      },
                      child: Text("Update"))
                      : ElevatedButton(
                          onPressed: () {

                            String title = titleController.text.toString();
                            String description =
                                descriptionController.text.toString();
                            setState(() {
                              titleController.text = "";
                              descriptionController.text = "";
                              titles[selectedIndex].title = title;
                              titles[selectedIndex].description = description;
                              selectedIndex = -1;
                              showToast('Task Updated',
                                context: context,
                                animation: StyledToastAnimation.scale,
                                reverseAnimation: StyledToastAnimation.fade,
                                position: StyledToastPosition.center,
                                animDuration: Duration(seconds: 1),
                                duration: Duration(seconds: 2),
                                curve: Curves.elasticOut,
                                reverseCurve: Curves.linear,
                              );

                            });
                          },
                          child: Text("Update"))
                ],
              ),
              SizedBox(
                height: 15,
              ),
              titles.isEmpty
                  ? Text(
                      "No task available",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black12),
                    )
                  : Expanded(
                      child: ListView.builder(
                          itemCount: titles.length,
                          itemBuilder: (context, index) => getRow(index)),
                    )
            ],
          ),
        ),
      ),
    );
  }

  Widget getRow(int index) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 25,
              child: Center(
                  child: Text(
                titles[index].title[0],
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 30),
              )),
              backgroundColor:
                  index % 2 == 0 ? Colors.deepPurple : Colors.purple,
            ),
            title: Text(titles[index].title,style: TextStyle(fontWeight: FontWeight.bold),),
            subtitle: Text(titles[index].description,style: TextStyle(color: Colors.black.withOpacity(0.4)),),
            trailing: Container(
              width: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () {
                        setState(() {
                          titleController.text = titles[index].title;
                          descriptionController.text =
                              titles[index].description;
                          setState(() {
                            selectedIndex = index;
                          });
                        });
                      },
                      child: Icon(Icons.edit)),
                  InkWell(
                      onTap: () {
                        setState(() {
                          titles.removeAt(index);
                        });
                      },
                      child: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
