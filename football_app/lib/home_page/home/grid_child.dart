import 'package:flutter/material.dart';
import '../../features/colors_view.dart';
import '../../requests/request.dart';

class GridChild extends StatelessWidget {
  const GridChild(
      {Key? key, required this.imagePath, required this.description})
      : super(key: key);
  final String imagePath;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width / 2,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover, image: AssetImage(imagePath)),
                borderRadius: BorderRadius.circular(30)),
          ),
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) =>
                    getDialog(context, description));
          },
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          description,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

Dialog getDialog(BuildContext context, String description) {
  return Dialog(
    // shape: const RoundedRectangleBorder(
    //     borderRadius: BorderRadius.all(Radius.circular(32.0))),
    child: Container(
      decoration: BoxDecoration(
        color: MainColors.lightBlue,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32.0),
            topRight: Radius.circular(32.0),
            bottomLeft: Radius.circular(32.0),
            bottomRight: Radius.circular(32.0)),
      ),
      height: 240.0,
      width: 240.0,
      child: Column(
        children: <Widget>[
          const SizedBox(height: 30),
          SizedBox(
            height: 40,
            child: ElevatedButton(
              onPressed: () async {
                postLeagueTable(context, description);
              },
              child: const Text(
                'Teams',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          SizedBox(
            height: 40.0,
            child: ElevatedButton(
                onPressed: () async {
                  postLeaguePlayers(context, description);
                },
                child: const Text(
                  'Players',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                )),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 40.0,
            child: ElevatedButton(
                onPressed: () {
                  goToPrediction(context, description);
                },
                child: const Text(
                  'Make a prediction, buddy!',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                )),
          ),
        ],
      ),
    ),
  );
}
