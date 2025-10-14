import 'package:flutter/material.dart';
import 'package:flutter_advanced_2025/app/model/product.dart';

class _FrontLayer extends StatelessWidget {
  const _FrontLayer({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 16,
      shape: const BeveledRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(46))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: child)
        ],
      ),
    );
  }
}

class Backdrop extends StatefulWidget {
  const Backdrop({
    super.key,
    required this.frontLayer,
    required this.backLayer,
    required this.frontTitle,
    required this.backTitle,
    required this.currentCategory
  });

  final Category currentCategory;
  final Widget frontLayer;
  final Widget backLayer;
  final Widget frontTitle;
  final Widget backTitle;

  @override
  State<Backdrop> createState() => _BackdropState();
}

class _BackdropState extends State<Backdrop> with SingleTickerProviderStateMixin {
  final GlobalKey _backdropKey = GlobalKey(debugLabel: 'Backdrop');

  Widget _buildStack(){
    return Stack(
      key: _backdropKey,
      children: [
        widget.backLayer,
        _FrontLayer(child: widget.frontLayer)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      elevation: 0,
      titleSpacing: 0,
      leading: Icon(Icons.menu),
      title: Text('SHRINE'),
      actions: [
        IconButton(onPressed: (){}, icon: Icon(Icons.search)),
        IconButton(onPressed: (){}, icon: Icon(Icons.tune)),
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: _buildStack(),
    );
  }
}