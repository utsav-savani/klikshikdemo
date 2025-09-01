import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../core/constants/app_constants.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_text_styles.dart';
import '../core/utils/extensions.dart';
import '../providers/event_provider.dart';
import '../providers/auth_provider.dart';
import 'album_screen.dart';
import 'auth_screen.dart';

class EventListScreen extends StatefulWidget {
  const EventListScreen({super.key});

  @override
  State<EventListScreen> createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        context.read<EventProvider>().fetchEvents();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.eventListScreenTitle),
      ),
      body: Consumer<EventProvider>(
        builder: (context, eventProvider, child) {
          if (eventProvider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.yellowE0A),
            );
          }

          if (eventProvider.error != null) {
            return _buildErrorState(eventProvider);
          }

          if (eventProvider.events.isEmpty) {
            return _buildEmptyState();
          }

          return _buildEventList(eventProvider);
        },
      ),
    );
  }

  Widget _buildErrorState(EventProvider eventProvider) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: AppConstants.iconSizeExtraLarge,
              color: AppColors.errorColor,
            ),
            const SizedBox(height: AppConstants.defaultPadding),
            Text(
              AppConstants.loadingErrorMessage,
              style: context.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppConstants.smallPadding),
            Text(
              eventProvider.error!,
              textAlign: TextAlign.center,
              style: context.textTheme.bodyMedium?.copyWith(
                color: AppColors.grey,
              ),
            ),
            const SizedBox(height: AppConstants.defaultPadding),
            ElevatedButton(
              onPressed: () => eventProvider.fetchEvents(),
              child: const Text(AppConstants.retryLabel),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.event_available,
            size: AppConstants.iconSizeExtraLarge,
            color: AppColors.grey,
          ),
          const SizedBox(height: AppConstants.defaultPadding),
          Text(
            AppConstants.noEventsMessage,
            style: context.textTheme.titleLarge?.copyWith(
              color: AppColors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventList(EventProvider eventProvider) {
    return RefreshIndicator(
      color: AppColors.yellowE0A,
      onRefresh: () => eventProvider.fetchEvents(),
      child: ListView.builder(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        itemCount: eventProvider.events.length,
        itemBuilder: (context, index) {
          final event = eventProvider.events[index];
          return Card(
            margin: const EdgeInsets.only(bottom: AppConstants.defaultPadding),
            child: InkWell(
              onTap: () => _navigateToAlbum(event),
              borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildEventImage(event.albumThumbnail),
                  _buildEventDetails(event),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEventImage(String imageUrl) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(AppConstants.defaultRadius),
      ),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        height: AppConstants.albumThumbnailHeight,
        width: double.infinity,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          height: AppConstants.albumThumbnailHeight,
          color: AppColors.greyLight,
          child: const Center(
            child: CircularProgressIndicator(color: AppColors.yellowE0A),
          ),
        ),
        errorWidget: (context, url, error) => Container(
          height: AppConstants.albumThumbnailHeight,
          color: AppColors.greyLight,
          child: const Icon(
            Icons.error,
            size: AppConstants.iconSizeLarge + 18,
            color: AppColors.grey,
          ),
        ),
      ),
    );
  }

  Widget _buildEventDetails(event) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            event.name,
            style: AppTextStyles.eventTitle,
          ),
          // const SizedBox(height: AppConstants.smallPadding),
          // _buildDetailRow(Icons.location_on, event.location),
          // const SizedBox(height: AppConstants.smallPadding / 2),
          // _buildDetailRow(Icons.calendar_today, event.date),
          // const SizedBox(height: AppConstants.smallPadding / 2),
          // _buildDetailRow(Icons.photo_library, '${event.photos.length} photos'),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: AppConstants.iconSizeSmall,
          color: AppColors.grey,
        ),
        const SizedBox(width: AppConstants.smallPadding / 2),
        Text(
          text,
          style: AppTextStyles.eventDetails,
        ),
      ],
    );
  }

  void _navigateToAlbum(event) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AlbumScreen(event: event),
      ),
    );
  }
}