import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageView extends StatefulWidget {
  final String url;
  ImageView({this.url});

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  PhotoViewScaleStateController scaleStateController;
  @override
  void initState() {
    super.initState();
    scaleStateController = PhotoViewScaleStateController();
  }

  @override
  void dispose() {
    scaleStateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(247, 249, 249, 1),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0.0,
        backgroundColor: Colors.black,
      ),
      body: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: Colors.black),
        child: Hero(
          tag: 'image-view',
          child: GestureDetector(
            onVerticalDragEnd: (DragEndDetails dragEndDetails) => {
              if (dragEndDetails.primaryVelocity > 100.0)
                {Navigator.of(context).pop()}
            },
            child: PhotoView(
                enableRotation: false,
                tightMode: true,
                scaleStateController: scaleStateController,
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.contained,
                imageProvider: widget.url != null
                    ? NetworkImage(
                        widget.url,
                      )
                    : AssetImage(
                        "assets/images/person_placeholder.png",
                      )),
          ),
        ),
      ),
    );
  }
}
