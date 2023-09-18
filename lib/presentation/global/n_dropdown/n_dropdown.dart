// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/icons/n_icon.dart';
import 'package:norm/presentation/global/icons/n_icons.dart';
import 'package:norm/presentation/global/padded_content/padded_content.dart';

class NDropdown extends StatefulWidget {
  const NDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.hint,
    this.onChanged,
    this.width,
    this.allowManualValues = false,
    this.onManualChanged,
    this.active = true,
  });

  /// Current value.
  final dynamic value;

  /// Dropdown width.
  final double? width;

  /// Hint text when to items picked.
  final String hint;

  /// List of items.
  final List<NDropdownItem> items;

  /// On changed item.
  final Function(dynamic)? onChanged;

  /// Allow type manual value.
  final bool allowManualValues;

  /// On changed manual value.
  final Function(String)? onManualChanged;

  /// If dropdown is active or not.
  final bool active;

  @override
  State<NDropdown> createState() => _NDropdownState();
}

class _NDropdownState extends State<NDropdown> {
  static const double maxDropdownHeight = 300;
  static const double dropdownItemHeight = 52;

  final GlobalKey _globalKey = GlobalKey();

  TextEditingController? _manualController;
  FocusNode? _focusNode;

  /// Whether dropdown is expanded or not.
  bool isExpanded = false;

  /// Dropdown overlay.
  OverlayEntry? overlay;

  /// Current active item.
  NDropdownItem? get currentItem {
    if (widget.items.isEmpty && widget.value != null) {
      return NDropdownItem(title: widget.value.title, value: widget.value);
    }

    if (widget.items.any((e) => e.value == widget.value)) {
      return widget.items.firstWhere((e) => e.value == widget.value);
    }

    return null;
  }

  bool get hasChosenItem => currentItem != null;

  @override
  void initState() {
    // Initialize focus node only when manual values are allowed.
    if (widget.allowManualValues) {
      _focusNode = FocusNode();
      _manualController = TextEditingController(text: currentItem?.title);
    }

    super.initState();
  }

  @override
  void didUpdateWidget(NDropdown oldWidget) {
    SchedulerBinding.instance.addPostFrameCallback(
      (_) {
        if (isExpanded && oldWidget.items != widget.items) {
          toggleDropdown();
          toggleDropdown();
        }
      },
    );

    super.didUpdateWidget(oldWidget);
  }

  void toggleDropdown() {
    if (!widget.active) return;

    // If dropdown was expanded we need to close overlay.
    if (isExpanded) {
      overlay?.remove();
      overlay = null;

      _focusNode?.unfocus();
    }
    // Else show overlay.
    else if (!isExpanded) {
      overlay = _buildOverlay();

      // Insert overlay entry.
      if (mounted) Overlay.of(context)!.insert(overlay!);

      _focusNode?.requestFocus();
    }

    if (mounted) setState(() => isExpanded = !isExpanded);
  }

  Widget _buildDropdownItem(BuildContext context, {required NDropdownItem item}) {
    return Material(
      color: NColors.transparent,
      child: InkWell(
        onTap: () {
          toggleDropdown();
          widget.onChanged?.call(item.value);

          // If user is allowed to pick manual values.
          _manualController?.value = TextEditingValue(
            text: item.title,
            selection: TextSelection.collapsed(offset: item.title.length),
          );
        },
        child: Ink(
          height: dropdownItemHeight,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: NConstants.sidePadding.w),
            child: Row(
              children: [
                if (item.icon != null) ...[
                  item.icon!,
                  SizedBox(width: 16.w),
                ],
                Text(item.title, style: NTypography.golosRegular14),
              ],
            ),
          ),
        ),
      ),
    );
  }

  OverlayEntry _buildOverlay() {
    final RenderBox renderBox = _globalKey.currentContext!.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;

    final double topOffset = offset.dy + size.height + 12.h;
    final double leftOffset = offset.dx;

    final double heightFromBottom = MediaQuery.of(context).size.height - topOffset - 24.h;

    final Size maxDropdownSize = Size(
      size.width,
      heightFromBottom.clamp(0, widget.items.length * dropdownItemHeight).clamp(0, maxDropdownHeight).toDouble(),
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
                    itemBuilder: (context, index) => _buildDropdownItem(
                      context,
                      item: widget.items.elementAt(index),
                    ),
                    separatorBuilder: (_, __) => Container(),
                    itemCount: widget.items.length,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildManualTextField(BuildContext context) {
    return Flexible(
      child: TextField(
        controller: _manualController,
        onChanged: widget.onManualChanged,
        onTap: toggleDropdown,
        focusNode: _focusNode,
        style: NTypography.golosRegular14,
        onSubmitted: (_) => toggleDropdown(),
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: widget.hint,
          hintStyle: NTypography.golosRegular14.copyWith(color: NColors.gray),
        ),
      ),
    );
  }

  Widget _buildField(BuildContext context) {
    return PaddedContent(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (!widget.allowManualValues)
            Text(
              hasChosenItem ? currentItem!.title : widget.hint,
              style: NTypography.golosRegular14.copyWith(color: hasChosenItem ? NColors.black : NColors.gray),
            )
          else
            _buildManualTextField(context),
          AnimatedRotation(
            duration: NConstants.defaultAnimationDuration,
            turns: isExpanded ? 0.5 : 0,
            child: NIcon(
              NIcons.arrow_down,
              color: isExpanded ? NColors.black : NColors.gray,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: widget.active ? 1.0 : 0.5,
      child: GestureDetector(
        key: _globalKey,
        onTap: toggleDropdown,
        child: Container(
          height: 52.h,
          width: widget.width ?? 200.w,
          decoration: BoxDecoration(
            color: NColors.gray2,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: _buildField(context),
        ),
      ),
    );
  }
}

class NDropdownItem {
  const NDropdownItem({
    required this.title,
    required this.value,
    this.icon,
  });

  /// Title of item.
  final String title;

  /// The value of this item.
  final dynamic value;

  final Widget? icon;
}
