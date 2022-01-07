import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class GhostTextField extends StatelessWidget {
  final String? Function(String?)? validator;
  final String? initialValue;
  final TextEditingController? controller;
  final bool? enabled;
  final bool readOnly;
  final void Function(String? val)? onSaved;
  final Function(dynamic)? onChanged;
  final TextInputType? keyboardType;
  final String label;
  final String hint;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final bool isNotActive;

  const GhostTextField(
      {Key? key,
      this.onChanged,
      this.onSaved,
      this.validator,
      this.initialValue,
      this.controller,
      this.enabled,
      this.readOnly = false,
      this.isNotActive = false,
      this.keyboardType = TextInputType.text,
      this.prefixIcon,
      this.suffixIcon,
      this.onTap,
      required this.label,
      required this.hint})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: isNotActive
              ? Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: Theme.of(context).unselectedWidgetColor)
              : Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(height: 8),
        TextFormField(
          onChanged: onChanged,
          onTap: onTap,
          validator: validator,
          initialValue: initialValue,
          controller: controller,
          enabled: enabled,
          readOnly: readOnly,
          onSaved: onSaved,
          keyboardType: keyboardType,
          style: isNotActive
              ? Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: Theme.of(context).unselectedWidgetColor)
              : Theme.of(context).textTheme.bodyText2,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}

class GhostDropdownTextField<T> extends StatelessWidget {
  final String label;
  final String hint;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool readOnly;
  final Function(T? value)? onChanged;
  final T? value;
  final List<DropdownMenuItem<T>>? items;
  final String? Function(T? value)? validator;
  final void Function(T? value)? onSaved;
  final List<Widget> Function(BuildContext)? selectedItemBuilder;

  const GhostDropdownTextField(
      {Key? key,
      this.prefixIcon,
      this.suffixIcon,
      this.readOnly = false,
      this.onChanged,
      this.value,
      this.items,
      this.onSaved,
      required this.label,
      required this.hint,
      this.validator,
      this.selectedItemBuilder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.headline6),
        const SizedBox(height: 8),
        DropdownButtonFormField<T>(
          value: value,
          validator: validator,
          onSaved: onSaved,
          onChanged: readOnly ? null : (value) => onChanged?.call(value),
          selectedItemBuilder: selectedItemBuilder,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
          ),
          items: items,
        ),
      ],
    );
  }
}

class GhostPasswordTextField extends StatefulWidget {
  final String? Function(String?)? validator;
  final String? initialValue;
  final TextEditingController? controller;
  final bool? enabled;
  final bool readOnly;
  final void Function(String? val)? onSaved;
  final TextInputType? keyboardType;
  final String label;
  final String hint;
  final void Function(String val)? onChanged;

  const GhostPasswordTextField(
      {Key? key,
      this.onSaved,
      this.validator,
      this.initialValue,
      this.controller,
      this.enabled,
      this.readOnly = false,
      this.onChanged,
      this.keyboardType = TextInputType.text,
      required this.label,
      required this.hint})
      : super(key: key);

  @override
  _GhostPasswordTextFieldState createState() => _GhostPasswordTextFieldState();
}

class _GhostPasswordTextFieldState extends State<GhostPasswordTextField> {
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: Theme.of(context).textTheme.headline6),
        const SizedBox(height: 8),
        TextFormField(
          validator: widget.validator,
          initialValue: widget.initialValue,
          controller: widget.controller,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          onSaved: widget.onSaved,
          onChanged: widget.onChanged,
          keyboardType: widget.keyboardType,
          obscureText: obscure,
          decoration: InputDecoration(
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      obscure = !obscure;
                    });
                  },
                  icon:
                      Icon(obscure ? Icons.visibility : Icons.visibility_off)),
              hintText: widget.hint),
        ),
      ],
    );
  }
}

class GhostPickerFieldValue<T> {
  final String name;
  final T? val;

  const GhostPickerFieldValue({required this.name, this.val});
}

class GhostPickerField<T> extends StatefulWidget {
  final GhostPickerFieldValue<T>? Function(GhostPickerFieldValue<T>?)?
      validator;
  final GhostPickerFieldValue<T>? initialValue;
  final void Function(GhostPickerFieldValue<T>?)? onSaved;
  final String label;
  final String hint;
  final Widget? prefixWidget;
  final IconData? suffixIcon;
  final Future<GhostPickerFieldValue<T>?> Function(GhostPickerFieldValue<T>?)?
      onTap;

  const GhostPickerField(
      {Key? key,
      this.onSaved,
      this.validator,
      this.initialValue,
      this.prefixWidget,
      this.suffixIcon,
      this.onTap,
      required this.label,
      required this.hint})
      : super(key: key);

  @override
  _GhostPickerFieldState<T> createState() => _GhostPickerFieldState<T>();
}

class _GhostPickerFieldState<T> extends State<GhostPickerField<T>> {
  late final TextEditingController controller;
  GhostPickerFieldValue<T>? currentValue;

  @override
  void initState() {
    currentValue = widget.initialValue;
    controller = TextEditingController(text: currentValue?.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: Theme.of(context).textTheme.headline6),
        const SizedBox(height: 8),
        TextFormField(
          validator: (value) {
            final val = widget.validator?.call(currentValue);
            return val?.name;
          },
          controller: controller,
          onTap: () async {
            final choosen = await widget.onTap?.call(currentValue);
            if (choosen != null) {
              controller.text = choosen.name;
              currentValue = choosen;
            }
          },
          readOnly: true,
          onSaved: (newValue) {
            widget.onSaved?.call(currentValue);
          },
          decoration: InputDecoration(
              prefixIcon: widget.prefixWidget,
              hintText: widget.hint,
              hintStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).textTheme.bodyText1!.color),
              suffixIcon: Icon(
                widget.suffixIcon,
                color: Theme.of(context).textTheme.bodyText1!.color,
              )),
        ),
      ],
    );
  }
}

class GhostCustomPickerField<T> extends StatefulWidget {
  final GhostPickerFieldValue<T>? Function(GhostPickerFieldValue<T>?)?
      validator;
  final GhostPickerFieldValue<T>? initialValue;
  final void Function(GhostPickerFieldValue<T>?)? onSaved;
  final String label;
  final Widget Function(BuildContext, GhostPickerFieldValue<T>) selectedBuilder;
  final Widget Function(BuildContext) unselectedBuilder;

  final Future<GhostPickerFieldValue<T>?> Function(GhostPickerFieldValue<T>?)?
      onTap;

  const GhostCustomPickerField(
      {Key? key,
      this.onSaved,
      this.validator,
      this.initialValue,
      this.onTap,
      required this.label,
      required this.selectedBuilder,
      required this.unselectedBuilder})
      : super(key: key);

  @override
  _GhostCustomPickerFieldState<T> createState() =>
      _GhostCustomPickerFieldState<T>();
}

class _GhostCustomPickerFieldState<T> extends State<GhostCustomPickerField<T>> {
  GhostPickerFieldValue<T>? currentValue;
  late final TextEditingController controller;
  bool isValid = true;

  @override
  void initState() {
    currentValue = widget.initialValue;
    controller = TextEditingController(text: currentValue?.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: Theme.of(context).textTheme.headline6),
        const SizedBox(height: 8),
        Material(
          child: InkWell(
            onTap: () async {
              final choosen = await widget.onTap?.call(currentValue);
              if (choosen != null) {
                setState(() {
                  currentValue = choosen;
                  controller.text = choosen.name;
                });
              }
            },
            child: Stack(
              children: [
                Column(
                  children: [
                    if (currentValue != null)
                      widget.selectedBuilder.call(context, currentValue!)
                    else
                      widget.unselectedBuilder.call(context),
                    SizedBox(height: isValid ? 0 : 25)
                  ],
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: AbsorbPointer(
                    child: TextFormField(
                      controller: controller,
                      validator: (value) {
                        final val = widget.validator?.call(currentValue);
                        setState(() {
                          isValid = val?.name == null;
                        });
                        return val?.name;
                      },
                      readOnly: true,
                      onSaved: (newValue) {
                        widget.onSaved?.call(currentValue);
                      },
                      style:
                          const TextStyle(height: 1, color: Colors.transparent),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).errorColor)),
                        errorStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).errorColor),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

/// Filled Text Form Field
class FilledTextField extends StatelessWidget {
  final String? Function(String?)? validator;
  final String? initialValue;
  final TextEditingController? controller;
  final bool? enabled;
  final bool readOnly;
  final void Function(String?)? onSaved;
  final TextInputType? keyboardType;
  final String? label;
  final String hint;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? onTap;

  const FilledTextField(
      {Key? key,
      this.onSaved,
      this.validator,
      this.initialValue,
      this.controller,
      this.enabled,
      this.readOnly = false,
      this.keyboardType = TextInputType.text,
      this.prefixIcon,
      this.suffixIcon,
      this.onTap,
      this.label,
      required this.hint})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(label!, style: Theme.of(context).textTheme.headline5),
        if (label != null) const SizedBox(height: 8),
        TextFormField(
          validator: validator,
          initialValue: initialValue,
          controller: controller,
          enabled: enabled,
          onTap: onTap,
          readOnly: readOnly,
          onSaved: onSaved,
          keyboardType: keyboardType,
          style: const TextStyle(fontSize: 14),
          decoration: InputDecoration(
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
              fillColor: Theme.of(context).dividerColor,
              filled: true,
              hintText: hint,
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).unselectedWidgetColor),
                  borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                  borderRadius: BorderRadius.circular(10)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).unselectedWidgetColor),
                  borderRadius: BorderRadius.circular(10))),
        ),
      ],
    );
  }
}

class FilledPasswordTextField extends StatefulWidget {
  final String? Function(String?)? validator;
  final String? initialValue;
  final TextEditingController? controller;
  final bool? enabled;
  final bool readOnly;
  final void Function(String? val)? onSaved;
  final TextInputType? keyboardType;
  final String label;
  final String hint;
  final void Function(String val)? onChanged;

  const FilledPasswordTextField(
      {Key? key,
      this.onSaved,
      this.validator,
      this.initialValue,
      this.controller,
      this.enabled,
      this.readOnly = false,
      this.onChanged,
      this.keyboardType = TextInputType.text,
      required this.label,
      required this.hint})
      : super(key: key);

  @override
  _FilledPasswordTextFieldState createState() =>
      _FilledPasswordTextFieldState();
}

class _FilledPasswordTextFieldState extends State<FilledPasswordTextField> {
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: Theme.of(context).textTheme.headline6),
        const SizedBox(height: 8),
        TextFormField(
          validator: widget.validator,
          initialValue: widget.initialValue,
          controller: widget.controller,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          onSaved: widget.onSaved,
          onChanged: widget.onChanged,
          keyboardType: widget.keyboardType,
          obscureText: obscure,
          decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
              fillColor: Theme.of(context).dividerColor,
              filled: true,
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).unselectedWidgetColor),
                  borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                  borderRadius: BorderRadius.circular(10)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).unselectedWidgetColor),
                  borderRadius: BorderRadius.circular(10)),
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      obscure = !obscure;
                    });
                  },
                  icon:
                      Icon(obscure ? Icons.visibility : Icons.visibility_off)),
              hintText: widget.hint),
        ),
      ],
    );
  }
}

class _GhostPinTextFieldBuilder extends StatelessWidget {
  final bool enabled;
  final bool enablePinAutofill;
  final int length;
  final void Function(String value)? onCompleted;
  final void Function(String value) onChanged;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final TextStyle? textStyle;
  final double errorTextSpace;
  final bool readOnly;

  const _GhostPinTextFieldBuilder(
      {Key? key,
      this.enabled = true,
      this.enablePinAutofill = true,
      this.onCompleted,
      required this.onChanged,
      this.validator,
      this.onSaved,
      required this.length,
      this.textStyle,
      this.errorTextSpace = 16,
      this.readOnly = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      autoFocus: true,
      readOnly: readOnly,
      cursorColor: Colors.black,
      enabled: enabled,
      enablePinAutofill: enablePinAutofill,
      appContext: context,
      length: length,
      textStyle: textStyle ?? Theme.of(context).textTheme.headline2,
      keyboardType: TextInputType.number,
      animationType: AnimationType.scale,
      hintCharacter: '\u2212',
      errorTextSpace: errorTextSpace,
      hintStyle: (textStyle ?? Theme.of(context).textTheme.headline2)!
          .copyWith(color: Theme.of(context).indicatorColor),
      pinTheme: PinTheme(
          shape: PinCodeFieldShape.underline,
          activeFillColor: Theme.of(context).primaryColor,
          inactiveColor: Theme.of(context).unselectedWidgetColor,
          activeColor: Theme.of(context).primaryColor,
          selectedColor: Theme.of(context).primaryColor,
          inactiveFillColor: Colors.transparent,
          selectedFillColor: Colors.transparent),
      onCompleted: onCompleted,
      onChanged: onChanged,
      onSaved: onSaved,
      validator: validator,
    );
  }
}

class GhostPinTextField extends StatelessWidget {
  final bool enabled;
  final bool enablePinAutofill;
  final int length;
  final void Function(String value)? onCompleted;
  final void Function(String value) onChanged;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final String label;
  final bool readOnly;

  const GhostPinTextField(
      {Key? key,
      required this.label,
      this.enabled = true,
      this.enablePinAutofill = true,
      this.onCompleted,
      required this.onChanged,
      this.validator,
      this.onSaved,
      required this.length,
      this.readOnly = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.headline6),
        const SizedBox(height: 8),
        _GhostPinTextFieldBuilder(
          onChanged: onChanged,
          length: length,
          enablePinAutofill: enablePinAutofill,
          enabled: enabled,
          onCompleted: onCompleted,
          onSaved: onSaved,
          textStyle: Theme.of(context).textTheme.headline2,
          validator: validator,
          readOnly: readOnly,
          errorTextSpace: 24,
        ),
      ],
    );
  }
}

class GhostPinFullTextField extends StatelessWidget {
  final bool enabled;
  final bool enablePinAutofill;
  final int length;
  final void Function(String value)? onCompleted;
  final void Function(String value) onChanged;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;

  const GhostPinFullTextField(
      {Key? key,
      this.enabled = true,
      this.enablePinAutofill = true,
      this.onCompleted,
      required this.onChanged,
      this.validator,
      this.onSaved,
      required this.length})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _GhostPinTextFieldBuilder(
      onChanged: onChanged,
      length: length,
      enablePinAutofill: enablePinAutofill,
      enabled: enabled,
      onCompleted: onCompleted,
      onSaved: onSaved,
      textStyle: Theme.of(context).textTheme.headline2,
      validator: validator,
      errorTextSpace: 24,
    );
  }
}
