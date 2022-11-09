enum ProgressIndicatorStatus {
  start,
  succeed,
  fail,
  reverse,
  cancel;

  bool get isStart => this == start;
  bool get isSucceed => this == succeed;
  bool get isFail => this == fail;
  bool get isReverse => this == reverse;
  bool get isCancel => this == cancel;
}
