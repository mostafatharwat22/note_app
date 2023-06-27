import 'package:flutter/material.dart';
import 'package:note_app/data/local_data/sql.dart';
import 'package:note_app/model/note_model.dart';
import 'package:note_app/views/nots_card.dart';
import 'package:note_app/views/text_form.dart';


class NoteScreen extends StatefulWidget {
  const NoteScreen({Key? key}) : super(key: key);

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  @override
  Widget build(BuildContext context) {
    setState(() {});
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NotText(),
                  ));
              setState(() {});
            },
            child: const Icon(
              Icons.add,
            )),
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            ),
          ],
          backgroundColor: Colors.lightBlue,
          title: const Text(
            "NoteApp",
            style: TextStyle(
              fontSize: 30,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: SqlHelper.getAllNots(),
          builder: (context, AsyncSnapshot<List<NotsModel>?> snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting){
              return const CircularProgressIndicator();
            }else if(snapshot.hasError){
              return Center(child: Text(snapshot.error.toString()));
            }
            if(snapshot.hasData){
              if(snapshot.data!=null){
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return NotsCard(
                      note: snapshot.data![index],
                      onTap: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  NotText(note: snapshot.data![index]),
                            ));
                        setState(() {});
                      },
                      onLongPress: () async {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Are you sure deleted this note"),
                              actions: [
                                ElevatedButton(
                                  style: const ButtonStyle(
                                    backgroundColor:
                                    MaterialStatePropertyAll(Colors.red),
                                  ),
                                  onPressed: ()async {
                                    SqlHelper.DeletNote(snapshot.data![index]);
                                    Navigator.pop(context);
                                    setState(() {});
                                  },
                                  child: const Text("Yes"),
                                ),
                                ElevatedButton(
                                  onPressed: (){
                                    Navigator.pop(context);
                                    setState(() {});
                                  },
                                  child: const Text("No"),),
                              ],
                            );
                          },
                        );
                      },
                    );
                  },
                  itemCount: snapshot.data!.length,
                );
              }else{
                return const Center(
                  child: Text("No nots Add yet"),
                );
              }
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
