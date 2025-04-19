import 'package:flutter/material.dart';
import 'package:forkify_app/data/constants.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({
    super.key,
    required this.message,
    required this.icon,
    this.issue,
  });
  final String message;
  final bool? issue;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              children: [
                Icon(icon, color: Kcolors.primaryColor, size: 60),
                SizedBox(width: 15),
                Expanded(child: Text(message, style: TextStyle(fontSize: 19))),
              ],
            ),
          ),
        ),
        // SizedBox(height: 20),
      ],
    );
  }
}
