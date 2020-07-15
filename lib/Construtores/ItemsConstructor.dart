class ScreenArguments {
  final String title;
  final String description;
  final String thumbnail;
  final DateTime updated_at;
  var nature;
  final user_id;
  final id;
  final price;
  var index;

  ScreenArguments(
    this.title, 
    this.description, 
    this.thumbnail, 
    this.updated_at,
    this.nature,
    this.user_id,
    this.id,
    this.price,
    this.index
  );
}
