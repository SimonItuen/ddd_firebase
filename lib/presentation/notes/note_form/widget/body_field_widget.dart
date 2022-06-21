import 'package:ddd_firebase/application/notes/note_form/note_form_bloc.dart';
import 'package:ddd_firebase/domain/notes/value_objects.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class BodyField extends HookWidget {
  const BodyField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textEditingController = useTextEditingController();
    return BlocListener<NoteFormBloc, NoteFormState>(
      listenWhen: (p,c)=> p.isEditing != c.isEditing,
      listener: (context, state) {
        textEditingController.text = state.note.body.getOrCrash();
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextFormField(
          controller: textEditingController,
          decoration: const InputDecoration(labelText: 'Note', counterText: ''),
          maxLength: NoteBody.maxLength,
          maxLines: null,
          minLines: 5,
          onChanged: (value) => BlocProvider.of<NoteFormBloc>(context)
              .add(NoteFormEvent.bodyChanged(value)),
          validator: (_) => BlocProvider.of<NoteFormBloc>(context)
              .state
              .note
              .body
              .value
              .fold(
                  (f) => f.maybeMap(
                      empty: (f) => 'Cannot be empty',
                      exceedingLength: (f) => 'Exceeding length. max: ${f.max}',
                      orElse: () => null),
                  (r) => null), // get the most fresh state
        ),
      ),
    );
  }
}
