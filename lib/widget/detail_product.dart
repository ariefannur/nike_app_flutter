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
        Padding(padding:EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 8), child:Column(
          children: <Widget>[
            Text("AVAILABLE SIZE")
          ],
        ))

        ]
      ),
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