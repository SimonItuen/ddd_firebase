import 'package:ddd_firebase/application/notes/note_form/note_form_bloc.dart';
import 'package:ddd_firebase/domain/notes/value_objects.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ColorField extends StatelessWidget {
  const ColorField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteFormBloc, NoteFormState>(
      buildWhen: (p, c) => p.note.color != c.note.color,
      builder: (context, state) {
        return Container(
          height: 80,
          child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final itemColor = NoteColor.predefinedColors[index];
                return GestureDetector(
                  onTap:(){
                    BlocProvider.of<NoteFormBloc>(context).add(NoteFormEvent.colorChanged(itemColor));
                  },
                  child: Material(
                    color: itemColor,
                    elevation: 4,
                    shape: CircleBorder(
                        side: state.note.color.value.fold(
                            (l) => BorderSide.none,
                            (color) => color == itemColor
                                ? const BorderSide(width: 1.5)
                                : BorderSide.none)),
                    child: Container(
                      width: 50,
                      height: 50,
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  width: 12,
                );
              },
              itemCount: NoteColor.predefinedColors.length),
        );
      },
    );
  }
}
