import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:geraisdm/modules/register/models/register_config_model.dart';
import 'package:geraisdm/utils/helpers/time_helper.dart';
import 'package:geraisdm/widgets/form_component.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:geraisdm/constant/localizations.g.dart';

class RegisterFormBuilder<T> extends StatelessWidget {
  final RegisterConfigFormModel configForm;
  final T? initialValue;
  final bool isReadOnly;
  final Function(T? value)? onSaved;

  const RegisterFormBuilder(
      {Key? key,
      required this.configForm,
      this.initialValue,
      this.isReadOnly = false,
      this.onSaved})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool readOnly =
        !configForm.readOnly ? isReadOnly : configForm.readOnly;
    switch (configForm.type) {
      case RegisterConfigFormType.nik:
        return FilledTextField(
          readOnly: readOnly,
          initialValue: initialValue as String?,
          suffixIcon: const Icon(Icons.person),
          label: configForm.nameKey.tr(),
          hint: configForm.hintKey.tr(),
          onSaved: (value) => onSaved?.call(value as T?),
          validator: RequiredValidator(
              errorText: LocaleKeys.register_form_required.tr()),
        );

      case RegisterConfigFormType.nrp:
        return FilledTextField(
          readOnly: readOnly,
          initialValue: initialValue as String?,
          suffixIcon: const Icon(Icons.person),
          label: configForm.nameKey.tr(),
          hint: configForm.hintKey.tr(),
          onSaved: (value) => onSaved?.call(value as T?),
          validator: RequiredValidator(
              errorText: LocaleKeys.register_form_required.tr()),
        );

      case RegisterConfigFormType.fullName:
        return FilledTextField(
          readOnly: readOnly,
          initialValue: initialValue as String?,
          suffixIcon: const Icon(Icons.person_pin_circle_rounded),
          label: configForm.nameKey.tr(),
          hint: configForm.hintKey.tr(),
          onSaved: (value) => onSaved?.call(value as T?),
          validator: RequiredValidator(
              errorText: LocaleKeys.register_form_required.tr()),
        );

      case RegisterConfigFormType.address:
        return FilledTextField(
          readOnly: readOnly,
          initialValue: initialValue as String?,
          suffixIcon: const Icon(Icons.maps_home_work),
          label: configForm.nameKey.tr(),
          hint: configForm.hintKey.tr(),
          onSaved: (value) => onSaved?.call(value as T?),
          validator: RequiredValidator(
              errorText: LocaleKeys.register_form_required.tr()),
        );

      case RegisterConfigFormType.email:
        return FilledTextField(
          readOnly: readOnly,
          initialValue: initialValue as String?,
          suffixIcon: const Icon(Icons.email),
          label: configForm.nameKey.tr(),
          hint: configForm.hintKey.tr(),
          onSaved: (value) => onSaved?.call(value as T?),
          validator: MultiValidator([
            RequiredValidator(
                errorText: LocaleKeys.register_form_required.tr()),
            EmailValidator(errorText: LocaleKeys.register_email_invalid.tr())
          ]),
        );

      case RegisterConfigFormType.phone:
        return FilledTextField(
          readOnly: readOnly,
          initialValue: initialValue as String?,
          suffixIcon: const Icon(Icons.phone),
          label: configForm.nameKey.tr(),
          hint: configForm.hintKey.tr(),
          onSaved: (value) => onSaved?.call(value as T?),
          validator: RequiredValidator(
              errorText: LocaleKeys.register_form_required.tr()),
        );

      case RegisterConfigFormType.birthday:
        return FilledPickerField<DateTime>(
          initialValue: initialValue as FormPickerFieldValue<DateTime>?,
          suffixIcon: Icons.calendar_today,
          label: configForm.nameKey.tr(),
          hint: configForm.hintKey.tr(),
          validator: (val) {
            final valid = RequiredValidator(
                    errorText: LocaleKeys.register_form_required.tr())
                .call(val?.name ?? "");
            if (valid != null) {
              return FormPickerFieldValue(name: valid);
            } else {
              return null;
            }
          },
          onTap: readOnly
              ? null
              : (val) async {
                  final selected = await showDatePicker(
                      context: context,
                      initialDate: (val)?.val ?? DateTime.now(),
                      firstDate: DateTime(1945),
                      lastDate: DateTime.now());

                  if (selected != null) {
                    return FormPickerFieldValue(
                        name: TimeHelper.dateTimeToDayMonthYear(
                            selected, context.locale.languageCode),
                        val: selected);
                  }
                },
          onSaved: (value) => onSaved?.call(value as T?),
        );

      case RegisterConfigFormType.password:
        return FilledPasswordTextField(
          readOnly: readOnly,
          initialValue: initialValue as String?,
          label: configForm.nameKey.tr(),
          hint: configForm.hintKey.tr(),
          onSaved: (value) => onSaved?.call(value as T?),
          validator: RequiredValidator(
              errorText: LocaleKeys.register_form_required.tr()),
        );
      default:
        return Container();
    }
  }
}
