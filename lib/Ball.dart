
enum Status {
  unknown,
  possiblyLighter,
  possiblyHeavier,
  good
 }

class Ball {
  int index;
  Status _status = Status.unknown;
  
  Ball(this.index, [this._status]);
  
  isWeighted() => _status != Status.unknown;
}