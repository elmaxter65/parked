import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_flutter_2/src/repository/crud_firebase/src/models/models.dart';

class CarrouselMap extends StatelessWidget {
  final List<Todo> places;
  final dynamic onItemChanged;

  CarrouselMap({this.places, this.onItemChanged});

  _onChange(int page) {
    onItemChanged(page, places[page]);
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      onPageChanged: _onChange,
      autoPlay: false,
      height: 100.0,
      items: places.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF626487),
                      Color(0xFF393A51),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    tileMode: TileMode.clamp,
                  ),
                ),
                child: _buildCard(i));
          },
        );
      }).toList(),
    );
  }

  _buildCard(Todo place) {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            backgroundImage: NetworkImage(
                'https://digitalks.com.br/wp-content/uploads/2018/12/magazine-luiza-logo-1.png'),
            radius: 32.0,
          ),
        ),
        Expanded(
            child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Text(
                  place.task,
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Text(
                  place.formattedAddress,
                  style: TextStyle(color: Colors.white, fontSize: 12.0),
                  maxLines: 2,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Text(
                  '${''} - ${place.note}',
                  style: TextStyle(color: Colors.white, fontSize: 12.0),
                ),
              )
            ],
          ),
        )),
      ],
    );
  }
}
