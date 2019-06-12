class Post{

  final String title;
  final int price;
  final int fixPrice;
  final String code;
  final Images images;

  Post({
    this.title, this.price, this.fixPrice, this.code, this.images
  });

}

class Images{
  final List<String> assets;
  Images({this.assets});
}