// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/internal/services/helpers.dart';
import 'package:norm/internal/utils/infrastructure.dart';

class NTextField extends StatefulWidget {
  const NTextField({
    Key? key,
    this.controller,
    this.prefix,
    this.suffix,
    this.initialValue,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.hintText,
    this.height,
    this.width,
    this.borderRadius,
    this.capitalization,
    this.textInputAction,
    this.keyboardType,
    this.autofocus = false,
    this.obscureText = false,
    this.error,
    this.successful,
    this.errorText,
    this.maxLines,
    this.suggestions = const [],
    this.suggestionsBuilder,
    this.disableHorizontalPadding = false,
    this.transparentFill = false,
  }) : super(key: key);

  static const double defaultHeight = 52;

  final Function(String)? onChanged;

  final Function(String)? onSubmitted;

  final Function()? onTap;

  final TextEditingController? controller;

  /// Prefix widget.
  final Widget? prefix;

  /// Prefix widget.
  final Widget? suffix;

  /// Textfield custom height.
  final double? height;

  /// Textfield custom width.
  final double? width;

  /// Initial text value.
  final String? initialValue;

  /// Textfield custom border radius.
  final BorderRadius? borderRadius;

  /// Text field hint text.
  final String? hintText;

  /// Text capitalization;
  final TextCapitalization? capitalization;

  /// Keyboard type.
  final TextInputType? keyboardType;

  /// Text input action.
  final TextInputAction? textInputAction;

  /// Enable auto focus or not.
  final bool autofocus;

  /// Hide inputted text or not.
  final bool obscureText;

  final bool? successful;

  final int? maxLines;

  /// Error in form.
  final bool? error;

  /// Error text.
  final String? errorText;

  /// Field suggestions.
  final List<dynamic> suggestions;

  /// Suggestions widget builder.
  final Widget Function(int index)? suggestionsBuilder;

  /// Removes horizontal content padding.
  final bool disableHorizontalPadding;

  /// Removes fill from text field.
  final bool transparentFill;

  @override
  State<NTextField> createState() => _NTextFieldState();
}

class _NTextFieldState extends State<NTextField> {
  static const double maxDropdownHeight = 300;

  final FocusNode _focusNode = FocusNode();
  late TextEditingController _controller;

  final GlobalKey _globalKey = GlobalKey();

  /// If suggestions overlay is expanded or not.
  bool isExpanded = false;

  /// Dropdown overlay.
  OverlayEntry? overlay;

  //
  bool _hasFocus = false;

  @override
  void initState() {
    _focusNode.addListener(() {
      if (_hasFocus && !_focusNode.hasFocus) {
        // Now text field doesn't have active focus.
        if (_controller.text.isNotEmpty) widget.onSubmitted?.call(_controller.text);
      }

      _hasFocus = _focusNode.hasFocus;

      if (!_hasFocus && isExpanded) toggleDropdown();
    });

    _controller = widget.controller ?? TextEditingController(text: widget.initialValue);

    if (widget.initialValue != null && widget.controller != null) {
      widget.controller!.value = TextEditingValue(
        text: widget.initialValue!,
        selection: TextSelection.collapsed(offset: widget.initialValue!.length),
      );
    }

    super.initState();
  }

  @override
  void didUpdateWidget(NTextField oldWidget) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (widget.suggestions != oldWidget.suggestions && isExpanded) {
        toggleDropdown();
        toggleDropdown();
      }

      // If state of emptiness of suggestions list has changed.
      if ((widget.suggestions.isNotEmpty && !isExpanded) || (widget.suggestions.isEmpty && isExpanded)) {
        toggleDropdown();
      }
    });

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    if (isExpanded) toggleDropdown();

    super.dispose();
  }

  void toggleDropdown() {
    // If dropdown was expanded we need to close overlay.
    if (isExpanded) {
      overlay?.remove();
      overlay = null;
    }
    // Else show overlay.
    else if (!isExpanded) {
      overlay = _buildSuggestionsOverlay();

      // Insert overlay entry.
      if (mounted) Overlay.of(context)!.insert(overlay!);
    }

    if (mounted) setState(() => isExpanded = !isExpanded);
  }

  Color get _borderColor {
    if (widget.error == null && widget.successful == null) {
      return NColors.transparent;
    }

    if (widget.error != null) {
      if (widget.error!) {
        return NColors.redError;
      }
    }

    if (widget.successful != null) {
      if (widget.successful!) {
        return NColors.greenPrimary;
      }
    }

    return NColors.transparent;
  }

  OverlayEntry _buildSuggestionsOverlay() {
    final RenderBox renderBox = _globalKey.currentContext!.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;

    final double topOffset = offset.dy + size.height + 12.h;
    final double leftOffset = offset.dx;

    final double heightFromBottom = MediaQuery.of(context).size.height - topOffset - 24.h;

    final Size maxDropdownSize = Size(
      size.width,
      heightFromBottom.clamp(0, maxDropdownHeight).toDouble(),
    );

    return OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: () => toggleDropdown(),
        behavior: HitTestBehavior.translucent,
        child: Stack(
          children: [
            Positioned(
              top: topOffset,
              left: leftOffset,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: Container(
                  constraints: BoxConstraints.loose(maxDropdownSize),
                  decoration: BoxDecoration(
                    color: NColors.white,
                    // boxShadow: [
                    //   BoxShadow(
                    //     offset: const Offset(0, 6),
                    //     color: NColors.black.withOpacity(0.1),
                    //     blurRadius: 10.r,
                    //     spreadRadius: 10.r,
                    //   ),
                    // ],
                    border: Border.all(width: 1.r, color: NColors.gray2),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) => Material(
                      child: widget.suggestionsBuilder?.call(index),
                    ),
                    separatorBuilder: (_, __) => Container(),
                    itemCount: widget.suggestions.length,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          key: _globalKey,
          height: widget.maxLines != null ? null : (widget.height ?? NTextField.defaultHeight.h),
          width: widget.width ?? 200.w,
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(20.r),
            color: widget.transparentFill ? NColors.transparent : NColors.gray2,
            border: Border.all(
              color: _borderColor,
              width: 1.r,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: widget.disableHorizontalPadding ? 0 : 16.w),
            child: Row(
              crossAxisAlignment: widget.maxLines == null ? CrossAxisAlignment.center : CrossAxisAlignment.start,
              children: [
                if (widget.prefix != null) ...[
                  widget.prefix!,
                  SizedBox(width: 8.w),
                ],
                Flexible(
                  child: TextFormField(
                    maxLines: widget.obscureText ? 1 : widget.maxLines,
                    focusNode: _focusNode,
                    controller: _controller,
                    autofocus: widget.autofocus,
                    style: NTypography.golosRegular14,
                    textCapitalization: widget.capitalization ?? TextCapitalization.sentences,
                    keyboardType: widget.keyboardType ?? TextInputType.name,
                    textInputAction: widget.textInputAction,
                    enableSuggestions: false,
                    autocorrect: false,
                    obscureText: widget.obscureText,
                    onChanged: widget.onChanged,
                    onTap: widget.onTap,
                    readOnly: widget.onTap != null,
                    // onFieldSubmitted: widget.onSubmitted,

                    // onEditingComplete: () => widget.onSubmitted?.call(_controller.text),
                    decoration: InputDecoration(
                      hintStyle: NTypography.golosRegular14.copyWith(color: NColors.gray),
                      hintText: widget.hintText,
                      border: InputBorder.none,
                    ),
                  ),
                ),
                if (widget.suffix != null) ...[
                  SizedBox(width: 8.w),
                  widget.suffix!,
                ],
              ],
            ),
          ),
        ),
        if (!widget.errorText.isBlank) ...[
          SizedBox(height: 4.h),
          Text(
            widget.errorText!,
            style: NTypography.golosRegular12.copyWith(color: NColors.redError),
          ),
        ],
      ],
    );
  }
}
