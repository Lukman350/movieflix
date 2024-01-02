import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

enum SkeletonType { horizontal, vertical }

class MovieCardSkeleton extends StatelessWidget {
  final SkeletonType type;
  final int itemCount;

  const MovieCardSkeleton({super.key, required this.type, this.itemCount = 10});

  Widget _horizontalSkeleton() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(4.0),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: SizedBox(
              width: 143,
              height: 283,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: SkeletonLine(
                      style: SkeletonLineStyle(
                        height: 194,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 6,
                        ),
                        SkeletonLine(
                          style: SkeletonLineStyle(
                            height: 16,
                            width: 130,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              SkeletonAvatar(
                                style: SkeletonAvatarStyle(
                                  width: 16,
                                  height: 16,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              SkeletonLine(
                                style: SkeletonLineStyle(
                                  height: 16,
                                  width: 40,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _verticalSkeleton() {
    return ListView.builder(
      padding: const EdgeInsets.all(4.0),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeletonLine(
                  style: SkeletonLineStyle(
                    width: 85,
                    height: 120,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                SizedBox(
                  height: 110,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 200,
                        child: SkeletonLine(
                          style: SkeletonLineStyle(
                            height: 16,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          SkeletonAvatar(
                            style: SkeletonAvatarStyle(
                              width: 16,
                              height: 16,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          SkeletonLine(
                            style: SkeletonLineStyle(
                              height: 16,
                              width: 50,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width - 150,
                            child: Row(
                              children: [
                                SkeletonLine(
                                  style: SkeletonLineStyle(
                                    height: 16,
                                    width: 50,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                SkeletonLine(
                                  style: SkeletonLineStyle(
                                    height: 16,
                                    width: 50,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                SkeletonLine(
                                  style: SkeletonLineStyle(
                                    height: 16,
                                    width: 50,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ],
                            )),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 16,
                          width: 100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return type == SkeletonType.horizontal
        ? _horizontalSkeleton()
        : _verticalSkeleton();
  }
}

class MovieCardSkeletonSingle extends StatelessWidget {
  const MovieCardSkeletonSingle({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 132,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SkeletonLine(
            style: SkeletonLineStyle(
              width: 85,
              height: 120,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          SizedBox(
            height: 110,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 200,
                  child: SkeletonLine(
                    style: SkeletonLineStyle(
                      height: 16,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                        width: 16,
                        height: 16,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    SkeletonLine(
                      style: SkeletonLineStyle(
                        height: 16,
                        width: 50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width - 150,
                      child: Row(
                        children: [
                          SkeletonLine(
                            style: SkeletonLineStyle(
                              height: 16,
                              width: 50,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          SkeletonLine(
                            style: SkeletonLineStyle(
                              height: 16,
                              width: 50,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          SkeletonLine(
                            style: SkeletonLineStyle(
                              height: 16,
                              width: 50,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ],
                      )),
                ),
                SkeletonLine(
                  style: SkeletonLineStyle(
                    height: 16,
                    width: 100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
