import 'package:admin/providers/admin_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/chat_messages.dart';

class InboxScreen extends StatefulWidget {
  static const String routeName = 'inbox-screen';

  const InboxScreen({super.key});

  @override
  State createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  final _messageController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _messageController.dispose();
    super.dispose();
  }

  void _submitMessage(String passedId) async {
    final enteredMessage = _messageController.text;
    if (enteredMessage.trim().isEmpty) {
      return;
    }

    FocusScope.of(context).unfocus();
    _messageController.clear();

    FirebaseFirestore.instance.collection('chat').add({
      'text': enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': FirebaseAuth.instance.currentUser!.uid,
      'complaintId': passedId
    });
  }

  @override
  Widget build(BuildContext context) {
    final passedId = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Private Chat'),
      ),
      body: Column(
        children: [
          const Expanded(child: ChatMessages()),

          // for new messages
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 1, bottom: 14),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    textCapitalization: TextCapitalization.sentences,
                    autocorrect: true,
                    enableSuggestions: true,
                    decoration:
                    const InputDecoration(labelText: 'Send a messages...'),
                  ),
                ),
                IconButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    _submitMessage(passedId);
                  },
                  icon: const Icon(Icons.send),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
