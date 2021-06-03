class NoObservableFoundWithTagError implements Exception {
  dynamic tag;
  String message;
  NoObservableFoundWithTagError(this.tag)
      : message = 'No Observable found with tag $tag';
}
