import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:validate_your_input/common/gen/colors.gen.dart';
import 'package:validate_your_input/features/signup/animated_field_wrapper.dart';
import 'package:validate_your_input/features/signup/show_suffix_button.dart';

import '../../common/enum.dart';
import '../../common/validators.dart';

class CustomForm extends StatefulWidget {
  const CustomForm({Key? key}) : super(key: key);

  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  late FormGroup form;
  TypeValue? _selectedOption;
  bool _obscurePassword = true;
  bool _obscurePasswordConfirmation = true;
  final list = [TypeValue.great, TypeValue.awesome, TypeValue.other];

  @override
  initState() {
    form = FormBuilder().group(
      <String, Object>{
        'name': ['', Validators.required],
        'email': FormControl<String>(
          validators: [Validators.required, Validators.email],
          asyncValidators: [InputValidators.uniqueEmail],
          asyncValidatorsDebounceTime: 1000,
        ),
        'password': [
          '',
          Validators.required,
          Validators.minLength(8),
          Validators.pattern(
              "^(?=.{8,32}\$)(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#\$%^&*(),.?:{}|<>]).*"),
        ],
        'passwordConfirmation': '',
        'receiveNewsletter': FormControl<bool>(
          value: false,
          validators: [Validators.requiredTrue],
        ),
        'birthdate': FormControl<DateTime>(
          value: DateTime.now(),
          validators: [Validators.required, InputValidators.adult],
        ),
        'options': FormControl<TypeValue>(
          value: TypeValue.great,
          validators: [Validators.required],
        ),
        'other': FormControl<String>(
          validators: [Validators.required],
          disabled: true,
        ),
      },
      [Validators.mustMatch('password', 'passwordConfirmation')],
    );
    _selectedOption = TypeValue.great;
    form.control('options').valueChanges.listen((value) {
      final selectedValue = value as TypeValue;
      _validateSelection(selectedValue);
    });
    super.initState();
  }

  Map<String, Object>? _validateSelection(TypeValue value) {
    if (value.id == TypeValue.other.id) {
      if (form.control('other').disabled) {
        form.control('other').markAsTouched();
        form.control('other').markAsEnabled();
        form.focus('other');
      }
      setState(() {
        _selectedOption = value;
      });
    } else {
      if (form.control('other').enabled) {
        form.control('other').updateValue('');
        form.control('other').markAsUntouched();
        form.control('other').markAsDisabled();
        form.control('other').unfocus(touched: false);
      }
      setState(() {
        _selectedOption = value;
      });
    }
    return null;
  }

  ReactiveRadioListTile<TypeValue> _getRadioTile(TypeValue value) {
    return ReactiveRadioListTile<TypeValue>(
      key: ValueKey(value),
      controlAffinity: ListTileControlAffinity.leading,
      formControlName: 'options',
      value: value,
      visualDensity: VisualDensity.compact,
      contentPadding: const EdgeInsets.all(0.0),
      dense: false,
      isThreeLine: false,
      title: Text(value.value),
      toggleable: false,
      selected: _selectedOption == value,
      activeColor: ColorName.primary,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: form,
      child: Column(
        children: [
          AnimatedFieldWrapper(
            child: ReactiveTextField(
              formControlName: 'name',
              textInputAction: TextInputAction.continueAction,
              onSubmitted: () => form.focus('email'),
              validationMessages: (control) =>
                  {'required': 'The name must not be empty'},
              decoration: const InputDecoration(
                isDense: true,
                hintText: 'Name',
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          AnimatedFieldWrapper(
            child: ReactiveTextField(
              formControlName: 'email',
              textInputAction: TextInputAction.continueAction,
              onSubmitted: () => form.focus('password'),
              validationMessages: (control) => {
                'required': 'The email must not be empty',
                'email': 'The email value must be a valid email',
                'unique': 'The email already exist',
                'john': 'Sorry John, that email already exist. Don`t shut! 🤝 ',
                'jonny':
                    'Sorry Jonny, that email already exist. Check your treasure! 💰',
              },
              decoration: const InputDecoration(
                hintText: 'Email',
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          AnimatedFieldWrapper(
            child: ReactiveTextField(
              formControlName: 'password',
              obscureText: _obscurePassword,
              textInputAction: TextInputAction.continueAction,
              onSubmitted: () => form.focus('passwordConfirmation'),
              validationMessages: (control) => {
                'minLength': 'The password must contain at least 8 characters',
                'pattern':
                    'The password must contain uppercase and lowercase letters, numbers and special characters',
                'required': 'The password must not be empty',
                'password': 'The password value must be a valid password'
              },
              decoration: InputDecoration(
                hintText: 'Password',
                suffixIcon: SuffixButtonShow(onCliked: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                }),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          AnimatedFieldWrapper(
            child: ReactiveTextField(
              formControlName: 'passwordConfirmation',
              textInputAction: TextInputAction.continueAction,
              onSubmitted: () => form.focus('birthdate'),
              obscureText: _obscurePasswordConfirmation,
              validationMessages: (control) => {
                'minLength': 'The password must contain at least 8 characters',
                'required': 'The password must not be empty',
                'password': 'The password value must be a valid password',
                'mustMatch': 'The confirmation must match with the password'
              },
              decoration: InputDecoration(
                hintText: 'Password again',
                suffixIcon: SuffixButtonShow(onCliked: () {
                  setState(() {
                    _obscurePasswordConfirmation =
                        !_obscurePasswordConfirmation;
                  });
                }),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          AnimatedFieldWrapper(
            child: ReactiveTextField<DateTime>(
              formControlName: 'birthdate',
              validationMessages: (control) => {
                'required': 'The birthdate must not be empty',
                'adult': 'You must be the age 18 or above to be able to sign up'
              },
              readOnly: true,
              decoration: InputDecoration(
                  hintText: 'Date of birth',
                  suffixIcon: ReactiveDatePicker<DateTime>(
                    initialDatePickerMode: DatePickerMode.year,
                    initialEntryMode: DatePickerEntryMode.calendar,
                    formControlName: 'birthdate',
                    firstDate: DateTime(1960),
                    lastDate: DateTime(2050),
                    builder: (context, picker, child) {
                      return IconButton(
                        onPressed: picker.showPicker,
                        iconSize: 22,
                        icon: Icon(
                          Icons.date_range,
                          color: Theme.of(context).textTheme.subtitle2?.color,
                        ),
                      );
                    },
                  )),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Column(
            children: list.map(_getRadioTile).toList(),
          ),
          AnimatedFieldWrapper(
            child: ReactiveTextField(
              formControlName: 'other',
              textInputAction: TextInputAction.continueAction,
              validationMessages: (control) => {
                'required': 'The other field must not be empty',
              },
              onSubmitted: () => form.focus('receiveNewsletter'),
              decoration: const InputDecoration(
                hintText: 'Other',
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
