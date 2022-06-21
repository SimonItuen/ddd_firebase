import 'package:another_flushbar/flushbar_helper.dart';
import 'package:ddd_firebase/application/notes/note_form/note_form_bloc.dart';
import 'package:ddd_firebase/domain/notes/value_objects.dart';
import 'package:ddd_firebase/presentation/notes/note_form/misc/build_context_x.dart';
import 'package:ddd_firebase/presentation/notes/note_form/misc/todo_item_presentation_classes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:kt_dart/kt.dart';
import 'package:provider/provider.dart';

class TodoList extends StatelessWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<NoteFormBloc, NoteFormState>(
      listenWhen: (p, c) => p.note.todos.isFull != c.note.todos.isFull,
      listener: (context, state) {
        if (state.note.todos.isFull) {
          FlushbarHelper.createAction(
                  message: 'Want longer list? Activate premium 😍',
                  button: TextButton(
                      onPressed: () {},
                      child: const Text(
                        'BUY NOW',
                        style: TextStyle(color: Colors.yellow),
                      )),
                  duration: const Duration(seconds: 5))
              .show(context);
        }
      },
      child: Consumer<FormTodos>(
        builder: (context, formTodos, child) {
          return ImplicitlyAnimatedReorderableList<TodoItemPrimitive>(
            shrinkWrap: true,
            items: formTodos.value.asList(),
            areItemsTheSame: (oldItem, newItem) => oldItem.id == newItem.id,
            onReorderFinished: (item, from, to, newItems) {
              context.formTodos = newItems.toImmutableList();
              BlocProvider.of<NoteFormBloc>(context)
                  .add(NoteFormEvent.todosChanged(context.formTodos));
            },
            itemBuilder: (context, itemAnimation, item, index) {
              return Reorderable(
                key: ValueKey(item.id),
                builder: (context, dragAnimation, inDrag) {
                  return ScaleTransition(
                    scale: Tween<double>(begin: 1, end: 1.05)
                        .animate(dragAnimation),
                    child: TodoTile(
                      index: index,
                      elevation: dragAnimation.value * 4,
                    ),
                  );
                },
              );
            },
            removeItemBuilder: (context, itemAnimation, item) {
              return Reorderable(
                key: ValueKey(item.id),
                builder: (context, dragAnimation, inDrag) {
                  return ScaleTransition(
                    scale: Tween<double>(begin: 1, end: 0.0)
                        .animate(dragAnimation),
                    child: Container(),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class TodoTile extends HookWidget {
  final int index;
  final double elevation;

  const TodoTile({Key? key, required this.index, double? elevation})
      : elevation = elevation ?? 0,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final todo =
        context.formTodos.getOrElse(index, (_) => TodoItemPrimitive.empty());
    final textEditingController = useTextEditingController(text: todo.name);
    return Slidable(
      endActionPane: ActionPane(
          extentRatio: 0.25,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                context.formTodos = context.formTodos.minusElement(todo);
                BlocProvider.of<NoteFormBloc>(context)
                    .add(NoteFormEvent.todosChanged(context.formTodos));
              },
              label: 'Delete',
              backgroundColor: Colors.red,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(8),
            )
          ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: Material(
          elevation: elevation,
          borderRadius: BorderRadius.circular(8),
          animationDuration: const Duration(milliseconds: 50),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8)),
            child: ListTile(
              leading: Checkbox(
                value: todo.done,
                onChanged: (value) {
                  context.formTodos = context.formTodos.map(
                    (listTodo) => listTodo == todo
                        ? todo.copyWith(done: value!)
                        : listTodo,
                  );
                  BlocProvider.of<NoteFormBloc>(context)
                      .add(TodosChanged(context.formTodos));
                },
              ),
              title: TextFormField(
                controller: textEditingController,
                decoration: const InputDecoration(
                    hintText: 'Todo',
                    border: InputBorder.none,
                    counterText: ''),
                maxLength: TodoName.maxLength,
                onChanged: (value) {
                  context.formTodos = context.formTodos.map((listTodo) =>
                      listTodo == todo ? todo.copyWith(name: value) : listTodo);
                  BlocProvider.of<NoteFormBloc>(context)
                      .add(NoteFormEvent.todosChanged(context.formTodos));
                },
                validator: (_) {
                  return BlocProvider.of<NoteFormBloc>(context)
                      .state
                      .note
                      .todos
                      .value
                      .fold(
                          //Failure steaming from the TodoList length should NOT be displayed by individual TextFormFields
                          (f) => null,
                          (todolist) => todolist.get(index).name.value.fold(
                              (f) => f.maybeMap(
                                  empty: (_) => 'Cannot be empty',
                                  exceedingLength: (_) => 'Too long',
                                  multiline: (_) =>
                                      'Has to be in a single line',
                                  orElse: () => null),
                              (_) => null));
                },
              ),
              trailing: const Handle(
                child: Icon(Icons.list),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
