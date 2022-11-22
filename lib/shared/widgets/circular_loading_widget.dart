import 'dart:async';
import 'package:d_rank/shared/shared.dart';
import 'package:flutter/material.dart';

class CircularLoadingWidget extends StatefulWidget {
  final double? height;
  final Color? color;

  const CircularLoadingWidget({Key? key, this.height, this.color})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CircularLoadingWidgetState createState() => _CircularLoadingWidgetState();
}

class _CircularLoadingWidgetState extends State<CircularLoadingWidget>
    with SingleTickerProviderStateMixin {
  Animation<double>? animation;
  AnimationController? animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    CurvedAnimation curve =
        CurvedAnimation(parent: animationController!, curve: Curves.easeOut);
    animation = Tween<double>(begin: widget.height, end: 0).animate(curve)
      ..addListener(() {
        if (mounted) {
          setState(() {});
        }
      });
    Timer(const Duration(seconds: 10), () {
      if (mounted) {
        animationController!.forward();
      }
    });
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: animation!.value / 100 > 1.0 ? 1.0 : animation!.value / 100,
      child: SizedBox(
        height: animation!.value,
        child: Center(
          child: CircularProgressIndicator(
            backgroundColor: widget.color ?? AppColors.primaryColor,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
      ),
    );
  }
}
