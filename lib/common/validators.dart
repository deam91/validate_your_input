import 'package:reactive_forms/reactive_forms.dart';

import 'mocks.dart';

class InputValidators {
  // async simulates email uniqueness
  static Future<Map<String, dynamic>?> uniqueEmail(
      AbstractControl<dynamic> control) async {
    var error = {'unique': false};

    // a delay to simulate a request
    final emailAlreadyUsed = await Future.delayed(
      const Duration(seconds: 1),
      () => inUseEmails.contains(control.value),
    );

    if (emailAlreadyUsed) {
      if (inUseEmails.indexOf(control.value) == 0) {
        error = {'john': false};
      } else if (inUseEmails.indexOf(control.value) == 1) {
        error = {'jonny': false};
      }
      control.markAsTouched();
      return error;
    }

    return null;
  }

  // validates that the user age is above or equal to 18
  static Map<String, dynamic>? adult(AbstractControl<dynamic> control) {
    final date = (control as FormControl<DateTime>).value;
    if (date != null) {
      final now = DateTime.now();
      if (now.difference(date).inDays >= 365 * 18) {
        return null;
      }
    }
    return {'adult': false};
  }
}
