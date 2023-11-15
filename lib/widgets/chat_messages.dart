import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../constants/global_variables.dart';
import 'message_bubble.dart';

class ChatMessages extends StatefulWidget {
  const ChatMessages({super.key});

  @override
  State<ChatMessages> createState() => _ChatMessagesState();
}

class _ChatMessagesState extends State<ChatMessages> {
  @override
  Widget build(BuildContext context) {
    final passedId = ModalRoute.of(context)!.settings.arguments as String;
    final authenticatedUser = FirebaseAuth.instance.currentUser!;
    return StreamBuilder(
      stream: db
          .collection('chat')
          .where('complaintId', isEqualTo: passedId)
          .orderBy(
        'createdAt',
        descending: true,
      )
          .snapshots(),
      builder: (ctx, chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (!chatSnapshot.hasData || chatSnapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text('No messages found'),
          );
        }
        if (chatSnapshot.hasError) {
          return const Center(
            child: Text('Something went wrong...'),
          );
        }
        final loadedMessages = chatSnapshot.data!.docs;
        return ListView.builder(
          padding: const EdgeInsets.only(
            bottom: 40,
            left: 13,
            right: 13,
          ),
          reverse: true,
          itemCount: loadedMessages.length,
          itemBuilder: (ctx, i) {
            final chatMessage = loadedMessages[i].data();
            final currentMessageUserId = chatMessage['userId'];
            final nextChatMessage = i + 1 < loadedMessages.length
                ? loadedMessages[i + 1].data()
                : null;
            final nextMessageUserId = nextChatMessage != null
                ? nextChatMessage['userId']
                : null;
            final nextUserIsSame =
                nextMessageUserId == currentMessageUserId;
            if (nextUserIsSame) {
              return MessageBubble.next(
                message: chatMessage['text'],
                isMe: authenticatedUser.uid == currentMessageUserId,
              );
            } else {
              return MessageBubble.first(
                // userImage: chatMessage['userImage'],
                // username: chatMessage['username'],
                message: chatMessage['text'],
                isMe: authenticatedUser.uid == currentMessageUserId,
              );
            }
          },
        );
      },
    );
  }
}

// Provider.of<UserProvider>(context).adminModel == null
// ? const Center(child: CircularProgressIndicator())
//     : Column(
// children: <Widget>[
// Expanded(
// child: ListView.builder(
// itemBuilder: (ctx, index) => ListTile(
// title: Text(Provider.of<UserProvider>(context)
//     .messageModel[index]
//     .content ??
// ''),
// subtitle: Text(
// 'Sender: ${Provider.of<UserProvider>(context).messageModel[index].sender ?? ''}'),
// ),
// itemCount:
// Provider.of<UserProvider>(context).messageModel.length,
// ),
// ),
// Padding(
// padding: const EdgeInsets.all(8.0),
// child: Row(
// children: <Widget>[
// Expanded(
// child: TextField(
// controller: messageController,
// decoration: const InputDecoration(
// labelText: 'Type your message',
// ),
// ),
// ),
// IconButton(
// icon: const Icon(
// Icons.send,
// ),
// onPressed: () {
// MessageProvider.sendMessage(
// firebase.currentUser!.uid,
// Provider.of<UserProvider>(context, listen: false)
//     .adminModel!
//     .uid!,
// messageController.text);
// messageController.clear();
// },
// ),
// ],
// ),
// ),
// ],
// ),
