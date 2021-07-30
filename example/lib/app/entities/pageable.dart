class Pageable {
  final int pageSize;
  final int currentPage;

  Pageable.fromSize(this.pageSize) : currentPage = 1;

  Pageable(this.pageSize, this.currentPage);
}

class Page<T> {
  List<T> content;

  Page.fromList(List<T> l) : content = l;
  Page.empty() : content = [];

  @override
  String toString() {
    return content.toString();
  }
}
