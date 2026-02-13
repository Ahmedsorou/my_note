import 'package:flutter/material.dart';
import 'package:my_note/hive_helper/hive_helper.dart';

import 'note_item.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    NoteHelper.getAllNote().then((_) {
      setState(() {});
    });
  }
  Future<void> _showNoteDialog({
    required String title,
    required String buttonText,
    required VoidCallback onPressed,
  }) async {
    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: "Enter note...",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: onPressed,
            child: Text(buttonText),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmDeleteAll() async {
    bool? confirm = await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Confirm"),
        content: const Text("Are you sure you want to delete all notes?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Yes"),
          ),
        ],
      ),
    );

    if (confirm == true) {
      NoteHelper.deleteAllNote();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.amber.shade400,
        centerTitle: false,
        title: const Text(
          "My Notes",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _confirmDeleteAll,
            icon: const Icon(Icons.delete_sweep, color: Colors.red,size: 40,),
          )
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        onPressed: () {
          controller.clear();
          _showNoteDialog(
            title: "Add Note",
            buttonText: "Add",
            onPressed: () {
              if (controller.text.trim().isEmpty) return;
              NoteHelper.addNote(controller.text.trim());
              setState(() {});
              Navigator.pop(context);
            },
          );
        },
        child: const Icon(Icons.add, size: 28,color: Colors.white,),
      ),

      body: NoteHelper.notes.isEmpty
          ? const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.note_alt_outlined,
                size: 80, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              "No Notes Yet",
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.symmetric(
            horizontal: 16, vertical: 10),
        itemCount: NoteHelper.notes.length,
        itemBuilder: (context, i) {
          return NoteItem(
            note: NoteHelper.notes[i],
            onDelete: () {
              NoteHelper.deleteNote(i);
              setState(() {});
            },
            onTap: () {
              controller.text = NoteHelper.notes[i];
              _showNoteDialog(
                title: "Update Note",
                buttonText: "Update",
                onPressed: () {
                  if (controller.text.trim().isEmpty) return;
                  NoteHelper.updateNote(
                      controller.text.trim(), i);
                  setState(() {});
                  Navigator.pop(context);
                },
              );
            },
          );
        },
      ),
    );
  }
}


