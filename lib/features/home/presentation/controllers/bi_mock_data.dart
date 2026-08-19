import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';

class BIMockData {
  // --- SALES TREND DATA ---
  static List<SalesPoint> getSalesTrend() {
    return [
      SalesPoint(DateTime(2026, 7, 1), 120000, 45000, 95000),
      SalesPoint(DateTime(2026, 7, 5), 150000, 52000, 110000),
      SalesPoint(DateTime(2026, 7, 10), 135000, 48000, 105000),
      SalesPoint(DateTime(2026, 7, 15), 180000, 65000, 140000),
      SalesPoint(DateTime(2026, 7, 20), 210000, 72000, 155000),
      SalesPoint(DateTime(2026, 7, 25), 240500, 85000, 175000),
    ];
  }

  // --- PRODUCT PERFORMANCE ---
  static List<ProductMetric> getTopProducts() {
    return [
      ProductMetric("iPhone 15 Pro", 450000, 120, const Color(0xFF3366FF)),
      ProductMetric("MacBook M3", 380000, 85, const Color(0xFF00C853)),
      ProductMetric("iPad Air", 120000, 210, const Color(0xFFFFAB00)),
      ProductMetric("AirPods Max", 95000, 340, const Color(0xFF9C27B0)),
      ProductMetric("Apple Watch S9", 82000, 410, const Color(0xFFFF1744)),
    ];
  }

  // --- AI INSIGHTS ---
  static List<Map<String, dynamic>> getAIInsights() {
    return [
      {
        "type": "Warning",
        "title": "Stock Depletion",
        "message":
            "Flagship 'MacBook M3' stock will last only 5 days at current velocity.",
        "color": Colors.red,
        "action": "Restock Now"
      },
      {
        "type": "Opportunity",
        "title": "Revenue Growth",
        "message":
            "Sales increased 18% compared to last month. North branch leads growth.",
        "color": ZenoTheme.neonGreen,
        "action": "View Analysis"
      },
      {
        "type": "Optimization",
        "title": "Expense Alert",
        "message":
            "Logistics costs are 12% above budget due to fuel surcharge spikes.",
        "color": Colors.orange,
        "action": "Optimize Routes"
      },
      {
        "type": "Prediction",
        "title": "Weekend Surge",
        "message":
            "Expected 25% increase in online orders this weekend based on historical trends.",
        "color": ZenoTheme.neonCyan,
        "action": "Prepare Logistics"
      },
    ];
  }

  // --- OPERATIONAL QUEUES ---
  static List<Map<String, dynamic>> getLowStockItems() {
    return [
      {
        "name": "Dell XPS 15",
        "stock": 4,
        "min": 10,
        "reorder": 15,
        "warehouse": "Main-WH",
        "supplier": "Dell Inc.",
        "daysRemaining": 3,
        "expectedOut": "28 Jul",
        "priority": "Critical"
      },
      {
        "name": "Samsung S24",
        "stock": 2,
        "min": 20,
        "reorder": 25,
        "warehouse": "South-WH",
        "supplier": "Samsung",
        "daysRemaining": 1,
        "expectedOut": "26 Jul",
        "priority": "Critical"
      },
      {
        "name": "Logitech MX",
        "stock": 8,
        "min": 30,
        "reorder": 50,
        "warehouse": "Main-WH",
        "supplier": "Logitech",
        "daysRemaining": 12,
        "expectedOut": "06 Aug",
        "priority": "Medium"
      },
    ];
  }

  static List<Map<String, dynamic>> getPendingOrders() {
    return [
      {
        "id": "ORD-8821",
        "customer": "Global Corp",
        "amount": "\$12,400",
        "status": "Packing",
        "time": "12m ago"
      },
      {
        "id": "ORD-8822",
        "customer": "Tech Solutions",
        "amount": "\$5,200",
        "status": "Unpaid",
        "time": "1h ago"
      },
      {
        "id": "ORD-8823",
        "customer": "Design Studio",
        "amount": "\$2,100",
        "status": "Delayed",
        "time": "3h ago"
      },
      {
        "id": "ORD-8824",
        "customer": "Personal",
        "amount": "\$450",
        "status": "Cancelled",
        "time": "5h ago"
      },
    ];
  }

  static List<Map<String, dynamic>> getApprovals() {
    return [
      {
        "type": "Discount",
        "from": "Sales Rep A",
        "msg": "Request 15% on SKU-882",
        "time": "12m ago",
        "priority": "High"
      },
      {
        "type": "Expense",
        "from": "Admin",
        "msg": "Fuel claim \$120",
        "time": "1h ago",
        "priority": "Medium"
      },
      {
        "type": "PO",
        "from": "Inventory",
        "msg": "Urgent restock \$4,500",
        "time": "3h ago",
        "priority": "Critical"
      },
      {
        "type": "Leave",
        "from": "Staff B",
        "msg": "Annual leave (3 days)",
        "time": "5h ago",
        "priority": "Low"
      },
    ];
  }

  static List<Map<String, dynamic>> getCustomerFollowups() {
    return [
      {
        "name": "John Doe",
        "issue": "Delayed Delivery",
        "days": "2d",
        "priority": "High",
        "type": "Complaint"
      },
      {
        "name": "Tech Corp",
        "issue": "Credit Limit Exceeded",
        "days": "1h",
        "priority": "Critical",
        "type": "Finance"
      },
      {
        "name": "Alice Smith",
        "issue": "Birthday Reminder",
        "days": "Today",
        "priority": "Medium",
        "type": "Birthday"
      },
      {
        "name": "Retailer X",
        "issue": "Inactive for 30 days",
        "days": "5d",
        "priority": "Low",
        "type": "Inactive"
      },
    ];
  }

  // --- AI COMMAND CENTRE DATA ---

  static Map<String, double> getBusinessHealthScores() {
    return {
      "Overall": 88,
      "Sales": 92,
      "Finance": 85,
      "Inventory": 72,
      "Customer": 94,
      "Operations": 88,
      "Delivery": 81,
      "HR": 90,
      "Supplier": 78,
      "Risk": 12, // Lower is better for risk
      "Growth": 86,
    };
  }

  static List<String> getAIExecutiveSummary() {
    return [
      "Revenue increased 18% compared to previous month.",
      "Profit margin improved by 4% due to reduced logistics cost.",
      "Inventory turnover slowed by 6% in North Branch.",
      "Customer growth exceeded target by 12% in Q3.",
      "Expenses increased 8% due to fuel surcharge spikes.",
      "Receivables are increasing; 12 invoices overdue.",
      "Three suppliers have delayed deliveries in transit.",
      "Two flagship products require immediate reorder.",
      "Overall cash flow remains healthy with 3x coverage.",
    ];
  }

  static List<Map<String, dynamic>> getAIPredictions() {
    return [
      {
        "title": "Sales Prediction",
        "value": "+15%",
        "sub": "Revenue growth next month",
        "detail": "Peak Hours: 2PM - 6PM",
        "color": ZenoTheme.neonCyan
      },
      {
        "title": "Inventory Risk",
        "value": "28 Jul",
        "sub": "MacBook M3 Stock-out",
        "detail": "Reorder Qty: 45 units",
        "color": Colors.red
      },
      {
        "title": "Cash Flow Forecast",
        "value": "\$1.4M",
        "sub": "Estimated end of quarter",
        "detail": "Tax Liability: \$42k",
        "color": ZenoTheme.neonGreen
      },
      {
        "title": "Churn Probability",
        "value": "4.2%",
        "sub": "Customer retention stable",
        "detail": "High Value Risk: 2",
        "color": Colors.purple
      },
    ];
  }

  static List<Map<String, dynamic>> getAIRecommendations() {
    return [
      {
        "title": "Restock 'Dell XPS 15'",
        "reason": "Current velocity suggests stock out in 3 days.",
        "action": "Generate PO",
        "icon": Icons.shopping_cart_outlined,
        "color": Colors.orange
      },
      {
        "title": "Contact 'Tech Solutions'",
        "reason": "Outstanding balance \$12k exceeded credit limit.",
        "action": "Send Reminder",
        "icon": Icons.phone_outlined,
        "color": Colors.red
      },
      {
        "title": "Increase Weekend Staffing",
        "reason": "Predicted 25% surge in retail traffic.",
        "action": "Notify HR",
        "icon": Icons.people_outline,
        "color": ZenoTheme.neonCyan
      },
      {
        "title": "Negotiate with 'Intel'",
        "reason": "Price benchmark shows 5% saving opportunity.",
        "action": "Open Draft",
        "icon": Icons.handshake_outlined,
        "color": ZenoTheme.neonGreen
      },
    ];
  }

  static List<ForecastPoint> getForecastData() {
    return [
      ForecastPoint(DateTime(2026, 7, 20), 180000, 180000),
      ForecastPoint(DateTime(2026, 7, 25), 210000, 215000),
      ForecastPoint(DateTime(2026, 7, 30), null, 240000,
          lower: 220000, upper: 260000),
      ForecastPoint(DateTime(2026, 8, 4), null, 270000,
          lower: 240000, upper: 300000),
      ForecastPoint(DateTime(2026, 8, 9), null, 250000,
          lower: 210000, upper: 290000),
    ];
  }
}

class ForecastPoint {
  final DateTime date;
  final double? actual;
  final double predicted;
  final double? lower;
  final double? upper;
  ForecastPoint(this.date, this.actual, this.predicted,
      {this.lower, this.upper});
}

class SalesPoint {
  final DateTime date;
  final double revenue;
  final double profit;
  final double expenses;
  SalesPoint(this.date, this.revenue, this.profit, this.expenses);
}

class ProductMetric {
  final String name;
  final double revenue;
  final int units;
  final Color color;
  ProductMetric(this.name, this.revenue, this.units, this.color);
}
