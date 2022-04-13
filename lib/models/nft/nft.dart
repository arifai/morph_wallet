class Nft {
  final String imgUrl;
  final String name;
  final int count;

  Nft(this.imgUrl, this.name, this.count);

  static Nft fromJson(Map<String, dynamic> data) {
    return Nft(
      data['img_url'] as String,
      data['name'] as String,
      data['count'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['img_url'] = imgUrl;
    data['name'] = name;
    data['count'] = count;

    return data;
  }
}
