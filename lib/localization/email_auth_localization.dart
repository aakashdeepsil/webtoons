class EmailAuthLocalization {
  final String enterEmail;
  final String validEmailError;
  final String enterPassword;
  final String passwordLengthError;
  final String signIn;
  final String signUp;
  final String forgotPassword;
  final String dontHaveAccount;
  final String haveAccount;
  final String sendPasswordReset;
  final String backToSignIn;
  final String unexpectedError;

  const EmailAuthLocalization({
    this.enterEmail = 'Enter your email',
    this.validEmailError = 'Please enter a valid email address',
    this.enterPassword = 'Enter your password',
    this.passwordLengthError = 'Please enter a password that is at least 8 characters including a number, a lowercase letter, and an uppercase letter',
    this.signIn = 'Sign In',
    this.signUp = 'Sign Up',
    this.forgotPassword = 'Forgot your password?',
    this.dontHaveAccount = 'Don\'t have an account? Sign up',
    this.haveAccount = 'Already have an account? Sign in',
    this.sendPasswordReset = 'Send password reset email',
    this.backToSignIn = 'Back to sign in',
    this.unexpectedError = 'An unexpected error occurred',
  });
}
