import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class MovieDetailsSkeleton extends StatelessWidget {
  const MovieDetailsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          SkeletonLine(
            style: SkeletonLineStyle(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              borderRadius: BorderRadius.circular(0),
            ),
          ),
          Positioned(
            top: 250,
            child: Container(
              height: MediaQuery.of(context).size.height - 250,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.1),
                    offset: const Offset(0, -10),
                    blurRadius: 30,
                  ),
                ],
              ),
              child: Scrollable(
                physics: const BouncingScrollPhysics(),
                viewportBuilder: (context, position) => SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 6,
                            child: SkeletonLine(
                              style: SkeletonLineStyle(
                                height: 25,
                                width: 200,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          SkeletonAvatar(
                            style: SkeletonAvatarStyle(
                              width: 32,
                              height: 32,
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Row(
                        children: [
                          SkeletonLine(
                            style: SkeletonLineStyle(
                              height: 24,
                              width: 24,
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          SkeletonLine(
                            style: SkeletonLineStyle(
                              height: 24,
                              width: 50,
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 20,
                          width: 150,
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Length',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromARGB(255, 156, 156, 156),
                                ),
                              ),
                              SkeletonLine(
                                style: SkeletonLineStyle(
                                  height: 16,
                                  width: 80,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Language',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromARGB(255, 156, 156, 156),
                                ),
                              ),
                              SkeletonLine(
                                style: SkeletonLineStyle(
                                  height: 16,
                                  width: 80,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Release Date',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromARGB(255, 156, 156, 156),
                                ),
                              ),
                              SkeletonLine(
                                style: SkeletonLineStyle(
                                  height: 16,
                                  width: 80,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Description',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 17, 14, 71),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SkeletonLine(
                                style: SkeletonLineStyle(
                                  height: 16,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              SkeletonLine(
                                style: SkeletonLineStyle(
                                  height: 16,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              SkeletonLine(
                                style: SkeletonLineStyle(
                                  height: 16,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              SkeletonLine(
                                style: SkeletonLineStyle(
                                  height: 16,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              SkeletonLine(
                                style: SkeletonLineStyle(
                                  height: 16,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              SkeletonLine(
                                style: SkeletonLineStyle(
                                  height: 16,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Cast',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 17, 14, 71),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                            height: 150,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 10,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.only(right: 8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SkeletonAvatar(
                                        style: SkeletonAvatarStyle(
                                          width: 72,
                                          height: 72,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      const SkeletonLine(
                                        style: SkeletonLineStyle(
                                          height: 16,
                                          width: 40,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(8),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
