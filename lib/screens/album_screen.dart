import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../core/constants/app_constants.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_text_styles.dart';
import '../models/event.dart';
import 'photo_view_screen.dart';

class AlbumScreen extends StatelessWidget {
  final Event event;

  const AlbumScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(event.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.slideshow),
            onPressed: () => _startSlideshow(context),
            tooltip: AppConstants.slideshowLabel,
          ),
        ],
      ),
      body: Column(
        children: [
          // _buildEventHeader(),
          Expanded(
            child: _buildPhotoGrid(),
          ),
        ],
      ),
    );
  }

  Widget _buildEventHeader() {
    return Container(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        boxShadow: [
          BoxShadow(
            color: AppColors.overlayLight,
            blurRadius: AppConstants.smallElevation * 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            Icons.location_on,
            size: AppConstants.iconSizeSmall,
            color: AppColors.grey,
          ),
          const SizedBox(width: AppConstants.smallPadding / 2),
          Text(
            event.location,
            style: AppTextStyles.eventDetails,
          ),
          const SizedBox(width: AppConstants.defaultPadding),
          Icon(
            Icons.calendar_today,
            size: AppConstants.iconSizeSmall,
            color: AppColors.grey,
          ),
          const SizedBox(width: AppConstants.smallPadding / 2),
          Text(
            event.date,
            style: AppTextStyles.eventDetails,
          ),
          const Spacer(),
          Text(
            '${event.photos.length} photos',
            style: AppTextStyles.eventDetails.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(AppConstants.gridSpacing),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: AppConstants.gridCrossAxisCount,
        crossAxisSpacing: AppConstants.gridSpacing,
        mainAxisSpacing: AppConstants.gridSpacing,
        childAspectRatio: AppConstants.gridChildAspectRatio,
      ),
      itemCount: event.photos.length,
      itemBuilder: (context, index) {
        final photo = event.photos[index];
        return _buildPhotoTile(context, photo, index);
      },
    );
  }

  Widget _buildPhotoTile(BuildContext context, photo, int index) {
    return GestureDetector(
      onTap: () => _navigateToPhotoView(context, index),
      child: Hero(
        tag: 'photo_${photo.id}',
        child: Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppConstants.smallRadius),
              child: CachedNetworkImage(
                imageUrl: photo.thumbnailUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: AppColors.greyLight,
                  child:  Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.yellowE0A,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: AppColors.greyLight,
                  child: const Icon(
                    Icons.error,
                    color: AppColors.grey,
                  ),
                ),
              ),
            ),
            if (photo.isLiked) _buildLikeIndicator(),
          ],
        ),
      ),
    );
  }

  Widget _buildLikeIndicator() {
    return Positioned(
      top: AppConstants.smallPadding,
      right: AppConstants.smallPadding,
      child: Container(
        padding: const EdgeInsets.all(AppConstants.smallPadding / 2),
        decoration: BoxDecoration(
          color: AppColors.overlayWhite,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.favorite,
          color: AppColors.likeColor,
          size: AppConstants.iconSizeMedium - 4,
        ),
      ),
    );
  }

  void _navigateToPhotoView(BuildContext context, int index) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PhotoViewScreen(
          event: event,
          initialIndex: index,
        ),
      ),
    );
  }

  void _startSlideshow(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PhotoViewScreen(
          event: event,
          initialIndex: 0,
          isSlideshow: true,
        ),
      ),
    );
  }
}