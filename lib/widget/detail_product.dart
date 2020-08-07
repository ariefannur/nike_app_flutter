import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nike_app/model/post.dart';
import 'package:nike_app/utils/utils.dart';

class DetailProduct extends StatefulWidget{
  
  final int randomColor;
  final Post post;
  final PageController pageController = PageController();
  DetailProduct({this.randomColor, this.post});

  @override
  State<StatefulWidget> createState() => DetailProductState();

}

class DetailProductState extends State<DetailProduct>{
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
        title: Center(
          child: Image(image: AssetImage("assets/images/logo_nike.png"), width: 50),
        ),
        backgroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black87,
        child: Icon(Icons.shopping_basket), onPressed: (){
         _optionChartBottomSheet(context, widget.post);
        },
      ),
      body: ListView(
        children:<Widget>[
         Column( // top image
          children: <Widget>[
              Container(
                color: Utils.getRamdomColor(widget.randomColor),
                height: 320,
                width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: <Widget>[
                      Padding( // text code 
                      padding:EdgeInsets.only(top:50),
                      child:
                        Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:<Widget>[ Text(widget.post.code, style: TextStyle(color: 
                          Utils.getRamdomColorText(widget.randomColor), fontSize: 90), textAlign: TextAlign.center)
                        ])
                      ),
                      PageView.builder(
                        itemBuilder: (context, position){
                          return ImagePager(image: widget.post.images.assets[position]);
                        },
                        controller: widget.pageController,
                        itemCount: widget.post.images.assets.length,
                      ),
                      new Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: new Container(
                          padding: const EdgeInsets.only(bottom: 24),
                          child: new Center(
                            child: new DotsIndicator(
                              controller: widget.pageController,
                              itemCount: widget.post.images.assets.length,
                              onPageSelected: (int page) {
                                widget.pageController.animateToPage(
                                  page,
                                  duration: Duration(milliseconds: 200),
                                  curve: Curves.ease,
                                );
                              },
                            ),
                          ),
                        ),
                      )
                    ],
                ),
              )
          
          ],
        ), // Header Detail Post
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
             Padding(
                padding: EdgeInsets.all(16),
                child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:<Widget>[
                Text(widget.post.title, style: TextStyle(fontSize: 22),),
               Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text("\$"+widget.post.price.toString(), style: TextStyle(fontSize: 17, color: Colors.black26,  decoration: TextDecoration.lineThrough)),
                    Text("\$"+widget.post.fixPrice.toString(), style: TextStyle(fontSize: 20, color: Colors.black)),
                  ],  
                )
              ]
              )
             ),
           

          ],
        ),
        Padding(padding:EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 8),
         child:Column(
           crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(child:Padding(padding:EdgeInsets.only(bottom: 16) ,child:Text("AVAILABLE SIZE", textAlign: TextAlign.center,))),
            Row(
              children: <Widget>[
                Padding(padding:EdgeInsets.only(right: 16), child:Text("US 6", style: TextStyle(color: Colors.black, fontSize: 16))),
                Padding(padding:EdgeInsets.only(right: 16), child:Text("US 7", style: TextStyle(color: Colors.black, fontSize: 16))),
                Padding(padding:EdgeInsets.only(right: 16), child:Text("US 8", style: TextStyle(color: Colors.black, fontSize: 16))),
                Padding(padding:EdgeInsets.only(right: 16), child:Text("US 9", style: TextStyle(color: Colors.black, fontSize: 16))),
                Padding(padding:EdgeInsets.only(right: 16), child:Text("US 9.5", style: TextStyle(color: Colors.black, fontSize: 16))),
                Padding(padding:EdgeInsets.only(right: 16), child:Text("US 10", style: TextStyle(color: Colors.black, fontSize: 16))),

               
              ],
            ),
            Padding(padding:EdgeInsets.only(top: 16, bottom: 8), child:Text("DESCRIPTION")),
            Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book")
          ],
        ))

        ]
      ),
    );
  }

  void _optionChartBottomSheet(context, Post post){
  
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc){
        return ModalContainer(post: post);
      });
}

}

class ModalContainer extends StatefulWidget{
  
  final Post post;
  ModalContainer({this.post});

  @override
  State<StatefulWidget> createState() => ModalContainerState();

}

class ModalContainerState extends State<ModalContainer> with TickerProviderStateMixin{
  int selectPosition = 5;
  AnimationController controller;
  Animation<double> sizeAnimation;
  Animation<double> sizeAnimationHeight;
  int width = 0;
  bool animationStart= false;

  @override
  void initState() {
    
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
        width: !animationStart ? MediaQuery.of(context).size.width : sizeAnimation.value,
        height: !animationStart ? 500: sizeAnimationHeight.value,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
          color: Colors.white
        ),
          child: Padding(padding:EdgeInsets.only(left:8, right: 10, top:16, bottom:16), 
          child:Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                  child:Image(
                    image: AssetImage(widget.post.images.assets[0]),
                    width: sizeAnimation == null ? 150 : sizeAnimation.value,
                    height: 150,
                   ),
                   flex: 1,
                  ),
                  Expanded(
                  child:Text(widget.post.title, style: TextStyle(fontSize: 20)),
                  flex: 1,
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 4, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:<Widget>[
                    Padding(padding:EdgeInsets.only(right:10), child:Icon(Icons.unfold_more, color: Colors.black38)),
                    Text("Select Size ", style: TextStyle(fontSize: 16, color: Colors.black38),)
                  ]
                )
              ),
              Container(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        setState(() => selectPosition = 0);
                      },
                      child:
                      SizeContainer(text: "US 6", isSelect: selectPosition == 0, position: 0)
                    ),
                    GestureDetector(
                      onTap: (){
                        setState(() => selectPosition = 1);
                      },
                    child:SizeContainer(text: "US 7", isSelect: selectPosition == 1, position: 1)
                    ),
                    GestureDetector(
                      onTap: (){
                        setState(() => selectPosition = 2);
                      },
                    child:SizeContainer(text: "US 8", isSelect: selectPosition == 2, position: 2)
                    ),
                    GestureDetector(
                      onTap: (){
                        setState(() => selectPosition = 3);
                      },
                    child:SizeContainer(text: "US 9", isSelect: selectPosition == 3, position: 3)
                    ),
                    GestureDetector(
                      onTap: (){
                        setState(() => selectPosition = 4);
                      },
                    child:SizeContainer(text: "US 9", isSelect: selectPosition == 4, position: 4)
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(top: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  color: selectPosition < 5 ? Colors.black : Colors.white
                ),
                child: 
                  GestureDetector(
                    onTap: (){
                      print("click anim");
                      setState(()=> animationStart = true);
                      width = 300;
                        controller =  AnimationController(duration: Duration(milliseconds: 1000), vsync: this);
                      closeAnimation();
                    },
                    child:Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(Icons.shopping_basket, color: selectPosition < 5 ? Colors.white : Colors.black38,),
                        Padding(padding: EdgeInsets.only(left: 8),child:Text("Add to Chart", style:TextStyle(color: selectPosition < 5 ? Colors.white : Colors.black38)))
                      ],
                    ),
                  )
              )
            ],
          )),
        );
  }

  void closeAnimation(){
    
    final Animation curve =CurvedAnimation(parent: controller, curve: Curves.easeIn);
    sizeAnimation = Tween<double>(begin: width.toDouble(), end: 150).animate(curve);
    sizeAnimationHeight = Tween<double>(begin: 500, end: 150).animate(curve);
    sizeAnimation.addListener((){
      setState(() {
          print("animation "+sizeAnimation.value.toString());
          
      });
    });

    controller.forward();
    
  }

}



class SizeContainer extends StatefulWidget{
  final String text;
  final bool isSelect;
  final int position;
  SizeContainer({this.text, this.isSelect, this.position});
  @override
  State<StatefulWidget> createState() => SizeContainerState();

}

class SizeContainerState extends State<SizeContainer>{
  
  @override
  Widget build(BuildContext context) {
    return 
      Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: widget.isSelect ? Colors.black : Colors.white
      ),
      child: Text(widget.text, style: TextStyle(color: widget.isSelect ? Colors.white : Colors.black, fontSize: 16)),
    );
  }

}


class ImagePager extends StatelessWidget{
  final String image;
  ImagePager({this.image});

  @override
  Widget build(BuildContext context) {
    return 
      Center(
            child: Image(
              image: AssetImage(image),
              width: 280,
              height: 280,
            ),
          );
    
  }

}

class DotsIndicator extends AnimatedWidget {
  DotsIndicator({
    this.controller,
    this.itemCount,
    this.onPageSelected,
    this.color: Colors.white,
  }) : super(listenable: controller);

  /// The PageController that this DotsIndicator is representing.
  final PageController controller;

  /// The number of items managed by the PageController
  final int itemCount;

  /// Called when a dot is tapped
  final ValueChanged<int> onPageSelected;

  /// The color of the dots.
  ///
  /// Defaults to `Colors.white`.
  final Color color;

  // The base size of the dots
  static const double _kDotSize = 8.0;

  // The increase in the size of the selected dot
  static const double _kMaxZoom = 2.0;

  // The distance between the center of each dot
  static const double _kDotSpacing = 25.0;

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
      ),
    );
    double zoom = 1.0 + (_kMaxZoom - 1.0) * selectedness;
    return new Container(
      color: Colors.transparent,
      width: _kDotSpacing,
      child: new Center(
        child: new Material(
          color: color,
          type: MaterialType.circle,
          child: new Container(
            width: _kDotSize * zoom,
            height: _kDotSize * zoom,
            child: new InkWell(
              onTap: () => onPageSelected(index),
            ),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: new List<Widget>.generate(itemCount, _buildDot),
    );
  }
}


