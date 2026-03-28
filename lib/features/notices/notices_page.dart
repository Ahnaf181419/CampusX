import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:campus_x/core/theme/app_colors.dart';
import 'package:campus_x/core/theme/app_text_styles.dart';
import 'package:campus_x/features/notices/models/notice_model.dart';
import 'package:campus_x/features/notices/widgets/notice_card.dart';
import 'package:campus_x/features/notices/widgets/notice_filter_chips.dart';

class NoticesPage extends StatefulWidget {
  const NoticesPage({super.key});

  @override
  State<NoticesPage> createState() => _NoticesPageState();
}

class _NoticesPageState extends State<NoticesPage> {
  static const _storageKey = 'campus_x_notices';

  NoticeFilter _selectedFilter = NoticeFilter.unread;
  List<NoticeModel> _notices = [];
  int _nextId = 1;
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _loadNotices();
  }

  Future<void> _loadNotices() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString(_storageKey);
    if (jsonStr != null) {
      final List<dynamic> decoded = json.decode(jsonStr);
      _notices = decoded.map((e) => NoticeModel.fromJson(e as Map<String, dynamic>)).toList();
      if (_notices.isNotEmpty) {
        _nextId = _notices.map((n) => int.tryParse(n.id) ?? 0).reduce((a, b) => a > b ? a : b) + 1;
      }
    }
    setState(() => _loaded = true);
  }

  Future<void> _saveNotices() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = json.encode(_notices.map((n) => n.toJson()).toList());
    await prefs.setString(_storageKey, jsonStr);
  }

  void _toggleNotice(int index, bool? value) {
    setState(() {
      _notices[index] = _notices[index].copyWith(isChecked: value ?? false);
    });
    _saveNotices();
  }

  void _changeFilter(NoticeFilter filter) {
    setState(() {
      _selectedFilter = filter;
    });
  }

  void _addNotice(NoticeModel notice) {
    setState(() {
      _notices.insert(0, notice);
    });
    _saveNotices();
  }

  void _showCreateNoticeDialog() {
    final titleController = TextEditingController();
    final bodyController = TextEditingController();
    NoticePriority selectedPriority = NoticePriority.medium;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => Dialog(
          backgroundColor: AppColors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Create Notice', style: AppTextStyles.headerSmall),
                const SizedBox(height: 16),
                TextField(
                  controller: titleController,
                  style: AppTextStyles.bodyMedium,
                  decoration: InputDecoration(
                    hintText: 'Notice title',
                    hintStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.ash),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: bodyController,
                  style: AppTextStyles.bodyMedium,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Notice details (optional)',
                    hintStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.ash),
                  ),
                ),
                const SizedBox(height: 16),
                Text('Priority', style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Row(
                  children: NoticePriority.values.map((p) {
                    final label = p.name[0].toUpperCase() + p.name.substring(1);
                    final isSelected = p == selectedPriority;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: GestureDetector(
                        onTap: () => setDialogState(() => selectedPriority = p),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.chipSelectedBg : AppColors.white,
                            borderRadius: BorderRadius.circular(50),
                            border: isSelected ? null : Border.all(color: AppColors.ashLight),
                          ),
                          child: Text(
                            label,
                            style: AppTextStyles.bodySmall.copyWith(
                              fontWeight: FontWeight.w600,
                              color: isSelected ? AppColors.white : AppColors.black,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.ash,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(color: AppColors.ashLight),
                          ),
                        ),
                        child: const Text('Cancel'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          final title = titleController.text.trim();
                          if (title.isEmpty) return;
                          final now = DateFormat('MMM dd, yyyy - hh:mm a').format(DateTime.now());
                          _addNotice(NoticeModel(
                            id: '${_nextId++}',
                            title: title,
                            date: now,
                            priority: selectedPriority,
                            body: bodyController.text.trim(),
                          ));
                          Navigator.pop(ctx);
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: AppColors.black,
                          foregroundColor: AppColors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Publish'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<NoticeModel> get _filteredNotices {
    switch (_selectedFilter) {
      case NoticeFilter.unread:
        return _notices.where((n) => !n.isChecked).toList();
      case NoticeFilter.important:
        return _notices.where((n) => n.priority == NoticePriority.high).toList();
      case NoticeFilter.all:
        return _notices;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_loaded) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final filtered = _filteredNotices;
    return Scaffold(
      backgroundColor: AppColors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreateNoticeDialog,
        backgroundColor: AppColors.black,
        foregroundColor: AppColors.white,
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(height: 1, thickness: 1, color: AppColors.ashLight),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: NoticeFilterChips(
                selectedFilter: _selectedFilter,
                onFilterChanged: _changeFilter,
              ),
            ),

            Expanded(
              child: filtered.isEmpty
                  ? Center(
                      child: Text(
                        'No notices yet',
                        style: AppTextStyles.bodyMedium.copyWith(color: AppColors.ash),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                      itemCount: filtered.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final notice = filtered[index];
                        final realIndex = _notices.indexOf(notice);
                        return NoticeCard(
                          notice: notice,
                          onCheckedChanged: (value) => _toggleNotice(realIndex, value),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
