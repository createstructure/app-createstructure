import 'package:flutter/material.dart';

class CheckboxFormField extends FormField<bool> {
  CheckboxFormField({
    String title = "",
    FormFieldSetter<bool>? onSaved,
    FormFieldValidator<bool>? validator,
    bool initialValue = false,
    bool autovalidate = false,
    ValueChanged<bool>? onChanged,
    IconData icon = Icons.check,
    InputDecoration? decoration = const InputDecoration(),
  }) : super(
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
          builder: (FormFieldState<bool> state) {
            Widget checkbox = CheckboxListTile(
              dense: state.hasError,
              value: state.value,
              onChanged: (value) {
                state.didChange(value);
                if (onChanged != null) {
                  onChanged(value!);
                }
              },
              subtitle: state.hasError
                  ? Builder(
                      builder: (BuildContext context) => Text(
                        state.errorText!,
                        style: TextStyle(color: Theme.of(context).colorScheme.error),
                      ),
                    )
                  : null,
              controlAffinity: ListTileControlAffinity.leading,
            );
            return Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Icon(
                  icon,
                  color: Colors.black54,
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          width: 30,
                          child: checkbox,
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black54,
                          style: BorderStyle.solid,
                          width: 1.25,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
}
