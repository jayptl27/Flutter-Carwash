import 'package:flutter/material.dart';
import 'package:flutter_carwash/models/catalog.dart';
import 'package:flutter_carwash/widgets/home_widgets/add_to_cart.dart';
import 'package:flutter_carwash/widgets/themes.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeDetailPage extends StatelessWidget {
  final Item catalog;

  const HomeDetailPage({Key key, @required this.catalog})
      : assert(catalog != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      backgroundColor: MyTheme.creamColor,
      bottomNavigationBar: Container(
        color: Colors.white,
        child: ButtonBar(
          alignment: MainAxisAlignment.spaceBetween,
          buttonPadding: EdgeInsets.zero,
          children: [
            "\$ ${catalog.price}".text.bold.xl4.red800.make(),
            AddToCart(
              catalog: catalog,
            ).wh(100, 50)
          ],
        ).p(24),
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Hero(
                    tag: Key(catalog.id.toString()),
                    child: Image.asset(catalog.image))
                .h32(context)
                .wFourFifth(context),
            Expanded(
                child: VxArc(
              height: 30.0,
              arcType: VxArcType.CONVEY,
              edge: VxEdge.TOP,
              child: Container(
                color: Colors.white,
                width: context.screenWidth,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      catalog.name.text.xl4
                          .color(MyTheme.darkBluishColor)
                          .bold
                          .center
                          .make(),
                      5.heightBox,
                      catalog.desc.text
                          .textStyle(context.captionStyle)
                          .center
                          .base
                          .fontWeight(FontWeight.bold)
                          .make()
                          .p2(),
                      5.heightBox,
                      "Duration : ${catalog.duration}"
                          .text
                          .center
                          .lg
                          .red800
                          .bold
                          .make(),
                      catalog.desctwo.text
                          .textStyle(context.captionStyle)
                          .lg
                          .justify
                          .make()
                          .p16(),
                    ],
                  ).py(64),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
