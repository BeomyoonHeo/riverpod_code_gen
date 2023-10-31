import 'package:json_annotation/json_annotation.dart';

part 'shopping_response.g.dart';

@JsonSerializable(createToJson: false, explicitToJson: false)
class ShoppingResponse {
  const ShoppingResponse({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
    required this.category,
    required this.rating,
  });

  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'title')
  final String title;

  @JsonKey(name: 'description')
  final String description;

  @JsonKey(name: 'price')
  final double price;

  @JsonKey(name: 'image')
  final String image;

  @JsonKey(name: 'category')
  final String category;

  @JsonKey(name: 'rating')
  final RatingResponse rating;

  factory ShoppingResponse.fromJson(Map<String, dynamic> json) => _$ShoppingResponseFromJson(json);
}

@JsonSerializable(createToJson: false, explicitToJson: false)
class RatingResponse {
  const RatingResponse({
    required this.rate,
    required this.count,
  });

  @JsonKey(name: 'rate')
  final double rate;

  @JsonKey(name: 'count')
  final int count;

  factory RatingResponse.fromJson(Map<String, dynamic> json) => _$RatingResponseFromJson(json);
}
