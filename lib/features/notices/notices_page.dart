import 'package:flutter/material.dart';
import 'package:campus_x/core/theme/app_colors.dart';
import 'package:campus_x/features/notices/models/notice_model.dart';
import 'package:campus_x/features/notices/widgets/notice_card.dart';
import 'package:campus_x/features/notices/widgets/notice_filter_chips.dart';

class NoticesPage extends StatefulWidget {
  const NoticesPage({super.key});

  @override
  State<NoticesPage> createState() => _NoticesPageState();
}

class _NoticesPageState extends State<NoticesPage> {
  NoticeFilter _selectedFilter = NoticeFilter.unread;

  late List<NoticeModel> _notices;

  @override
  void initState() {
    super.initState();

    _notices = List<NoticeModel>.from(kDummyNotices);
  }

  void _toggleNotice(int index, bool? value) {
    setState(() {
      _notices[index] = _notices[index].copyWith(isChecked: value ?? false);
    });
  }

  void _changeFilter(NoticeFilter filter) {
    setState(() {
      _selectedFilter = filter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
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
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                itemCount: _notices.length,

                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  return NoticeCard(
                    notice: _notices[index],
                    onCheckedChanged: (value) => _toggleNotice(index, value),
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
