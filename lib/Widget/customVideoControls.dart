import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class CustomVideoControls extends StatefulWidget {
  final FlickManager flickManager;

  CustomVideoControls({required this.flickManager});

  @override
  State<CustomVideoControls> createState() => _CustomVideoControlsState();
}

class _CustomVideoControlsState extends State<CustomVideoControls> {
  bool _showControls = false; // Controls visibility
  Timer? _hideTimer; // Timer for auto-hide functionality

  @override
  void dispose() {
    _hideTimer?.cancel(); // Cancel timer to prevent memory leaks
    super.dispose();
  }

  void _showControlsWithTimeout() {
    setState(() {
      _showControls = true;
      widget.flickManager.flickControlManager!.togglePlay();  
    });

    // Reset the timer to auto-hide controls after 3 seconds
    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(milliseconds: 800), () {
      setState(() {
        _showControls = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _showControlsWithTimeout(),
      onHover: (_) => _showControlsWithTimeout(),
      onExit: (_) {
        // Optionally hide controls immediately when the mouse exits
        _hideTimer?.cancel();
        setState(() {
          _showControls = false;
        });
      },
      child: GestureDetector(
        onTap: _showControlsWithTimeout,
        child: Stack(
          children: [
            // Play/Pause button
            if (_showControls)
              Center(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.flickManager.flickControlManager!.togglePlay();  
                    });
                    
                  },
                  child: Icon(
                    widget.flickManager.flickVideoManager!.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                    color: Colors.white,
                    size: 80,
                  ),
                ),
              ),

            // Progress bar
          
              Positioned(
                bottom: 10,
                left: 10,
                right: 10,
                child: FlickVideoProgressBar(
                  flickProgressBarSettings: FlickProgressBarSettings(
                    backgroundColor: Colors.grey.shade300,
                    bufferedColor: Colors.grey.shade500,
                    playedColor: Colors.white,
                    handleColor: Colors.white,
                  ),
                ),
              ),

            // // Fullscreen toggle
            // if (_showControls)
            //   Positioned(
            //     bottom: 30,
            //     right: 10,
            //     child: GestureDetector(
            //       onTap: () {
            //         widget.flickManager.flickControlManager!.toggleFullscreen();
            //       },
            //       child: Icon(
            //         widget.flickManager.flickDisplayManager!.isFullscreen
            //             ? Icons.fullscreen_exit
            //             : Icons.fullscreen,
            //         color: Colors.white,
            //         size: 30,
            //       ),
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }
}
