import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseWidget<T extends ChangeNotifier> extends StatefulWidget {
  final Widget Function(BuildContext context, T viewModel, Widget? child) builder;
  final T viewModel;
  final Widget? child;
  final Function(T)? onViewModelReady;

  const BaseWidget({
    Key? key,
    required this.builder,
    required this.viewModel,
    this.onViewModelReady,
    this.child,
  }) : super(key: key);

  @override
  _BaseWidgetState<T> createState() => _BaseWidgetState<T>();
}

class _BaseWidgetState<T extends ChangeNotifier> extends State<BaseWidget<T>> {
  T? model;

  @override
  void initState() {
    model = widget.viewModel;

    if (widget.onViewModelReady != null) {
      widget.onViewModelReady!(model!);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (context) => model!,
      child: Consumer<T>(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }
}
