import 'package:flutter/material.dart';
import 'package:campus_x/core/theme/app_colors.dart';
import 'package:campus_x/core/theme/app_text_styles.dart';
import 'package:campus_x/features/events/models/event_model.dart';
import 'package:campus_x/features/events/widgets/event_filter_chips.dart';
import 'package:campus_x/features/events/widgets/ongoing_event_card.dart';
import 'package:campus_x/features/events/widgets/past_event_card.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  EventFilter _selectedFilter = EventFilter.allEvents;

  void _changeFilter(EventFilter filter) {
    setState(() => _selectedFilter = filter);
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

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EventFilterChips(
                      selectedFilter: _selectedFilter,
                      onFilterChanged: _changeFilter,
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      'Ongoing Events',
                      style: AppTextStyles.headerSmall,
                    ),

                    const SizedBox(height: 12),

                    OngoingEventCard(
                      event: kOngoingEvent,
                      onParticipate: () {},
                    ),

                    const SizedBox(height: 20),

                    const Divider(
                      height: 1,
                      thickness: 1,
                      color: AppColors.ashLight,
                    ),

                    const SizedBox(height: 20),

                    const Text('Past Events', style: AppTextStyles.headerSmall),

                    const SizedBox(height: 12),

                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: kPastEvents.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                            bottom: index < kPastEvents.length - 1 ? 12 : 0,
                          ),
                          child: PastEventCard(event: kPastEvents[index]),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
