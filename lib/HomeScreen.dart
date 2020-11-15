import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:slider_image/PhotoBloc.dart';
import 'package:slider_image/PhotoDemo.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final bloc = PhotoBloc();
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;

  @override
  void initState() {
    bloc.getPhotos();
    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Demo'),
        ),
        body: Container(
          child: StreamBuilder<Object>(
              stream: bloc.photosListStream,
              builder: (context, snapshot) {
                List<Photos> list = snapshot.data;
                return list == null
                    ? Center(
                        child: Container(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Container(
                        child: CarouselSlider.builder(
                          options: CarouselOptions(
                            pauseAutoPlayInFiniteScroll: true,
                            pauseAutoPlayOnManualNavigate: true,
                            enableInfiniteScroll: false,
                            autoPlay: false,
                            onPageChanged: (index, reason) {
                              _chewieController.pause();

                              if (list[index].fileType == 'VIDEO') {
                                _chewieController.play();
                              }
                            },
                          ),
                          itemCount: list == null ? 0 : list.length,
                          itemBuilder: (context, index) {
                            if (list[index].fileType == 'PICTURE') {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 4.0),
                                    child: Image.network(list[index].fileUrl)),
                              );
                            } else {
                              _videoPlayerController =
                                  VideoPlayerController.network(
                                      list[index].fileUrl);
                              _chewieController = ChewieController(
                                videoPlayerController: _videoPlayerController,
                                allowFullScreen: false,
                                autoPlay: false,
                                looping: false,
                                // Try playing around with some of these other options:
                                showControls: false,
                                placeholder: Container(
                                  color: Colors.grey,
                                ),
                                autoInitialize: true,
                              );
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.all(8.0),
                                child: Chewie(
                                  controller: _chewieController,
                                ),
                              );
                            }
                          },
                        ),
                      );
              }),
        ));
  }
}
