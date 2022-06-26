enum TypeValue {
  great(1, 'Flutter is great!'),
  awesome(2, 'Flutter is awesome!'),
  other(3, 'Other:');

  final int id;
  final String value;
  const TypeValue(this.id, this.value);
}
