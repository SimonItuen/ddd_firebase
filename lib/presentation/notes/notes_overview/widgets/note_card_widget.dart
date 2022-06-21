import 'package:auto_route/auto_route.dart';
import 'package:ddd_firebase/application/notes/note_actor/note_actor_bloc.dart';
import 'package:ddd_firebase/domain/notes/note.dart';
import 'package:ddd_firebase/domain/notes/todo_item.dart';
import 'package:ddd_firebase/presentation/routes/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kt_dart/kt.dart';

class NoteCard extends StatelessWidget {
  final Note note;

  const NoteCard({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var todoItems = emptyList();
    note.todos.value.fold((l) => null, (todos) => todoItems = todos);
    return InkWell(
      onTap: () {
        AutoRouter.of(context).push(NoteFormRoute(editNote: note));
      },
      onLongPress: () {
        final noteActorBloc = BlocProvider.of<NoteActorBloc>(context);
        _showDeletionDialog(context, noteActorBloc);
      },
      child: Card(
        color: note.color.getOrCrash(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                note.body.getOrCrash(),
                style: const TextStyle(fontSize: 18),
              ),
              if (todoItems.size > 0) ...[
                const SizedBox(height: 4),
                Wrap(
                  spacing: 8,
                  children: <Widget>[
                    ...todoItems.map((todo) => TodoDisplay(todo: todo)).iter
                  ],
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }

  void _showDeletionDialog(BuildContext context, NoteActorBloc noteActorBloc) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Selected note'),
            content: Text(
              note.body.getOrCrash(),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('CANCEL')),
              TextButton(
                  onPressed: () {
                    noteActorBloc.add(NoteActorEvent.deleted(note));
                  },
                  child: const Text('DELETE')),
            ],
          );
        });
  }
}

class TodoDisplay extends StatelessWidget {
  final TodoItem todo;

  const TodoDisplay({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (todo.done)
          const Icon(
            Icons.check_box,
            color: Colors.blue,
          ),
        if (!todo.done)
          Icon(
            Icons.check_box_outline_blank,
            color: Theme.of(context).disabledColor,
          ),
        Text(todo.name.getOrCrash()),
      ],
    );
  }
}
