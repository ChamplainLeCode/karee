///
/// NoObservableFoundWithTagError: Exception class thrown when looking for cached observable by tag.
///
class NoObservableFoundWithTagError implements Exception {
  /// The observable tag.
  dynamic tag;

  /// Message of this error.
  String message;
  NoObservableFoundWithTagError(this.tag)
      : message = 'No Observable found with tag $tag';
}
