part of '../side_info_panel.dart';

extension _ZenoSideInfoPanelTabsState on _ZenoSideInfoPanelState {
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
        _teamMember("Alice Rivera", "Out of Office", Colors.redAccent),
      ],
    );
  }
}
