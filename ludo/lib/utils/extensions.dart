extension listExtension<T> on List<T> {

  /// Creates a copy of [this] that start at [index] and end at [index]
  List<T> startAt(int index) {
    if (index == 0) return this;
    final listOne = this.getRange(index, this.length);
    final listTwo = this.getRange(0, index);
    return <T>[...listOne, ...listTwo];
  }

}