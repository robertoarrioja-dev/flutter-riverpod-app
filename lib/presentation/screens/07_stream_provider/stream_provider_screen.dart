import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/presentation/providers/providers.dart';

class StreamProviderScreen extends StatelessWidget {
  const StreamProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stream Provider'),
      ),
      body: const StreamView(),
    );
  }
}

class StreamView extends ConsumerWidget {
  const StreamView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersInChatAsync = ref.watch(usersInChatProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (usersInChatAsync.isLoading) ...[
          const SizedBox(
            width: double.infinity,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ] else if (usersInChatAsync.hasError) ...[
          SizedBox(
            width: double.infinity,
            child: Center(
              child: Text('${usersInChatAsync.error}'),
            ),
          ),
        ] else if (usersInChatAsync.hasValue) ...[
          ListNamesWidget(
            users: usersInChatAsync.value!,
          )
        ]
      ],
    );
  }
}

class ListNamesWidget extends StatelessWidget {
  final List<String> users;
  const ListNamesWidget({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: users.length,
        itemBuilder: (BuildContext context, int index) {
          final user = users[index];

          return ListTile(
            title: Text(user),
          );
        },
      ),
    );
  }
}
