enum EmailSignUpResults{
  SignUpCompleted,
  EmailAlreadtExist,
  SignUpNotCompleted
}

enum EmailSignInResults{
  SignInCompleted,
  EmailNotVerified,
  EmailOrPasswordInvalid,
  UnexpectedError
}
enum GoogleSignInResults{
  SignInCompleted,
  SignInNotCompleted,
  UnexpectedError,
  AlreadySignedIn,
}

enum StatusMediaTypes{
  TextActivity,
  ImageActivity,
}
