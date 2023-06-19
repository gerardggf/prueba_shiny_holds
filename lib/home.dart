import 'package:flutter/material.dart';
import 'package:prueba_shiny_holds/load_wall.dart';

import 'main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Widget> holdsList;
  late List<Coordinates> holdsCoordinates;
  final image = Image.asset('assets/img/prueba.jpg');

  @override
  void initState() {
    super.initState();
    holdsList = [];
    holdsCoordinates = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: () {
          _save();
        },
      ),
      appBar: AppBar(
        elevation: 0,
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: (_) => const LoadRouteView(),
        //       ),
        //     );
        //   },
        //   icon: const Icon(Icons.home),
        // ),
        actions: [
          IconButton(
            onPressed: () {
              if (holdsList.isNotEmpty) {
                holdsList.removeLast();
              }
              setState(() {});
            },
            icon: const Icon(Icons.undo),
          ),
          IconButton(
            onPressed: () {
              holdsList.clear();
              setState(() {});
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: GestureDetector(
        onTapDown: (TapDownDetails details) {
          double x = (details.localPosition.dx - (30 / 2));
          double y = details.localPosition.dy - (30 / 2);
          holdsCoordinates.add(
            Coordinates(x: x, y: y),
          );
          holdsList.add(
            HoldWidget(
                key: Key('${x.toStringAsFixed(2)},${y.toStringAsFixed(2)}'),
                left: x,
                top: y),
          );
          setState(() {});
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(),
          ),
          child: Stack(
            children: [
              image,
              ...holdsList,
            ],
          ),
        ),
      ),
    );
  }

  void _save() {
    final double imageHeight = image.height ?? 0;
    final double imageWidth = image.width ?? 0;

    final List<Map<String, dynamic>> coordsMap = [{}];

    for (int i = 0; i < holdsCoordinates.length; i++) {
      coordsMap.add(
        {
          i.toString(): {
            'x': holdsCoordinates[i].x.toStringAsFixed(2),
            'y': holdsCoordinates[i].y.toStringAsFixed(2)
          },
        },
      );
    }
    final wallMap = {
      'image': 'prueba.jpg',
      'height': imageHeight,
      'width': imageWidth,
      'holds': coordsMap,
    };
    print(wallMap);

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (_) => LoadRouteView(
    //       wallMap: wallMap,
    //     ),
    //   ),
    // );
  }
}
