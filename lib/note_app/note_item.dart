import 'dart:ui';

import 'package:flutter/material.dart';

class NoteItem extends StatelessWidget {
  final String note;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const NoteItem({
    required this.note,
    required this.onDelete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(Icons.sticky_note_2,
                color: Colors.deepPurple, size: 30),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                note,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            IconButton(
              onPressed: onDelete,
              icon: const Icon(Icons.delete,
                  color: Colors.redAccent),
            ),
          ],
        ),
      ),
    );
  }
}