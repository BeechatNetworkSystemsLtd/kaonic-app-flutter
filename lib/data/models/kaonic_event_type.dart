abstract class KaonicEventType {
  // Messages
  static const String CHAT_CREATE = "ChatCreate";
  static const String MESSAGE_TEXT = "Message";
  static const String MESSAGE_FILE = "MessageFile";

  static const List<String> messageEvents = [
    MESSAGE_TEXT,
    MESSAGE_FILE,
    CHAT_CREATE,
  ];

  // Calls
  static const String CALL_INVOKE = "CallInvoke";
  static const String CALL_ANSWER = "CallAnswer";
  static const String CALL_REJECT = "CallReject";
  static const String CALL_TIMEOUT = "CallTimeout";

  static const List<String> callEvents = [
    CALL_INVOKE,
    CALL_ANSWER,
    CALL_REJECT,
    CALL_TIMEOUT,
  ];

  // Other
  static const String CONTACT_FOUND = "ContactFound";
}
