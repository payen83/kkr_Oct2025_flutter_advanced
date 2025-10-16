import 'package:flutter/material.dart';
import 'package:flutter_advanced_2025/app/model/product.dart';
import 'package:flutter_advanced_2025/app/widget/drawer.widget.dart';

class _FrontLayer extends StatelessWidget {
  const _FrontLayer({required this.child, required this.onTap});
  final Widget child;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 16,
      shape: const BeveledRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(46)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onTap,
            child: Container(height: 40, alignment: AlignmentDirectional.centerStart,),
          ),
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
    required this.currentCategory,
  });

  final Category currentCategory;
  final Widget frontLayer;
  final Widget backLayer;
  final Widget frontTitle;
  final Widget backTitle;

  @override
  State<Backdrop> createState() => _BackdropState();
}

class _BackdropState extends State<Backdrop>
    with SingleTickerProviderStateMixin {
  final GlobalKey _backdropKey = GlobalKey(debugLabel: 'Backdrop');

  late AnimationController _controller;
  static final double _kFlingVelocity = 2.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      value: 1,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant Backdrop oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(widget.currentCategory != oldWidget.currentCategory){
      _toggleBackdropLayerVisibility();
    } else if(!_frontLayerVisible){
      _controller.fling(velocity: _kFlingVelocity);
    }
  }

  bool get _frontLayerVisible {
    final AnimationStatus status = _controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  void _toggleBackdropLayerVisibility() {
    _controller.fling(
      velocity: _frontLayerVisible ? -_kFlingVelocity : _kFlingVelocity,
    );
  }

  Widget _buildStack(BuildContext context, BoxConstraints constraints) {
    const double layerTitleHeight = 48.0;
    final Size layerSize = constraints.biggest;
    final double layerTop = layerSize.height - layerTitleHeight;

    Animation<RelativeRect> layerAnimation = RelativeRectTween(
      begin: RelativeRect.fromLTRB(
        0.0,
        layerTop,
        0.0,
        layerTop - layerSize.height,
      ),
      end: const RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
    ).animate(_controller.view);

    return Stack(
      key: _backdropKey,
      children: [
        ExcludeSemantics(
          excluding: _frontLayerVisible,
          child: widget.backLayer,
        ),
        PositionedTransition(
          rect: layerAnimation,
          child: _FrontLayer(onTap: _toggleBackdropLayerVisibility, child: widget.frontLayer)
        ),
      ],
    );
  }
  
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      elevation: 0,
      titleSpacing: 0,
      leading: IconButton(onPressed: _toggleBackdropLayerVisibility, icon: Icon(Icons.menu)),
      title: Text('SHRINE'),
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        IconButton(onPressed: () {
          _scaffoldKey.currentState?.openDrawer();
        }, icon: Icon(Icons.tune)),
      ],
    );

    return Scaffold(
      appBar: appBar, 
      key: _scaffoldKey,
      drawer: DrawerWidget(),
      body: LayoutBuilder(builder: _buildStack
    ));
  }
}
