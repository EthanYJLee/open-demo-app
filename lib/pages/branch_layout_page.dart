import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/space_layout.dart';
import '../models/branch.dart';
import '../widgets/layout_viewer.dart';
import '../services/repositories/repository_providers.dart';
import 'reservation/reservation_form_page.dart';

class BranchLayoutPage extends ConsumerStatefulWidget {
  final Branch branch;

  const BranchLayoutPage({
    Key? key,
    required this.branch,
  }) : super(key: key);

  @override
  ConsumerState<BranchLayoutPage> createState() => _BranchLayoutPageState();
}

class _BranchLayoutPageState extends ConsumerState<BranchLayoutPage> {
  SpaceLayout? layout;
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    _loadLayout();
  }

  Future<void> _loadLayout() async {
    try {
      setState(() {
        isLoading = true;
        error = null;
      });

      final layoutRepository = ref.read(layoutRepositoryProvider);
      final layoutData =
          await layoutRepository.getFirstLayout(widget.branch.id);

      setState(() {
        layout = layoutData;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = '배치도를 불러오는데 실패했습니다: $e';
        isLoading = false;
      });
    }
  }

  void _onRoomTap(RoomPlacement room) {
    if (room.space == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('이 방은 아직 공간과 연결되지 않았습니다.'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    if (!room.space!.isAvailable) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('이 방은 현재 예약할 수 없습니다.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // 예약 페이지로 이동
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReservationFormPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.branch.name} 배치도'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: _loadLayout,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 지점 정보
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.branch.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.branch.address,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.branch.phone,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // 배치도
              if (isLoading)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: CircularProgressIndicator(),
                  ),
                )
              else if (error != null)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 64,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          error!,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _loadLayout,
                          child: const Text('다시 시도'),
                        ),
                      ],
                    ),
                  ),
                )
              else if (layout == null)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      children: [
                        Icon(
                          Icons.map_outlined,
                          size: 64,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '배치도가 아직 등록되지 않았습니다.',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                )
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '공간 배치도',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '방을 터치하여 예약하세요',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    LayoutViewer(
                      layout: layout!,
                      onRoomTap: _onRoomTap,
                    ),

                    const SizedBox(height: 24),

                    // 범례
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '범례',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade50,
                                    border:
                                        Border.all(color: Colors.blue.shade300),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Text('예약 가능'),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: Colors.red.shade50,
                                    border:
                                        Border.all(color: Colors.red.shade300),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Text('예약 불가'),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade50,
                                    border:
                                        Border.all(color: Colors.grey.shade300),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Text('연결되지 않은 방'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
