

import 'package:flutter/material.dart';
import 'package:nike_app/model/post.dart';
import 'package:nike_app/utils/utils.dart';
import 'package:nike_app/widget/detail_product.dart';


class Home extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => HomeState();

}

class HomeState extends State<Home>{
 List<Post> listPost = [
    Post(title:"Air Max 270 \"Gold\"", price: 230, fixPrice: 187, code:"270", images: Images(assets:["assets/images/air max 270.png", "assets/images/air max 270_2.png", "assets/images/air max 270.png"])),
    Post(title:"Air Max 90 EZ Black", price: 200, fixPrice: 157,  code:"90",images: Images(assets:["assets/images/air_max_90_black_white.png", "assets/images/air_max_90_black_white.png", "assets/images/air_max_90_black_white.png"])),
    Post(title:"Air Max 2017 Black White", price: 220, fixPrice: 198, code:"2017", images: Images(assets:["assets/images/air_max_2017_black_white.png", "assets/images/air_max_2017_black_white_2.png", "assets/images/air_max_2017_black_white.png"])),
    Post(title:"Air Max 270 \"Gold\"", price: 230, fixPrice: 187,  code:"270",images: Images(assets:["assets/images/air max 270.png", "assets/images/air max 270_2.png", "assets/images/air max 270.png"])),
    Post(title:"Air Max 90 EZ Black", price: 200, fixPrice: 157,  code:"90",images: Images(assets:["assets/images/air_max_90_black_white.png", "assets/images/air_max_90_black_white.png", "assets/images/air_max_90_black_white.png"])),
    Post(title:"Air Max 2017 Black White", price: 220, fixPrice: 198, code:"2017", images: Images(assets:["assets/images/air_max_2017_black_white.png", "assets/images/air_max_2017_black_white_2.png", "assets/images/air_max_2017_black_white.png"])),
    Post(title:"Air Max 270 \"Gold\"", price: 230, fixPrice: 187,  code:"270",images: Images(assets:["assets/images/air max 270.png", "assets/images/air max 270_2.png", "assets/images/air max 270.png"])),
    Post(title:"Air Max 90 EZ Black", price: 200, fixPrice: 157,  code:"90",images: Images(assets:["assets/images/air_max_90_black_white.png", "assets/images/air_max_90_black_white.png", "assets/images/air_max_90_black_white.png"])),
    Post(title:"Air Max 2017 Black White", price: 220, fixPrice: 198, code:"2017", images: Images(assets:["assets/images/air_max_2017_black_white.png", "assets/images/air_max_2017_black_white_2.png", "assets/images/air_max_2017_black_white.png"])),
 ];
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Image(image: AssetImage("assets/images/logo_nike.png"), width: 50),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: Container(
            child: ListView.builder(itemBuilder: (BuildContext context, int index) {
              final int randomIndex = Utils.randomRange(0, 4);
              final Post postItem = listPost[index];
              return GestureDetector(
                child: ItemList(post:postItem, randomIndex: randomIndex),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetailProduct(
                      randomColor: randomIndex,
                      post: postItem,
                    )),
                  );
                },
              );
               
            }, itemCount: listPost.length,
            ),
          ),
          flex: 6,
        ),
       Container(
         height: 46,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child:Icon(Icons.home, color: Colors.black38),
                    flex: 1,
                  ),
                 Expanded(
                    child:Icon(Icons.search, color: Colors.black12),
                    flex: 1,
                  ),
                  Expanded(
                    child:Icon(Icons.shop, color: Colors.black12),
                    flex: 1,
                  ),
                  Expanded(
                    child:Icon(Icons.account_circle, color: Colors.black12),
                    flex: 1,
                  )
                ],
            ),
        )
      ],
      ),
    );
    
    
  }

}

class ItemList extends StatefulWidget{
  final Post post;
  final int randomIndex;
  ItemList({this.post, this.randomIndex});
  @override
  State<StatefulWidget> createState() => ItemListState();
}

class ItemListState extends State<ItemList>{
  
  @override
  Widget build(BuildContext context) {
   Color randomColor = Utils.getRamdomColor(widget.randomIndex);

    return Padding(
      padding: EdgeInsets.all(10),
    child:Card(
      shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
      child: Stack(
        children: <Widget>[
          Container(
            height: 300,
            color: randomColor,
          ),
          Container(
            margin: EdgeInsets.only(top: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[Text(widget.post.code, style: TextStyle(color: 
              Utils.getRamdomColorText(widget.randomIndex), fontSize: 90), textAlign: TextAlign.center)]
            ),
          ),
          Center(
            child: Image(
              image: AssetImage(widget.post.images.assets[0]),
              width: 280,
              height: 280,
            ),
          ),
          Positioned(
          bottom: 0.0,
          child: 
            Container(
              width: MediaQuery.of(context).size.width,
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 30),
                  child: Text(widget.post.title, style: TextStyle(fontSize: 17, color: Colors.black38))
                ),
                Padding(
                  padding: EdgeInsets.only(right: 30),
                  child:Text("\$"+widget.post.price.toString(), style: TextStyle(fontSize: 17, color: Colors.black26,  decoration: TextDecoration.lineThrough), )
                ),
                Padding(
                  padding: EdgeInsets.only(left:10, right: 10, top: 2, bottom: 10),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(Icons.favorite_border, color: Colors.black12, size: 30,),
                    Padding(
                      padding: EdgeInsets.only(left: 40, right: 40),
                      child:Text("\$"+widget.post.fixPrice.toString(), style: TextStyle(fontSize: 20, color: Colors.black), textAlign: TextAlign.center,)
                    ),
                    Padding(
                      padding:EdgeInsets.only(right: 30),
                      child:Icon(Icons.shop, color: Colors.black12, size: 30,)
                    )
                  ],
                )
                )
              ],
            ),
            )
          )
          
        ],
      ),
    )
    );
  }


}
