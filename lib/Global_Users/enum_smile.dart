enum EmailSignUpResults {
  SignUpCompleted,
  EmailAlreadtExist,
  SignUpNotCompleted
}

enum EmailSignInResults {
  SignInCompleted,
  EmailNotVerified,
  EmailOrPasswordInvalid,
  UnexpectedError
}

enum GoogleSignInResults {
  SignInCompleted,
  SignInNotCompleted,
  UnexpectedError,
  AlreadySignedIn,
}

enum StatusMediaTypes {
  TextActivity,
  ImageActivity,
}

enum ConnectionStateName {
  Connect,
  Pending,
  Accept,
  Connected,
}

enum ConnectionStateType {
  ButtonNameWidget,
  ButtonBorderColor,
  ButtonOnlyName,
}

enum OtherConnectionStatus {
  Request_Pending,
  Invitation_Came,
  Invitation_Accepted,
  Request_Accepted,
}

enum ChatMessageTypes {
  None,
  Text,
  Image,
  Video,
  Document,
  Audio,
  Location,
}

enum ImageProviderCategory {
  FileImage,
  ExactAssetImage,
  NetworkImage,
}

enum MessageHolderType {
  Me,
  ConnectedUsers,
}

enum GetFieldForImportantDataLocalDatabase {
  UserEmail,
  Token,
  ProfileImagePath,
  ProfileImageUrl,
  About,
  Category,
  WallPaper,
  MobileNumber,
  Notification,
  AccountCreationDate,
  AccountCreationTime,
}

enum PreviousMessageColTypes {
  ActualMessage,
  MessageDate,
  MessageTime,
  MessageHolder,
  MessageType,
}
