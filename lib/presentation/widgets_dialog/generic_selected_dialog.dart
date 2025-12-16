import 'package:flutter/material.dart';

class SelectionDialog<T> extends StatefulWidget {
  final String title;
  final List<T> items;
  final String Function(T item) display;
  final String searchHint;
  final String confirmText;
  final String cancelText;
  final bool isMultiSelect;
  final List<T> preSelectedItems;

  const SelectionDialog({
    super.key,
    required this.title,
    required this.items,
    required this.display,
    this.searchHint = 'Tìm địa điểm',
    this.confirmText = 'Xác nhận',
    this.cancelText = 'Hủy',
    this.isMultiSelect = false,
    this.preSelectedItems = const [],
  });

  @override
  State<SelectionDialog<T>> createState() => _SelectionDialogState<T>();
}

class _SelectionDialogState<T> extends State<SelectionDialog<T>> {
  final TextEditingController _searchController = TextEditingController();
  late List<T> _filteredItems;
  late final List<T> _selected;

  @override
  void initState() {
    super.initState();
    _filteredItems = List<T>.from(widget.items);
    _selected = List<T>.from(widget.preSelectedItems);
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.trim().toLowerCase();
    setState(() {
      _filteredItems =
          query.isEmpty
              ? List<T>.from(widget.items)
              : widget.items
                  .where((e) => widget.display(e).toLowerCase().contains(query))
                  .toList(growable: false);
    });
  }

  bool _isSelected(T item) {
    return _selected.contains(item);
  }

  void _toggleSelection(T item) {
    setState(() {
      if (widget.isMultiSelect) {
        if (_isSelected(item)) {
          _selected.remove(item);
        } else {
          _selected.add(item);
        }
      } else {
        _selected
          ..clear()
          ..add(item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black.withOpacity(0.25), width: 1),
        ),
        constraints: const BoxConstraints(maxWidth: 420, maxHeight: 560),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
              child: Text(
                widget.title,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const Divider(height: 1),

            // Search box
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: widget.searchHint,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  filled: true,
                  fillColor: const Color(0xFFF6F7F8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Colors.black.withOpacity(0.15),
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Colors.black.withOpacity(0.15),
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: theme.colorScheme.primary,
                      width: 1,
                    ),
                  ),
                ),
              ),
            ),

            // List of options
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 4, 0, 8),
                child: ListView.separated(
                  itemCount: _filteredItems.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final item = _filteredItems[index];
                    final display = widget.display(item);
                    final selected = _isSelected(item);
                    return InkWell(
                      onTap: () =>
                       _toggleSelection(item)
                      ,
                      child: Container(
                        color: selected ? const Color(0xFFDDEEDB) : null,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                display,
                                style: theme.textTheme.bodyMedium,
                              ),
                            ),
                            if (selected)
                              const Icon(Icons.check, color: Color(0xFF2EAD66)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            const Divider(height: 1),

            // Action buttons (Hủy bên trái, Xác nhận bên phải)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _pillButton(
                    label: widget.cancelText,
                    background: const Color(0xFFD64545),
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      Navigator.of(context).pop();
                    }
                  ),
                  const SizedBox(width: 12),
                  _pillButton(
                    label: widget.confirmText,
                    background: const Color(0xFF2EAD66),
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      if (widget.isMultiSelect) {
                        Navigator.of(context).pop<List<T>>(_selected);
                      } else {
                        Navigator.of(
                          context,
                        ).pop<T>(_selected.isEmpty ? null : _selected.first);
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _pillButton({
    required String label,
    required Color background,
    required VoidCallback? onPressed,
  }) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 96),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: background,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
        ),
        child: Text(label),
      ),
    );
  }
}
