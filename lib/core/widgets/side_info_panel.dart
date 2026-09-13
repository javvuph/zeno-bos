import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';

class ZenoSideInfoPanel extends StatefulWidget {
  final bool isOpen;
  const ZenoSideInfoPanel({super.key, required this.isOpen});

  @override
  State<ZenoSideInfoPanel> createState() => _ZenoSideInfoPanelState();
}

class _ZenoSideInfoPanelState extends State<ZenoSideInfoPanel>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: widget.isOpen ? 400 : 0,
      decoration: BoxDecoration(
        color: ZenoTheme.surface,
        border: Border(
            left: BorderSide(
                color: ZenoTheme.border, width: widget.isOpen ? 1 : 0)),
      ),
      child: widget.isOpen ? _buildContent() : const SizedBox.shrink(),
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
          child: Row(
            children: [
              const Icon(Icons.analytics_outlined,
                  size: 18, color: ZenoTheme.accent),
              const SizedBox(width: 12),
              const Text("INTELLIGENT INSIGHTS",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.2)),
              const Spacer(),
              _miniActionIcon(Icons.refresh),
              const SizedBox(width: 8),
              _miniActionIcon(Icons.settings_outlined),
            ],
          ),
        ),
        TabBar(
          controller: _tabController,
          labelColor: ZenoTheme.accent,
          unselectedLabelColor: ZenoTheme.textSecondary,
          indicatorColor: ZenoTheme.accent,
          indicatorSize: TabBarIndicatorSize.label,
          labelStyle:
              const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          tabs: const [
            Tab(text: "INFO"),
            Tab(text: "TIMELINE"),
            Tab(text: "FILES"),
            Tab(text: "NOTES"),
            Tab(text: "TASKS"),
            Tab(text: "PLAN"),
          ],
        ),
        const Divider(height: 1, color: ZenoTheme.border),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildInfoTab(),
              _buildTimelineTab(),
              _buildFilesTab(),
              _buildNotesTab(),
              _buildTasksTab(),
              _buildCalendarTab(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoTab() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _section("RELATED RECORDS"),
        _relatedItem(Icons.receipt_long, "Sales Invoices", "12 Active"),
        _relatedItem(Icons.payments_outlined, "Recent Payments", "4 Records"),
        _relatedItem(
            Icons.local_shipping_outlined, "Deliveries", "2 In Transit"),
        const SizedBox(height: 32),
        _section("AI RECOMMENDATIONS"),
        _aiInsight("Inventory Risk",
            "Demand predicted to surge by 25% this weekend.", Colors.orange),
        _aiInsight("Payment Alert",
            "Customer 'Tech Solutions' has 3 overdue invoices.", Colors.red),
      ],
    );
  }

  Widget _buildTimelineTab() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _section("AUDIT TRAIL & LOGS"),
        _timelineItem("Today, 14:20", "Record updated by Alex Rivera",
            user: "AR"),
        _timelineItem("Yesterday, 10:05", "Status changed to 'Confirmed'",
            user: "SYS"),
        _timelineItem(
            "23 Jul, 16:45", "New document 'Contract_V1.pdf' attached",
            user: "JS"),
        _timelineItem("23 Jul, 12:00", "Record created", user: "AR"),
      ],
    );
  }

  Widget _buildFilesTab() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _section("ATTACHMENTS (3)"),
        _fileItem("Invoice_Draft_882.pdf", "4.2 MB", "PDF"),
        _fileItem("Delivery_Photo_Home.jpg", "1.1 MB", "IMAGE"),
        _fileItem("Customer_Agreement.docx", "850 KB", "DOC"),
        const SizedBox(height: 24),
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.upload_file, size: 16),
          label: const Text("UPLOAD NEW FILE"),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12),
            side: const BorderSide(color: ZenoTheme.border),
          ),
        ),
      ],
    );
  }

  Widget _buildNotesTab() {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              _section("DISCUSSION & COMMENTS"),
              _commentItem(
                  "Alex Rivera",
                  "Please verify the shipping address with the customer before dispatch.",
                  "1h ago"),
              _commentItem("Sarah Jenkins",
                  "Address verified. Everything looks good.", "45m ago"),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
              color: ZenoTheme.background,
              border: Border(top: BorderSide(color: ZenoTheme.border))),
          child: Row(
            children: [
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                      hintText: "Add a comment...",
                      border: InputBorder.none,
                      hintStyle: TextStyle(fontSize: 12)),
                  style: TextStyle(fontSize: 12),
                ),
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.send,
                      size: 18, color: ZenoTheme.accent)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTasksTab() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _section("MY PENDING TASKS (4)"),
        _taskItem("Approve Vendor Payment", "High Priority - Due Today", true),
        _taskItem("Review Q3 Sales Forecast", "Medium Priority - Due Tomorrow",
            false),
        _taskItem("Send Agreement to Apple Inc.", "Normal - Due 28 Jul", false),
        _taskItem(
            "Update Safety Stock Levels", "AI Suggested - Due 30 Jul", false),
        const SizedBox(height: 24),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add, size: 16),
          label: const Text("CREATE NEW TASK"),
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12)),
        ),
      ],
    );
  }

  Widget _buildCalendarTab() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _section("UPCOMING EVENTS"),
        _calendarItem(
            "14:30 - 15:30", "Weekly Executive Sync", "Executive Conf Room"),
        _calendarItem(
            "16:00 - 16:30", "Customer Meeting: Google", "Virtual Call"),
        _calendarItem(
            "Tomorrow, 10:00", "Inventory Audit - Warehouse A", "On-site"),
        const SizedBox(height: 24),
        _section("TEAM AVAILABILITY"),
        _teamMember("Sarah Jenkins", "In Meeting", Colors.orange),
        _teamMember("John Doe", "Available", ZenoTheme.neonGreen),
        _teamMember("Alice Rivera", "Out of Office", Colors.redAccent),
      ],
    );
  }

  Widget _taskItem(String title, String sub, bool isOverdue) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Icon(Icons.check_box_outline_blank,
              size: 18,
              color: isOverdue ? Colors.redAccent : ZenoTheme.textSecondary),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        decoration: isOverdue ? TextDecoration.none : null)),
                Text(sub,
                    style: TextStyle(
                        fontSize: 10,
                        color: isOverdue
                            ? Colors.redAccent.withValues(alpha: 0.8)
                            : ZenoTheme.textSecondary)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _calendarItem(String time, String title, String loc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 40,
            decoration: BoxDecoration(
                color: ZenoTheme.accent,
                borderRadius: BorderRadius.circular(2)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(time,
                    style: const TextStyle(
                        fontSize: 10,
                        color: ZenoTheme.accent,
                        fontWeight: FontWeight.bold)),
                Text(title,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.bold)),
                Text(loc,
                    style: const TextStyle(
                        fontSize: 9, color: ZenoTheme.textSecondary)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _teamMember(String name, String status, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          CircleAvatar(radius: 4, backgroundColor: color),
          const SizedBox(width: 12),
          Text(name, style: const TextStyle(fontSize: 11)),
          const Spacer(),
          Text(status,
              style:
                  TextStyle(fontSize: 9, color: color.withValues(alpha: 0.8))),
        ],
      ),
    );
  }

  Widget _section(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(title,
          style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: ZenoTheme.textSecondary,
              letterSpacing: 1)),
    );
  }

  Widget _relatedItem(IconData icon, String label, String sub) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: ZenoTheme.background,
                borderRadius: BorderRadius.circular(6)),
            child: Icon(icon, size: 16, color: ZenoTheme.textSecondary),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold)),
              Text(sub,
                  style: const TextStyle(
                      fontSize: 10, color: ZenoTheme.textSecondary)),
            ],
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios,
              size: 10, color: ZenoTheme.textSecondary),
        ],
      ),
    );
  }

  Widget _timelineItem(String time, String msg, {String? user}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              if (user != null)
                CircleAvatar(
                    radius: 10,
                    backgroundColor: ZenoTheme.accent.withValues(alpha: 0.2),
                    child: Text(user,
                        style: const TextStyle(
                            fontSize: 8,
                            color: ZenoTheme.accent,
                            fontWeight: FontWeight.bold)))
              else
                Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                        color: ZenoTheme.accent, shape: BoxShape.circle)),
              Container(width: 1, height: 40, color: ZenoTheme.border),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(time,
                    style: const TextStyle(
                        fontSize: 10, color: ZenoTheme.textSecondary)),
                const SizedBox(height: 4),
                Text(msg, style: const TextStyle(fontSize: 11)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _fileItem(String name, String size, String type) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: ZenoTheme.background,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: ZenoTheme.border)),
      child: Row(
        children: [
          Icon(
              type == "IMAGE"
                  ? Icons.image_outlined
                  : Icons.description_outlined,
              size: 18,
              color: ZenoTheme.textSecondary),
          const SizedBox(width: 16),
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(name,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold)),
              Text(size,
                  style: const TextStyle(
                      fontSize: 10, color: ZenoTheme.textSecondary)),
            ]),
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.download,
                  size: 16, color: ZenoTheme.textSecondary)),
        ],
      ),
    );
  }

  Widget _commentItem(String name, String msg, String time) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(name,
                  style: const TextStyle(
                      fontSize: 11, fontWeight: FontWeight.bold)),
              const SizedBox(width: 8),
              Text(time,
                  style: const TextStyle(
                      fontSize: 9, color: ZenoTheme.textSecondary)),
            ],
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: ZenoTheme.background,
                borderRadius: BorderRadius.circular(8)),
            child: Text(msg, style: const TextStyle(fontSize: 11, height: 1.4)),
          ),
        ],
      ),
    );
  }

  Widget _aiInsight(String title, String msg, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.auto_awesome, size: 14, color: color),
              const SizedBox(width: 8),
              Text(title.toUpperCase(),
                  style: TextStyle(
                      fontSize: 10, fontWeight: FontWeight.bold, color: color)),
            ],
          ),
          const SizedBox(height: 8),
          Text(msg,
              style:
                  const TextStyle(fontSize: 11, color: ZenoTheme.textPrimary)),
        ],
      ),
    );
  }

  Widget _miniActionIcon(IconData icon) {
    return Icon(icon, size: 14, color: ZenoTheme.textSecondary);
  }
}
