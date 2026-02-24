import 'package:flutter/material.dart';
import 'package:campus_x/core/theme/app_colors.dart';
import 'package:campus_x/core/theme/app_text_styles.dart';
import 'package:campus_x/features/rooms/models/room_model.dart';
import 'package:campus_x/features/rooms/widgets/date_button.dart';
import 'package:campus_x/features/rooms/widgets/room_card.dart';
import 'package:campus_x/features/rooms/widgets/room_filter_chips.dart';

class RoomsPage extends StatefulWidget {
  const RoomsPage({super.key});

  @override
  State<RoomsPage> createState() => _RoomsPageState();
}

class _RoomsPageState extends State<RoomsPage> {
  RoomFilter _selectedFilter = RoomFilter.all;

  static const List<String> _dayNames = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  List<RoomModel> get _filteredRooms {
    return kDummyRooms.where((room) {
      if (_selectedFilter == RoomFilter.lab && room.type != RoomType.lab) {
        return false;
      }
      if (_selectedFilter == RoomFilter.classRoom &&
          room.type != RoomType.classRoom) {
        return false;
      }
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final dayLabel = _dayNames[DateTime.now().weekday - 1];
    final rooms = _filteredRooms;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            const Divider(height: 1, thickness: 1, color: AppColors.ashLight),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  const SizedBox(height: 14),

                  // Date button
                  DateButton(dayLabel: dayLabel),

                  const SizedBox(height: 14),

                  // Search field (dummy — no filtering)
                  TextField(
                    readOnly: true,
                    style: AppTextStyles.bodyMedium,
                    decoration: InputDecoration(
                      hintText: 'Search rooms...',
                      hintStyle: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.ash,
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: AppColors.ash,
                      ),
                      filled: true,
                      fillColor: AppColors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: AppColors.ashLight),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: AppColors.ashLight),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: AppColors.black),
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  // Filter chips
                  RoomFilterChips(
                    selectedFilter: _selectedFilter,
                    onFilterChanged: (filter) {
                      setState(() => _selectedFilter = filter);
                    },
                  ),

                  const SizedBox(height: 14),

                  // Room cards list
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: rooms.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      return RoomCard(room: rooms[index]);
                    },
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
