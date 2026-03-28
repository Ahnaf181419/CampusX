import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:campus_x/core/theme/app_colors.dart';
import 'package:campus_x/core/theme/app_text_styles.dart';
import 'package:campus_x/data/repositories/event_repository.dart';
import 'package:campus_x/features/events/models/event_model.dart';
import 'package:campus_x/features/events/widgets/ongoing_event_card.dart';
import 'package:campus_x/features/events/widgets/past_event_card.dart';
import 'package:campus_x/services/auth_service.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  final EventRepository _repository = EventRepository();

  void _showCreateEventDialog() {
    final titleController = TextEditingController();
    final dateController = TextEditingController();
    final timeController = TextEditingController();
    final descriptionController = TextEditingController();
    EventStatus selectedStatus = EventStatus.ongoing;

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
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Create Event', style: AppTextStyles.headerSmall),
                  const SizedBox(height: 16),
                  TextField(
                    controller: titleController,
                    style: AppTextStyles.bodyMedium,
                    decoration: InputDecoration(
                      hintText: 'Event title',
                      hintStyle: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.ash,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: dateController,
                    style: AppTextStyles.bodyMedium,
                    decoration: InputDecoration(
                      hintText: 'Date (e.g. March 28, 2026)',
                      hintStyle: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.ash,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: timeController,
                    style: AppTextStyles.bodyMedium,
                    decoration: InputDecoration(
                      hintText: 'Time (optional)',
                      hintStyle: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.ash,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: descriptionController,
                    style: AppTextStyles.bodyMedium,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: 'Description (optional)',
                      hintStyle: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.ash,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Status',
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [EventStatus.ongoing, EventStatus.upcoming].map((s) {
                      final label = s.name[0].toUpperCase() + s.name.substring(1);
                      final isSelected = s == selectedStatus;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: GestureDetector(
                          onTap: () =>
                              setDialogState(() => selectedStatus = s),
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
                            final date = dateController.text.trim();
                            if (title.isEmpty || date.isEmpty) return;
                            Navigator.pop(ctx);
                            await _repository.addEvent(
                              EventModel(
                                id: '',
                                title: title,
                                date: date,
                                time: timeController.text.trim().isNotEmpty
                                    ? timeController.text.trim()
                                    : null,
                                description:
                                    descriptionController.text.trim().isNotEmpty
                                        ? descriptionController.text.trim()
                                        : null,
                                status: selectedStatus,
                              ),
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isAdmin = AuthService().isAdmin();

    return Scaffold(
      backgroundColor: AppColors.white,
      floatingActionButton: isAdmin
          ? FloatingActionButton(
              onPressed: _showCreateEventDialog,
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
            Expanded(
              child: StreamBuilder<List<EventModel>>(
                stream: _repository.getEvents(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Error loading events',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.ash,
                        ),
                      ),
                    );
                  }

                  final events = snapshot.data ?? [];

                  if (events.isEmpty) {
                    return Center(
                      child: Text(
                        'No events yet',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.ash,
                        ),
                      ),
                    );
                  }

                  final ongoingEvents = events
                      .where((e) =>
                          e.status == EventStatus.ongoing ||
                          e.status == EventStatus.upcoming)
                      .toList();
                  final pastEvents = events
                      .where((e) => e.status == EventStatus.completed)
                      .toList();

                  return SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (ongoingEvents.isNotEmpty) ...[
                          const Text(
                            'Ongoing Events',
                            style: AppTextStyles.headerSmall,
                          ),
                          const SizedBox(height: 12),
                          for (final event in ongoingEvents) ...[
                            _buildOngoingCard(event, isAdmin),
                            const SizedBox(height: 12),
                          ],
                        ],
                        if (ongoingEvents.isNotEmpty &&
                            pastEvents.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          const Divider(
                            height: 1,
                            thickness: 1,
                            color: AppColors.ashLight,
                          ),
                          const SizedBox(height: 20),
                        ],
                        if (pastEvents.isNotEmpty) ...[
                          const Text(
                            'Past Events',
                            style: AppTextStyles.headerSmall,
                          ),
                          const SizedBox(height: 12),
                          for (final event in pastEvents) ...[
                            _buildPastCard(event, isAdmin),
                            const SizedBox(height: 12),
                          ],
                        ],
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOngoingCard(EventModel event, bool isAdmin) {
    return Stack(
      children: [
        OngoingEventCard(
          event: event,
          onParticipate: () => launchUrl(
            Uri.parse('https://www.facebook.com/AUSTPIC'),
            mode: LaunchMode.externalApplication,
          ),
        ),
        if (isAdmin)
          Positioned(
            top: 8,
            right: 8,
            child: IconButton(
              onPressed: () => _repository.deleteEvent(event.id),
              icon: const Icon(Icons.delete_outline, size: 20),
              color: AppColors.ash,
            ),
          ),
      ],
    );
  }

  Widget _buildPastCard(EventModel event, bool isAdmin) {
    if (!isAdmin) return PastEventCard(event: event);

    return Dismissible(
      key: ValueKey(event.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: Colors.red.shade50,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(Icons.delete, color: Colors.red.shade400),
      ),
      onDismissed: (_) => _repository.deleteEvent(event.id),
      child: PastEventCard(event: event),
    );
  }
}
