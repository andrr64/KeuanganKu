String truncateString(String str, int strLimit, {bool isEndWith = false, String? endWith}) {
  if (str.length <= strLimit) {
    return str;
  } else {
    String truncatedStr = str.substring(0, strLimit);
    if (isEndWith) {
      truncatedStr += endWith ?? "...";
    }
    return truncatedStr;
  }
}
