import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:campus_x/core/theme/app_colors.dart';
import 'package:campus_x/core/theme/app_text_styles.dart';
import 'package:campus_x/features/notices/models/notice_model.dart';
import 'package:campus_x/features/notices/widgets/notice_card.dart';
import 'package:campus_x/features/notices/widgets/notice_filter_chips.dart';
import 'package:campus_x/services/auth_service.dart';
import 'package:campus_x/data/repositories/notice_repository.dart';
import 'package:campus_x/data/models/notice.dart' as firestore;

class NoticesPage extends StatefulWidget {
  const NoticesPage({super.key});

  @override
  State<NoticesPage> createState() => _NoticesPageState();
}

class _NoticesPageState extends State<NoticesPage> {
  static const _readNoticesKey = 'campus_x_read_notices';

  final NoticeRepository _repository = NoticeRepository();
  NoticeFilter _selectedFilter = NoticeFilter.unread;
  List<NoticeModel> _notices = [];
  Set<String> _readNoticeIds = {};
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _loadReadNotices();
  }

  Future<void> _loadReadNotices() async {
    final prefs = await SharedPreferences.getInstance();
    final readIds = prefs.getStringList(_readNoticesKey) ?? [];
    setState(() {
      _readNoticeIds = readIds.toSet();
      _loaded = true;
    });
  }

  Future<void> _saveReadNotices() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_readNoticesKey, _readNoticeIds.toList());
  }

  void _toggleNotice(String noticeId, bool? value) {
    setState(() {
      if (value ?? false) {
        _readNoticeIds.add(noticeId);
      } else {
        _readNoticeIds.remove(noticeId);
      }
    });
    _saveReadNotices();
  }

  void _changeFilter(NoticeFilter filter) {
    setState(() {
      _selectedFilter = filter;
    });
  }

  NoticeModel _toNoticeModel(firestore.Notice notice) {
    return NoticeModel(
      id: notice.id,
      title: notice.title,
      date: DateFormat('MMM dd, yyyy - hh:mm a').format(notice.timestamp),
      priority: _parsePriority(notice.priority),
      body: notice.body,
      isChecked: _readNoticeIds.contains(notice.id),
    );
  }

  NoticePriority _parsePriority(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return NoticePriority.high;
      case 'low':
        return NoticePriority.low;
      default:
        return NoticePriority.medium;
    }
  }

  String _priorityToString(NoticePriority priority) {
    switch (priority) {
      case NoticePriority.high:
        return 'high';
      case NoticePriority.low:
        return 'low';
      default:
        return 'medium';
    }
  }

  Future<void> _addNotice(
    String title,
    String body,
    NoticePriority priority,
  ) async {
    final notice = firestore.Notice(
      id: '',
      title: title,
      body: body,
      timestamp: DateTime.now(),
      author: 'Admin',
      priority: _priorityToString(priority),
    );
    await _repository.addNotice(notice);
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
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
                    hintStyle: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.ash,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: bodyController,
                  style: AppTextStyles.bodyMedium,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Notice details (optional)',
                    hintStyle: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.ash,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Priority',
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
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
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.chipSelectedBg
                                : AppColors.white,
                            borderRadius: BorderRadius.circular(50),
                            border: isSelected
                                ? null
                                : Border.all(color: AppColors.ashLight),
                          ),
                          child: Text(
                            label,
                            style: AppTextStyles.bodySmall.copyWith(
                              fontWeight: FontWeight.w600,
                              color: isSelected
                                  ? AppColors.white
                                  : AppColors.black,
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
                        onPressed: () async {
                          final title = titleController.text.trim();
                          if (title.isEmpty) return;
                          Navigator.pop(ctx);
                          await _addNotice(
                            title,
                            bodyController.text.trim(),
                            selectedPriority,
                          );
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

  @override
  Widget build(BuildContext context) {
    if (!_loaded) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: AppColors.white,
      floatingActionButton: AuthService().isAdmin()
          ? FloatingActionButton(
              onPressed: _showCreateNoticeDialog,
              backgroundColor: AppColors.black,
              foregroundColor: AppColors.white,
              child: const Icon(Icons.add),
            )
          : null,
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
              child: StreamBuilder<List<firestore.Notice>>(
                stream: _repository.getNotices(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Error loading notices',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.ash,
                        ),
                      ),
                    );
                  }

                  final notices = snapshot.data ?? [];
                  _notices = notices.map(_toNoticeModel).toList();

                  List<NoticeModel> filtered;
                  switch (_selectedFilter) {
                    case NoticeFilter.unread:
                      filtered = _notices.where((n) => !n.isChecked).toList();
                      break;
                    case NoticeFilter.important:
                      filtered = _notices
                          .where((n) => n.priority == NoticePriority.high)
                          .toList();
                      break;
                    case NoticeFilter.all:
                      filtered = _notices;
                      break;
                  }

                  if (filtered.isEmpty) {
                    return Center(
                      child: Text(
                        'No notices yet',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.ash,
                        ),
                      ),
                    );
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                    itemCount: filtered.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final notice = filtered[index];
                      return NoticeCard(
                        notice: notice,
                        onCheckedChanged: (value) =>
                            _toggleNotice(notice.id, value),
                      );
                    },
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
