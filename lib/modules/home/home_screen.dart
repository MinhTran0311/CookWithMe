import 'package:cook_with_me/core/provider/recipe_provider.dart';
import 'package:cook_with_me/modules/common/screen/screen_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenFrame(
      body: Container(
        height: 900,
        child: Column(
            children: [AddNoteWidget(), Expanded(child: NoteListWidget())]),
      ),
    );
  }
}

class AddNoteWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _controller = TextEditingController();

    return Column(
      children: [
        TextField(
          controller: _controller,
          decoration: const InputDecoration(
            hintText: 'Enter note',
            border: OutlineInputBorder(),
          ),
          maxLines: null,
        ),
        TextButton(
          onPressed: () {
            if (_controller.text.trim().isEmpty) return;

            ref.watch(recipeProvider.notifier).addRecipe(_controller.text);
            _controller.clear();
          },
          child: const Text('Add note'),
        ),
      ],
    );
  }
}

class NoteListWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notes = ref.watch(recipeProvider);

    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes[index];
        return Card(
          child: ListTile(
            title: Text(note.name),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () =>
                  ref.watch(recipeProvider.notifier).deleteRecipe(note.id),
            ),
          ),
        );
      },
    );
  }
}
