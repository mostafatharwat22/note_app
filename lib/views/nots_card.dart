import 'package:flutter/material.dart';
import 'package:note_app/model/note_model.dart';
class NotsCard extends StatelessWidget {
  const NotsCard({Key? key, required this.note, required this.onTap, required this.onLongPress,}) : super(key: key);
  final NotsModel note;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress:onLongPress ,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  color: Colors.tealAccent,
                ),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      note.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black),
                    ),
                    const Divider(
                      thickness: 2,
                      endIndent: 20,
                      indent: 20,
                    ),
                    Text(
                      note.Descirpion,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
