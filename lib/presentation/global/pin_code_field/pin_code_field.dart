// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/internal/utils/infrastructure.dart';

class PinCodeField extends StatefulWidget {
  const PinCodeField({
    Key? key,
    required this.onChanged,
    this.length = 6,
    this.inputType = TextInputType.number,
    this.autofocus = true,
    this.focusNode,
  }) : super(key: key);

  /// The length of a code.
  final int length;

  /// Code input type.
  final TextInputType inputType;

  /// On changed code callback.
  final Function(String) onChanged;

  /// Whether to autofocus or not.
  final bool autofocus;

  /// Field focus node.
  final FocusNode? focusNode;

  @override
  State<PinCodeField> createState() => _PinCodeFieldState();
}

class _PinCodeFieldState extends State<PinCodeField> {
  final FocusNode focusNode = FocusNode();

  /// Value of text field.
  String value = '';

  /// Padding between pins.
  double get pinsPadding => 8.w;

  FocusNode get _focusNode => widget.focusNode ?? focusNode;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback(
      (_) => _focusNode.requestFocus(),
    );

    super.initState();
  }

  String valueForPin(int index) {
    if (index > value.length - 1) {
      return '';
    } else {
      return value[index];
    }
  }

  void onValueChanged(String value) {
    setState(
      () => this.value = value.toUpperCase(),
    );

    widget.onChanged(this.value);
  }

  Widget _buildInvisibleTextField(BuildContext context) {
    return Opacity(
      opacity: 0,
      child: SizedBox(
        height: 0.01,
        child: TextField(
          focusNode: _focusNode,
          autofocus: widget.autofocus,
          keyboardType: widget.inputType,
          onChanged: onValueChanged,
          enableSuggestions: false,
          autocorrect: false,
          obscureText: true,
          style: const TextStyle(
            height: 0.01,
            color: NColors.transparent,
          ),
          inputFormatters: [
            LengthLimitingTextInputFormatter(widget.length),
          ],
        ),
      ),
    );
  }

  Widget _buildPins(BuildContext context, {required double layoutWidth}) {
    final double pinHeight = 56.h;

    return SizedBox(
      width: layoutWidth,
      height: pinHeight,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: widget.length,
          crossAxisSpacing: pinsPadding,
          mainAxisExtent: pinHeight,
        ),
        itemBuilder: (context, index) {
          return _PinValue(
            value: valueForPin(index),
          );
        },
        itemCount: widget.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // To request focus when keyboard disappears.
      onTap: () => _focusNode.requestFocus(),

      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              _buildInvisibleTextField(context),
              _buildPins(context, layoutWidth: constraints.maxWidth),
            ],
          );
        },
      ),
    );
  }
}

class _PinValue extends StatefulWidget {
  const _PinValue({Key? key, required this.value}) : super(key: key);

  final String value;

  @override
  State<_PinValue> createState() => __PinValueState();
}

class __PinValueState extends State<_PinValue> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: NConstants.defaultAnimationDuration * 0.5,
    );
  }

  @override
  void didUpdateWidget(_PinValue oldWidget) {
    if (widget.value == '') {
      _controller.reverse();
    } else {
      _controller.forward();
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: NColors.gray2,
      ),
      child: Center(
        child: AnimatedBuilder(
          animation: _controller,
          child: Text(widget.value, style: NTypography.rfDewiRegular14),
          builder: (context, child) => Transform.scale(
            scale: _controller.value,
            child: Opacity(
              opacity: _controller.value,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
