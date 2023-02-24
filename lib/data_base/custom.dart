class Customer {
  String name;
  Map map;

  Customer(this.name, this.map);

  @override
  String toString() {
    return ' ${this.name} ';
  }
}