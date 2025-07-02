import 'package:flutter/material.dart';

import '../../data/models/table_model.dart';

class TableCard extends StatefulWidget {
  final TableModel table;
  final VoidCallback onTap;

  const TableCard({super.key, required this.table, required this.onTap});

  @override
  _TableCardState createState() => _TableCardState();
}

class _TableCardState extends State<TableCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    if (widget.table.status == TableStatus.available) {
      _pulseController.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  Color _getStatusColor() {
    switch (widget.table.status) {
      case TableStatus.available:
        return Color(0xFF4CAF50);
      case TableStatus.occupied:
        return Color(0xFFFF5722);
      case TableStatus.reserved:
        return Color(0xFFFF9800);
      case TableStatus.cleaning:
        return Color(0xFF9E9E9E);
    }
  }

  IconData _getStatusIcon() {
    switch (widget.table.status) {
      case TableStatus.available:
        return Icons.check_circle;
      case TableStatus.occupied:
        return Icons.people;
      case TableStatus.reserved:
        return Icons.schedule;
      case TableStatus.cleaning:
        return Icons.cleaning_services;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _pulseAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: widget.table.status == TableStatus.available
                ? _pulseAnimation.value
                : 1.0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: _getStatusColor(), width: 2),
                boxShadow: [
                  BoxShadow(
                    color: _getStatusColor().withOpacity(0.3),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(_getStatusIcon(), color: _getStatusColor(), size: 30),
                  SizedBox(height: 8),
                  Text(
                    'Stol ${widget.table.number}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    '${widget.table.seats} o‘rin',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 4),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: _getStatusColor(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      widget.table.status.name.toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
