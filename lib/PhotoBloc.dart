import 'dart:async';

import 'package:slider_image/AppUtils.dart';
import 'package:slider_image/Bloc.dart';
import 'package:slider_image/PhotoDemo.dart';

class PhotoBloc implements Bloc {
  final _controller = StreamController<List<Photos>>();

  Stream get photosListStream => _controller.stream;

  void getPhotos() {
    List<Photos> photoList = AppUtils().photosList;
    print("No. of photos on bloc ${photoList.length.toString()}");
    _controller.sink.add(photoList);
  }

  @override
  void dispose() {
    _controller.close();
  }
}
