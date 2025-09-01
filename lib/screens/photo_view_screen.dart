import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import '../core/constants/app_constants.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_text_styles.dart';
import '../models/event.dart';
import '../providers/event_provider.dart';

class PhotoViewScreen extends StatefulWidget {
  final Event event;
  final int initialIndex;
  final bool isSlideshow;

  const PhotoViewScreen({
    super.key,
    required this.event,
    required this.initialIndex,
    this.isSlideshow = false,
  });

  @override
  State<PhotoViewScreen> createState() => _PhotoViewScreenState();
}

class _PhotoViewScreenState extends State<PhotoViewScreen> {
  late PageController _pageController;
  late int _currentIndex;
  Timer? _slideshowTimer;
  late bool _isPlaying;
  bool _showControls = true;
  Timer? _hideControlsTimer;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
    _isPlaying = widget.isSlideshow;
    
    if (_isPlaying) {
      _startSlideshow();
    }
    
    _startHideControlsTimer();
  }

  @override
  void dispose() {
    _slideshowTimer?.cancel();
    _hideControlsTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startSlideshow() {
    _slideshowTimer?.cancel();
    _slideshowTimer = Timer.periodic(AppConstants.slideshowInterval, (timer) {
      if (_currentIndex < widget.event.photos.length - 1) {
        _pageController.nextPage(
          duration: AppConstants.defaultAnimationDuration,
          curve: Curves.easeInOut,
        );
      } else {
        _pageController.animateToPage(
          0,
          duration: AppConstants.defaultAnimationDuration,
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _stopSlideshow() {
    _slideshowTimer?.cancel();
    _slideshowTimer = null;
  }

  void _toggleSlideshow() {
    setState(() {
      _isPlaying = !_isPlaying;
      if (_isPlaying) {
        _startSlideshow();
      } else {
        _stopSlideshow();
      }
    });
  }

  void _startHideControlsTimer() {
    _hideControlsTimer?.cancel();
    _hideControlsTimer = Timer(AppConstants.controlsHideDelay, () {
      if (mounted) {
        setState(() {
          _showControls = false;
        });
      }
    });
  }

  void _onScreenTap() {
    setState(() {
      _showControls = !_showControls;
    });
    if (_showControls) {
      _startHideControlsTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: GestureDetector(
        onTap: _onScreenTap,
        child: Stack(
          children: [
            _buildPhotoPageView(),
            _buildControlsOverlay(),
          ],
        ),
      ),
    );
  }

  Widget _buildPhotoPageView() {
    return PageView.builder(
      controller: _pageController,
      onPageChanged: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      itemCount: widget.event.photos.length,
      itemBuilder: (context, index) {
        final photo = widget.event.photos[index];
        return InteractiveViewer(
          minScale: 0.5,
          maxScale: 3.0,
          child: Center(
            child: Hero(
              tag: 'photo_${photo.id}',
              child: CachedNetworkImage(
                imageUrl: photo.url,
                fit: BoxFit.contain,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(
                  Icons.error,
                  color: AppColors.white,
                  size: AppConstants.iconSizeLarge + 18,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildControlsOverlay() {
    return AnimatedOpacity(
      opacity: _showControls ? 1.0 : 0.0,
      duration: AppConstants.defaultAnimationDuration,
      child: IgnorePointer(
        ignoring: !_showControls,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.overlayDark,
                Colors.transparent,
                Colors.transparent,
                AppColors.overlayDark,
              ],
              stops: const [0.0, 0.2, 0.8, 1.0],
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTopBar(),
                _buildBottomBar(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.defaultPadding,
        vertical: AppConstants.smallPadding,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.close, color: AppColors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          Text(
            '${_currentIndex + 1} / ${widget.event.photos.length}',
            style: AppTextStyles.photoCounter,
          ),
          IconButton(
            icon: Icon(
              _isPlaying ? Icons.pause : Icons.play_arrow,
              color: AppColors.white,
            ),
            onPressed: _toggleSlideshow,
            tooltip: _isPlaying ? 'Pause slideshow' : 'Start slideshow',
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    final photo = widget.event.photos[_currentIndex];
    return Container(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (photo.caption.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: AppConstants.defaultPadding),
              child: Text(
                photo.caption,
                style: AppTextStyles.photoCaption,
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: AppColors.white),
                onPressed: _currentIndex > 0 ? _previousPhoto : null,
              ),
              _buildLikeButton(photo),
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios, color: AppColors.white),
                onPressed: _currentIndex < widget.event.photos.length - 1 
                    ? _nextPhoto 
                    : null,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLikeButton(photo) {
    return Consumer<EventProvider>(
      builder: (context, eventProvider, child) {
        final isLiked = photo.isLiked;
        return  GestureDetector(
          onTap: (){
            _toggleLike(eventProvider, photo);
          },
          child: Container(
            height: AppConstants.likeThumbCircleHeightWidth,
            width: AppConstants.likeThumbCircleHeightWidth,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.greyC4C),
            ),
            child: Center(
              child: Icon(
                isLiked ? Icons.thumb_up : Icons.thumb_up_off_alt,
                color: isLiked ? AppColors.likeColor : AppColors.greyC4C,
                size: AppConstants.iconSizeLarge,
              ),
            ),
          ),
        );
      },
    );
  }

  void _toggleLike(EventProvider eventProvider, photo) {
    HapticFeedback.lightImpact();
    final newLikeState = !photo.isLiked;
    eventProvider.togglePhotoLike(widget.event.id, photo.id);
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          newLikeState 
              ? AppConstants.photoLikedMessage 
              : AppConstants.photoUnlikedMessage,
          style: const TextStyle(color: AppColors.white),
        ),
        backgroundColor: AppColors.overlayDark,
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(AppConstants.defaultPadding),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.smallRadius),
        ),
      ),
    );
  }

  void _previousPhoto() {
    _pageController.previousPage(
      duration: AppConstants.defaultAnimationDuration,
      curve: Curves.easeInOut,
    );
  }

  void _nextPhoto() {
    _pageController.nextPage(
      duration: AppConstants.defaultAnimationDuration,
      curve: Curves.easeInOut,
    );
  }
}