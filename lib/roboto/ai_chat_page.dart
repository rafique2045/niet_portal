import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:niet_portal/roboto/models/chat_message.dart';
import 'package:niet_portal/roboto/models/chat_session.dart';
import 'package:niet_portal/roboto/providers/chat_provider.dart';
import 'package:niet_portal/roboto/providers/session_provider.dart';
import 'package:provider/provider.dart';

class AiChatPage extends StatelessWidget {
  const AiChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => SessionProvider())],
        child: SessionListScreen());
  }
}

class SessionListScreen extends StatelessWidget {
  const SessionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('MR.ROBOTO'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios_new)),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_comment_rounded),
            onPressed: () async {
              final newSessionId =
                  await context.read<SessionProvider>().createNewSession();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                    create: (_) => ChatProvider(newSessionId),
                    child: ChatScreen(
                      session: context
                          .read<SessionProvider>()
                          .sessions
                          .firstWhere((s) => s.id == newSessionId),
                    ),
                  ),
                ),
              );
            },
            tooltip: 'New Chat',
          ),
        ],
      ),
      body: Consumer<SessionProvider>(
        builder: (context, sessionProvider, child) {
          if (sessionProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (sessionProvider.sessions.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.chat_bubble_outline,
                    size: 80,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 20),
                  const Text('No chats yet.', style: TextStyle(fontSize: 18)),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      final newSessionId = await context
                          .read<SessionProvider>()
                          .createNewSession();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ChangeNotifierProvider(
                            create: (_) => ChatProvider(newSessionId),
                            child: ChatScreen(
                              session: context
                                  .read<SessionProvider>()
                                  .sessions
                                  .firstWhere((s) => s.id == newSessionId),
                            ),
                          ),
                        ),
                      );
                    },
                    child: const Text('Start a New Chat'),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: sessionProvider.sessions.length,
            itemBuilder: (context, index) {
              final session = sessionProvider.sessions[index];
              return ListTile(
                leading: const Icon(Icons.chat_bubble_outline_rounded),
                title: Text(session.title),
                subtitle: Text(
                  'Created on ${DateFormat.yMMMd().format(session.createdAt)}',
                ),
                trailing: PopupMenuButton(
                  itemBuilder: (context) => [
                    const PopupMenuItem(value: 'rename', child: Text('Rename')),
                    const PopupMenuItem(value: 'delete', child: Text('Delete')),
                  ],
                  onSelected: (value) {
                    if (value == 'rename') {
                      _showRenameDialog(context, session, sessionProvider);
                    } else if (value == 'delete') {
                      sessionProvider.deleteSession(session.id!);
                    }
                  },
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ChangeNotifierProvider(
                        create: (_) => ChatProvider(session.id!),
                        child: ChatScreen(session: session),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  void _showRenameDialog(
    BuildContext context,
    ChatSession session,
    SessionProvider sessionProvider,
  ) {
    final controller = TextEditingController(text: session.title);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Rename Session'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(labelText: 'New Title'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                sessionProvider.renameSession(session.id!, controller.text);
                Navigator.of(context).pop();
              }
            },
            child: const Text('Rename'),
          ),
        ],
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  final ChatSession session;
  const ChatScreen({super.key, required this.session});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  File? _selectedImageFile;

  void _sendMessage() {
    final chatProvider = context.read<ChatProvider>();
    if (_textController.text.trim().isNotEmpty || _selectedImageFile != null) {
      chatProvider.sendMessage(
        text: _textController.text.trim(),
        imageFile: _selectedImageFile,
      );
      _textController.clear();
      setState(() {
        _selectedImageFile = null;
      });
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _selectedImageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ChatProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.session.title),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                padding: const EdgeInsets.all(8.0),
                itemCount: chatProvider.messages.length,
                itemBuilder: (context, index) {
                  final message = chatProvider.messages[index];
                  final isUser = message.sender == MessageSender.user;
                  final isGemini = message.sender == MessageSender.gemini;

                  return Align(
                    alignment:
                        isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4.0),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 8.0,
                      ),
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.85,
                      ),
                      decoration: BoxDecoration(
                        color: isUser
                            ? Colors.blue.shade100
                            : Colors.grey.shade200,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(12),
                          topRight: const Radius.circular(12),
                          bottomLeft: isUser
                              ? const Radius.circular(12)
                              : const Radius.circular(4),
                          bottomRight: isUser
                              ? const Radius.circular(4)
                              : const Radius.circular(12),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: isUser
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          if (message.imageFile != null)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.file(
                                  message.imageFile!,
                                  width: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          MarkdownBody(
                            data: message.text.isEmpty &&
                                    isGemini &&
                                    message.isLoading
                                ? '...'
                                : message.text,
                            selectable: true,
                            builders: {'code': CodeBlockBuilder()},
                            styleSheet: MarkdownStyleSheet.fromTheme(
                              Theme.of(context),
                            ).copyWith(
                              p: TextStyle(
                                fontSize: 16,
                                color: isUser ? Colors.black87 : Colors.black87,
                              ),
                              code: const TextStyle(
                                backgroundColor: Colors.black12,
                                fontFamily: 'monospace',
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                DateFormat('hh:mm a').format(message.timestamp),
                                style: TextStyle(
                                  fontSize: 10,
                                  color:
                                      isUser ? Colors.black54 : Colors.black54,
                                ),
                              ),
                              if (isGemini &&
                                  !message.isLoading &&
                                  message.text.isNotEmpty) ...[
                                const SizedBox(width: 8),
                                SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    icon: const Icon(
                                      Icons.copy_all_rounded,
                                      size: 14,
                                    ),
                                    tooltip: 'Copy response',
                                    onPressed: () {
                                      Clipboard.setData(
                                        ClipboardData(text: message.text),
                                      );
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text('Response copied!'),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                              if (message.isLoading && isGemini) ...[
                                const SizedBox(width: 8),
                                SizedBox(
                                  width: 12,
                                  height: 12,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      isUser ? Colors.blue : Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            if (chatProvider.isLoading)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.grey.shade600,
                            ),
                          ),
                        ),
                        const SizedBox(width: .8),
                        Text(
                          'ROBOTO is thinking...',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            if (chatProvider.error != null)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.error_outline, color: Colors.red.shade700),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: Text(
                          chatProvider.error!,
                          style: TextStyle(color: Colors.red.shade700),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (_selectedImageFile != null)
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 8.0),
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: FileImage(_selectedImageFile!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
                          onPressed: () {
                            setState(() {
                              _selectedImageFile = null;
                            });
                          },
                        ),
                      ],
                    ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _textController,
                          decoration: InputDecoration(
                            hintText: 'Enter your message...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                          ),
                          onSubmitted: (value) => _sendMessage(),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.image_outlined),
                        color: Colors.blueAccent,
                        onPressed: _pickImage,
                        tooltip: 'Attach Image',
                      ),
                      IconButton(
                        icon: const Icon(Icons.send_rounded),
                        color: Colors.blueAccent,
                        onPressed: _sendMessage,
                        tooltip: 'Send Message',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CodeBlockBuilder extends MarkdownElementBuilder {
  @override
  Widget visitElementAfter(element, TextStyle? preferredStyle) {
    final String text = element.textContent;
    final String language =
        element.attributes['class']?.replaceFirst('language-', '') ?? '';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: const BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (language.isNotEmpty)
                  Text(
                    language,
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                SizedBox(
                  height: 24,
                  width: 24,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                      Icons.copy,
                      size: 14,
                      color: Colors.white70,
                    ),
                    tooltip: 'Copy Code',
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: text));
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12.0),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
            child: Text(
              text,
              style: const TextStyle(
                fontFamily: 'monospace',
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
