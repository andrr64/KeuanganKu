// ignore_for_file: constant_identifier_names

enum Condition {
  OK,
  ERROR
}

enum SQLError {
  Read,
  Update,
  Insert,
  Delete
}

enum ValidatorError {
  InvalidInput,
  OverflowNumber,
  OverflowText,
  IfCondition,
  LessThanError,
  LessThanOrEqualZero
}