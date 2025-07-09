import 'package:flutter/material.dart';
import '../models/space_layout.dart';

class LayoutViewer extends StatelessWidget {
  final SpaceLayout layout;
  final Function(RoomPlacement)? onRoomTap;
  final bool showRoomInfo;

  const LayoutViewer({
    Key? key,
    required this.layout,
    this.onRoomTap,
    this.showRoomInfo = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 400,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
        color: _getBackgroundColor(),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          children: [
            // 배경 이미지가 있다면 표시
            if (layout.backgroundImage != null)
              Positioned.fill(
                child: Image.network(
                  layout.backgroundImage!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(color: _getBackgroundColor());
                  },
                ),
              ),

            // 방들 렌더링
            ...layout.roomPlacements.map((room) => _buildRoomWidget(room)),
          ],
        ),
      ),
    );
  }

  Widget _buildRoomWidget(RoomPlacement room) {
    return Positioned(
      left: room.xPosition.toDouble(),
      top: room.yPosition.toDouble(),
      child: GestureDetector(
        onTap: () => onRoomTap?.call(room),
        child: Transform.rotate(
          angle: room.rotation * 3.14159 / 180, // 라디안으로 변환
          child: Container(
            width: room.width.toDouble(),
            height: room.height.toDouble(),
            decoration: BoxDecoration(
              color: _getRoomColor(room),
              border: Border.all(
                color: _getRoomBorderColor(room),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: showRoomInfo ? _buildRoomInfo(room) : null,
          ),
        ),
      ),
    );
  }

  Widget _buildRoomInfo(RoomPlacement room) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (room.roomName != null && room.roomName!.isNotEmpty)
            Text(
              room.roomName!,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          if (room.roomNumber != null && room.roomNumber!.isNotEmpty)
            Text(
              room.roomNumber!,
              style: const TextStyle(
                fontSize: 10,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
          if (room.space != null)
            Text(
              '₩${room.space!.pricePerHour.toStringAsFixed(0)}/시간',
              style: const TextStyle(
                fontSize: 9,
                color: Colors.green,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
        ],
      ),
    );
  }

  Color _getBackgroundColor() {
    final bgColor = layout.layoutData['canvas']?['background'];
    if (bgColor != null && bgColor is String) {
      try {
        return Color(int.parse(bgColor.replaceFirst('#', '0xFF')));
      } catch (e) {
        // 파싱 실패시 기본값 반환
      }
    }
    return Colors.grey.shade100;
  }

  Color _getRoomColor(RoomPlacement room) {
    // 방의 스타일 정보에서 색상 가져오기
    final rooms = layout.layoutData['rooms'] as List<dynamic>?;
    if (rooms != null) {
      for (final roomData in rooms) {
        if (roomData['id'] == room.id) {
          final fillColor = roomData['style']?['fill'];
          if (fillColor != null && fillColor is String) {
            try {
              return Color(int.parse(fillColor.replaceFirst('#', '0xFF')));
            } catch (e) {
              // 파싱 실패시 기본값 반환
            }
          }
        }
      }
    }

    // 기본 색상 (예약 가능 여부에 따라)
    if (room.space != null) {
      return room.space!.isAvailable ? Colors.blue.shade50 : Colors.red.shade50;
    }
    return Colors.blue.shade50;
  }

  Color _getRoomBorderColor(RoomPlacement room) {
    // 방의 스타일 정보에서 테두리 색상 가져오기
    final rooms = layout.layoutData['rooms'] as List<dynamic>?;
    if (rooms != null) {
      for (final roomData in rooms) {
        if (roomData['id'] == room.id) {
          final strokeColor = roomData['style']?['stroke'];
          if (strokeColor != null && strokeColor is String) {
            try {
              return Color(int.parse(strokeColor.replaceFirst('#', '0xFF')));
            } catch (e) {
              // 파싱 실패시 기본값 반환
            }
          }
        }
      }
    }

    // 기본 테두리 색상 (예약 가능 여부에 따라)
    if (room.space != null) {
      return room.space!.isAvailable
          ? Colors.blue.shade300
          : Colors.red.shade300;
    }
    return Colors.blue.shade300;
  }
}
