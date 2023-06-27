import 'package:flutter/material.dart';
import 'package:note_app/data/local_data/sql.dart';
import 'package:note_app/model/note_model.dart';
class NotText extends StatefulWidget {
  const NotText({Key? key, this.note}) : super(key: key);
  final NotsModel? note;

  @override
  State<NotText> createState() => _NotTextState();
}

class _NotTextState extends State<NotText> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController DescirpoinController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title:  Text(
          widget.note == null? "Add Nots" : "EditNote",
          style: const TextStyle(
            fontSize: 25,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 15, left: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: titleController,
              validator:  (value) {},
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 30),
                labelText: " Enter title Note ",
                hintText: "  Enter your title",
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: DescirpoinController,
              validator:  (value) {},
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 70),
                labelText: "  Enter Descirpoin Note",
                hintText: " Enter your Descirpoin",
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                onPrimary: Colors.white,
                shadowColor: Colors.greenAccent,
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0)),
                minimumSize: const Size(500, 40),
              ),
              onPressed: ()async {
                final title= titleController.value.text;
                final Descirpoin= DescirpoinController.value.text;
                final NotsModel model= NotsModel(title: title, Descirpion:Descirpoin, id: widget.note?.id);
                if(widget.note==null){
                  await SqlHelper.AddNote(model);
                }else{
                  await SqlHelper.UpdeteNote(model);
                }
                Navigator.pop(context);
                setState(() {});
              },
              child: const Text(
                "Save",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
