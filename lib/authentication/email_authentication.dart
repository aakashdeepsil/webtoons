import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:webtoons/constants.dart';
import 'package:webtoons/localization/email_auth_localization.dart';

class DataField {
  /// Label of the `TextFormField` for this metadata
  final String label;

  /// Key to be used when sending the metadata to Supabase
  final String key;

  /// Validator function for the metadata field
  final String? Function(String?)? validator;

  /// Icon to show as the prefix icon in TextFormField
  final Icon? prefixIcon;

  DataField({
    required this.label,
    required this.key,
    this.validator,
    this.prefixIcon,
  });
}

class EmailAuth extends StatefulWidget {
  /// The URL to redirect the user to when clicking on the link on the
  /// confirmation link after signing up.
  final String? redirectTo;

  /// Callback for the user to complete a sign in.
  final void Function(AuthResponse response) onSignInComplete;

  /// Callback for the user to complete a signUp.
  ///
  /// If email confirmation is turned on, the user is
  final void Function(AuthResponse response) onSignUpComplete;

  /// Callback for sending the password reset email
  final void Function()? onPasswordResetEmailSent;

  /// Callback for when the auth action threw an exception
  ///
  /// If set to `null`, a snack bar with error color will show up.
  final void Function(Object error)? onError;

  /// Set of additional fields to the signup form that will become
  /// part of the user_metadata
  final List<DataField>? dataFields;

  /// Additional properties for user_metadata on signup
  final Map<String, dynamic>? extraData;

  /// Localization for the form
  final EmailAuthLocalization localization;

  /// {@macro supa_email_auth}
  const EmailAuth({
    super.key,
    this.redirectTo,
    required this.onSignInComplete,
    required this.onSignUpComplete,
    this.onPasswordResetEmailSent,
    this.onError,
    this.dataFields,
    this.extraData,
    this.localization = const EmailAuthLocalization(),
  });

  @override
  State<EmailAuth> createState() => _EmailAuthState();
}

class _EmailAuthState extends State<EmailAuth> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late final Map<DataField, TextEditingController> _dataControllers;

  final passwordRegExp = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');

  bool _isLoading = false;

  /// The user has pressed forgot password button
  bool _forgotPassword = false;

  bool _isSigningIn = true;

  @override
  void initState() {
    super.initState();
    _dataControllers = Map.fromEntries((widget.dataFields ?? [])
        .map((dataField) => MapEntry(dataField, TextEditingController())));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    for (final controller in _dataControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  bool isPasswordValid(String? value) {
    // Check if the password is null or empty.
    if (value == null || value.isEmpty) {
      return false;
    }

    // Check if the password is too short.
    if (value.length < 8) {
      return false;
    }

    // Check if the password meets the required format.
    if (!passwordRegExp.hasMatch(value)) {
      return false;
    }

    // If all checks passed, the password is valid.
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final localization = widget.localization;
    return AutofillGroup(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              autofillHints: const [AutofillHints.email],
              textInputAction:
                  _forgotPassword ? TextInputAction.done : TextInputAction.next,
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    !EmailValidator.validate(_emailController.text)) {
                  return localization.validEmailError;
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.email),
                label: Text(localization.enterEmail),
              ),
              controller: _emailController,
            ),
            if (!_forgotPassword) ...[
              spacer(16),
              TextFormField(
                autofillHints: _isSigningIn
                    ? [AutofillHints.password]
                    : [AutofillHints.newPassword],
                textInputAction: widget.dataFields != null && !_isSigningIn
                    ? TextInputAction.next
                    : TextInputAction.done,
                validator: (value) => isPasswordValid(value) == false
                    ? localization.passwordLengthError
                    : null,
                decoration: InputDecoration(
                  errorMaxLines: 3,
                  prefixIcon: const Icon(Icons.lock),
                  label: Text(localization.enterPassword),
                ),
                obscureText: true,
                controller: _passwordController,
              ),
              spacer(16),
              if (widget.dataFields != null && !_isSigningIn)
                ...widget.dataFields!
                    .map((dataField) => [
                          TextFormField(
                            controller: _dataControllers[dataField],
                            textInputAction:
                                widget.dataFields!.last == dataField
                                    ? TextInputAction.done
                                    : TextInputAction.next,
                            decoration: InputDecoration(
                              label: Text(dataField.label),
                              prefixIcon: dataField.prefixIcon,
                            ),
                            validator: dataField.validator,
                          ),
                          spacer(16),
                        ])
                    .expand((element) => element),
              ElevatedButton(
                child: (_isLoading)
                    ? SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.onPrimary,
                          strokeWidth: 1.5,
                        ),
                      )
                    : Text(_isSigningIn
                        ? localization.signIn
                        : localization.signUp),
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                  setState(() {
                    _isLoading = true;
                  });
                  try {
                    if (_isSigningIn) {
                      final response = await supabase.auth.signInWithPassword(
                        email: _emailController.text.trim(),
                        password: _passwordController.text.trim(),
                      );
                      widget.onSignInComplete.call(response);
                    } else {
                      final checkUsername = await supabase
                          .from('USER')
                          .select()
                          .eq('username', _dataControllers.values.first.text);

                      if (checkUsername.isNotEmpty && context.mounted) {
                        context.showErrorSnackBar('Username already exists');
                      } else {
                        final response = await supabase.auth.signUp(
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim(),
                          emailRedirectTo: widget.redirectTo,
                          data: _resolveData(),
                        );
                        widget.onSignUpComplete.call(response);
                      }
                    }
                  } on AuthException catch (error) {
                    if (widget.onError == null && context.mounted) {
                      context.showErrorSnackBar(error.message);
                    } else {
                      widget.onError?.call(error);
                    }
                  } catch (error) {
                    if (widget.onError == null && context.mounted) {
                      context.showErrorSnackBar(
                          '${localization.unexpectedError}: $error');
                    } else {
                      widget.onError?.call(error);
                    }
                  }
                  if (mounted) {
                    setState(() {
                      _isLoading = false;
                    });
                  }
                },
              ),
              spacer(16),
              if (_isSigningIn) ...[
                TextButton(
                  onPressed: () {
                    setState(() {
                      _forgotPassword = true;
                    });
                  },
                  child: Text(localization.forgotPassword),
                ),
              ],
              TextButton(
                key: const ValueKey('toggleSignInButton'),
                onPressed: () {
                  setState(() {
                    _forgotPassword = false;
                    _isSigningIn = !_isSigningIn;
                  });
                },
                child: Text(_isSigningIn
                    ? localization.dontHaveAccount
                    : localization.haveAccount),
              ),
            ],
            if (_isSigningIn && _forgotPassword) ...[
              spacer(16),
              ElevatedButton(
                onPressed: () async {
                  try {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }
                    setState(() {
                      _isLoading = true;
                    });

                    final email = _emailController.text.trim();
                    await supabase.auth.resetPasswordForEmail(
                      email,
                      redirectTo: widget.redirectTo,
                    );
                    widget.onPasswordResetEmailSent?.call();
                  } on AuthException catch (error) {
                    widget.onError?.call(error);
                  } catch (error) {
                    widget.onError?.call(error);
                  }
                },
                child: Text(localization.sendPasswordReset),
              ),
              spacer(16),
              TextButton(
                onPressed: () {
                  setState(() {
                    _forgotPassword = false;
                  });
                },
                child: Text(localization.backToSignIn),
              ),
            ],
            spacer(16),
          ],
        ),
      ),
    );
  }

  /// Resolve the user_metadata that we will send during sign-up
  ///
  /// In case both MetadataFields and extraMetadata have the same
  /// key in their map, the MetadataFields (form fields) win
  Map<String, dynamic> _resolveData() {
    var extra = widget.extraData ?? <String, dynamic>{};
    extra.addAll(_resolveMetadataFieldsData());
    return extra;
  }

  /// Resolve the user_metadata coming from the metadataFields
  Map<String, dynamic> _resolveMetadataFieldsData() {
    return widget.dataFields != null
        ? _dataControllers.map<String, dynamic>((metaDataField, controller) =>
            MapEntry(metaDataField.key, controller.text))
        : <String, dynamic>{};
  }
}
