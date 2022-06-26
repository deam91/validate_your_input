import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
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
      // _validateSelection(selectedValue);
    });
    super.initState();
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
        ],
      ),
    );
  }
}
