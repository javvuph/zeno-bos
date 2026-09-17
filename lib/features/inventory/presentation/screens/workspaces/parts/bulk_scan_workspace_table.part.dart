part of '../bulk_scan_workspace.dart';

extension _BulkScanWorkspaceTableState on _BulkScanWorkspaceState {
  String getBulkFieldLabel(String fieldId) {
    switch (fieldId) {
      case 'title':
        return 'Product Name / Style Title *';
      case 'category':
        return 'Category *';
      case 'brand':
        return 'Brand / Label';
      case 'sku':
        return 'SKU / Style Code *';
      case 'barcode':
        return 'Barcode / GTIN';
      case 'costPrice':
        return 'Purchase / Cost Price (₹) *';
      case 'sellingPrice':
        return 'Selling Price / MRP (₹) *';
      case 'discountValue':
        return 'Discount Value (%)';
      case 'reorderLevel':
        return 'Low Stock Alert Threshold';
      case 'openingStock':
        return 'Flat Opening Stock Quantity';
      case 'primaryImageUrl':
        return 'Primary Photo';
      case 'description':
        return 'Online Store Description';
      case 'mrp':
        return 'MRP (₹)';
      case 'discountType':
        return 'Discount Type';
      case 'hsnCode':
        return 'HSN / Tax Code';
      case 'taxRate':
        return 'Tax Rate (%)';
      case 'supplier':
        return 'Supplier';
      case 'countryOfOrigin':
        return 'Country of Origin';
      case 'status':
        return 'Status';
      case 'fabric':
        return 'Fabric';
      case 'neckType':
        return 'Neck Type';
      case 'sleeveType':
        return 'Sleeve Type';
      case 'fitType':
        return 'Fit Type';
      case 'pattern':
        return 'Pattern';
      case 'gender':
        return 'Gender';
      case 'ageGroup':
        return 'Age Group';
      case 'season':
        return 'Season';
      case 'shade':
        return 'Shade / Color';
      case 'sizeStandard':
        return 'Size Standard';
      case 'urlSlug':
        return 'URL Slug';
      case 'searchKeywords':
        return 'Search Keywords';
      case 'metaDescription':
        return 'Meta Description';
      case 'marketingTitle':
        return 'Marketing Title';
      default:
        return widget.controller.getFieldLabel(fieldId);
    }
  }

  List<String> _fieldsForTab(List<String> allFields) {
    final isAdvanced = widget.controller.isAdvancedMode;

    if (!isAdvanced) {
      switch (_activeTab) {
        case BulkWorkspaceTab.basicInfo:
          return const [
            'primaryImageUrl',
            'title',
            'category',
            'brand',
            'sku',
            'barcode',
            'costPrice',
            'sellingPrice',
            'discountValue',
            'reorderLevel',
            'openingStock',
            'description',
          ];
        case BulkWorkspaceTab.variants:
        case BulkWorkspaceTab.stock:
        default:
          return const [
            'title',
            'sku',
            'barcode',
            'shade',
            'sizeStandard',
            'openingStock',
            'reorderLevel',
          ];
      }
    }

    switch (_activeTab) {
      case BulkWorkspaceTab.basicInfo:
        return const [
          'primaryImageUrl',
          'title',
          'category',
          'brand',
          'sku',
          'barcode',
          'countryOfOrigin',
          'status',
          'description',
        ];
      case BulkWorkspaceTab.specs:
        return const [
          'fabric',
          'neckType',
          'sleeveType',
          'fitType',
          'pattern',
          'gender',
          'ageGroup',
          'season',
        ];
      case BulkWorkspaceTab.variants:
        return const [
          'sizeStandard',
          'shade',
          'sku',
          'barcode',
          'openingStock',
          'sellingPrice',
        ];
      case BulkWorkspaceTab.stock:
      case BulkWorkspaceTab.price:
        return const [
          'costPrice',
          'sellingPrice',
          'mrp',
          'discountType',
          'discountValue',
          'openingStock',
          'reorderLevel',
          'supplier',
          'hsnCode',
          'taxRate',
        ];
      case BulkWorkspaceTab.media:
        return const [
          'urlSlug',
          'searchKeywords',
          'metaDescription',
          'marketingTitle',
        ];
    }
  }

  Widget _buildBulkTabBar() {
    final isAdvanced = widget.controller.isAdvancedMode;
    final List<_BulkTabConfig> tabs = isAdvanced
        ? [
            const _BulkTabConfig(label: 'BASIC INFO', tab: BulkWorkspaceTab.basicInfo),
            const _BulkTabConfig(label: 'SPECS', tab: BulkWorkspaceTab.specs),
            const _BulkTabConfig(label: 'VARIANTS', tab: BulkWorkspaceTab.variants),
            const _BulkTabConfig(label: 'STOCK & PRICE', tab: BulkWorkspaceTab.stock),
            const _BulkTabConfig(label: 'MEDIA & SEO', tab: BulkWorkspaceTab.media),
          ]
        : [
            const _BulkTabConfig(label: 'BASIC INFO', tab: BulkWorkspaceTab.basicInfo),
            const _BulkTabConfig(label: 'VARIANTS & STOCK', tab: BulkWorkspaceTab.variants),
          ];

    return Container(
      height: 38,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: const Color(0xFF0066CC).withValues(alpha: 0.2))),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: tabs.map((tab) {
            final selected = _activeTab == tab.tab;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: InkWell(
                onTap: () {
                  if (tab.tab == BulkWorkspaceTab.variants) {
                    _openVariantDrawer();
                    return;
                  }
                  _setActiveTab(tab.tab);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: selected ? const Color(0xFF0066CC) : Colors.transparent,
                            width: 2)),
                  ),
                  child: Text(
                    tab.label,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
                      letterSpacing: 0.5,
                      textBaseline: TextBaseline.alphabetic,
                      color: selected
                          ? const Color(0xFF0066CC)
                          : const Color(0xFF4a5f7f),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
