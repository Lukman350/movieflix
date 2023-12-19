import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final bool grid;

  const MovieCard({super.key, this.grid = false});

  Widget gridView() {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {},
      child: ListTile(
        leading: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: const DecorationImage(
              image: NetworkImage(
                  'https://image.tmdb.org/t/p/w500/xbSuFiJbbBWCkyCCKIMfuDCA4yV.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: const Text(
          'The Conjuring: The Devil Made Me Do It',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        subtitle: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 4,
            ),
            Text(
              'Horror, Mystery, Thriller',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color.fromARGB(255, 170, 169, 177),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Icon(
                  Icons.star,
                  color: Color.fromARGB(255, 255, 195, 25),
                  size: 16,
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  '4.5',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w200,
                    color: Color.fromARGB(255, 156, 156, 156),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget listView() {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: SizedBox(
          width: 143,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  height: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                    ],
                    image: const DecorationImage(
                      scale: 1.0,
                      image: NetworkImage(
                          'https://image.tmdb.org/t/p/w500/xbSuFiJbbBWCkyCCKIMfuDCA4yV.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'The Conjuring: The Devil Made Me Do It',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Badge(
                          backgroundColor: Color.fromARGB(255, 219, 227, 255),
                          textColor: Color.fromARGB(255, 136, 164, 232),
                          label: Text(
                            'Horror',
                            style: TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: 4),
                        Badge(
                          backgroundColor: Color.fromARGB(255, 219, 227, 255),
                          textColor: Color.fromARGB(255, 136, 164, 232),
                          label: Text(
                            'Mystery',
                            style: TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: 4),
                        Badge(
                          backgroundColor: Color.fromARGB(255, 219, 227, 255),
                          textColor: Color.fromARGB(255, 136, 164, 232),
                          label: Text(
                            'Thriller',
                            style: TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Color.fromARGB(255, 255, 195, 25),
                          size: 16,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          '4.5',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w200,
                            color: Color.fromARGB(255, 156, 156, 156),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return grid ? gridView() : listView();
  }
}
