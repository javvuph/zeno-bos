import 'package:zeno/features/inventory/domain/repositories/i_inventory_repository.dart';
import 'package:zeno/features/inventory/domain/models/stock_level.dart';
import 'package:zeno/features/inventory/presentation/controllers/inventory_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zeno/features/billing/presentation/controllers/billing_studio_controller.dart';
import 'package:zeno/features/billing/presentation/controllers/billing_state.dart';
import 'package:zeno/features/billing/presentation/controllers/billing_event.dart';
import 'package:zeno/features/billing/domain/repositories/i_billing_repository.dart';
import 'package:zeno/features/billing/domain/models/bill.dart';
import 'package:zeno/features/billing/domain/models/payment.dart';
import 'package:zeno/features/billing/presentation/dialogs/payment_dialog.dart';
import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/navigation/menu_registry.dart';
import 'package:zeno/navigation/navigation_controller.dart';
import 'package:zeno/navigation/zeno_router.dart';
import 'package:zeno/features/administration/presentation/controllers/administration_controller.dart';
import 'package:zeno/features/administration/domain/models/organization.dart';
import 'package:zeno/features/administration/domain/models/settings.dart';
import 'package:zeno/core/di/service_locator.dart';
import 'package:zeno/features/administration/domain/repositories/i_administration_repository.dart';

/// ZENO mobile presentation layer.
/// Reuses the existing navigation, routes and business logic while giving
/// phones a dedicated futuristic command-center experience.
class ZenoMobileShell extends StatefulWidget {
  final NavigationController navigationController;

  const ZenoMobileShell({super.key, required this.navigationController});

  @override
  State<ZenoMobileShell> createState() => _ZenoMobileShellState();
}

class _ZenoMobileShellState extends State<ZenoMobileShell> {
  int _bottomIndex = 0;

  static const _bottomRoutes = ['dashboard', 'sales/pos', 'inventory/products', 'orders/dashboard'];
  static const _bottomLabels = ['Home', 'Billing', 'Inventory', 'Orders'];
  static const _bottomIcons = [
    Icons.grid_view_rounded,
    Icons.point_of_sale_rounded,
    Icons.inventory_2_rounded,
    Icons.shopping_bag_rounded,
  ];

  @override
  void initState() {
    super.initState();
    widget.navigationController.addListener(_onNavigationChanged);
    _syncBottomIndex();
  }

  @override
  void dispose() {
    widget.navigationController.removeListener(_onNavigationChanged);
    super.dispose();
  }

  void _onNavigationChanged() {
    if (!mounted) return;
    setState(_syncBottomIndex);
  }

  void _syncBottomIndex() {
    final route = widget.navigationController.currentRoute;
    final index = _bottomRoutes.indexWhere((item) {
      if (item == 'dashboard') return route == 'dashboard' || route == 'home';
      return route == item || route.startsWith('$item/');
    });
    if (index >= 0) _bottomIndex = index;
  }

  bool _isMobileModuleRoute(String route) {
    const prefixes = ['orders/','customers/','procurement/','finance/','reports/','ai/','hr/','admin/','marketing/','automation/','integrations/'];
    return prefixes.any(route.startsWith);
  }

  void _navigate(String route) => widget.navigationController.navigateTo(route);

  void _selectBottom(int index) => _navigate(_bottomRoutes[index]);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    final route = widget.navigationController.currentRoute;
    final isHome = route == 'dashboard' || route == 'home';

    return Scaffold(
      backgroundColor: colors.bgTier1,
      drawer: _buildDrawer(context, colors),
      extendBody: true,
      appBar: _buildAppBar(context, colors, route),
      body: Stack(
        children: [
          const _AuroraBackground(),
          SafeArea(
            top: false,
            bottom: true,
            child: KeyedSubtree(
              key: ValueKey('$route-mobile'),
              child: isHome
                  ? _MobileCommandCenter(onRoute: _navigate)
                  : route == 'admin/business-setup'
                      ? const _MobileBusinessSetup()
                      : (route == 'sales/pos' || route == 'sales/new')
                          ? const _MobileBillingView()
                          : (route == 'inventory/products' || route == 'inventory/master')
                              ? _MobileInventoryView(onRoute: _navigate)
                              : _isMobileModuleRoute(route)
                                  ? _MobileModuleHub(route: route, onRoute: _navigate)
                                  : ZenoRouter.getScreen(
                              route,
                              params: widget.navigationController.activeTab.params,
                            ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(colors),
      floatingActionButton: isHome ? null : _buildContextAction(colors, route),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget? _buildContextAction(ZenoSemanticColors colors, String route) {
    String label = 'Quick Action';
    IconData icon = Icons.bolt_rounded;
    String target = 'dashboard';
    if (route.startsWith('sales/') || route.startsWith('billing/')) { label = 'New Bill'; icon = Icons.add_shopping_cart_rounded; target = 'sales/pos'; }
    else if (route.startsWith('inventory/')) { label = 'Add Product'; icon = Icons.add_box_rounded; target = 'inventory/products'; }
    else if (route.startsWith('orders/')) { label = 'Orders'; icon = Icons.shopping_bag_rounded; target = 'orders/dashboard'; }
    else if (route.startsWith('customers/')) { label = 'Customer Hub'; icon = Icons.person_add_alt_1_rounded; target = 'customers/mgmt/list'; }
    else if (route.startsWith('ai/')) { label = 'AI Center'; icon = Icons.auto_awesome_rounded; target = 'ai/home'; }
    else if (route.startsWith('finance/')) { label = 'Finance'; icon = Icons.account_balance_wallet_rounded; target = 'finance'; }
    else return null;
    return Padding(padding: const EdgeInsets.only(bottom: 8), child: FloatingActionButton.extended(onPressed: () => _navigate(target), backgroundColor: colors.accentPrimary, foregroundColor: Colors.black, elevation: 10, icon: Icon(icon, size: 18), label: Text(label, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 11))));
  }

  PreferredSizeWidget _buildAppBar(
    BuildContext context,
    ZenoSemanticColors colors,
    String route,
  ) {
    return AppBar(
      toolbarHeight: 68,
      elevation: 0,
      backgroundColor: colors.bgTier1.withValues(alpha: 0.92),
      surfaceTintColor: Colors.transparent,
      leading: Builder(
        builder: (context) => Padding(
          padding: const EdgeInsets.only(left: 8),
          child: IconButton(
            tooltip: 'Menu',
            icon: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: colors.bgTier2,
                borderRadius: BorderRadius.circular(13),
                border: Border.all(color: colors.borderSubtle),
              ),
              child: Icon(Icons.menu_rounded, color: colors.textPrimary, size: 21),
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      titleSpacing: 6,
      title: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              gradient: ZenoTheme.aiGlowGradient,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: colors.accentPrimary.withValues(alpha: 0.20),
                  blurRadius: 16,
                ),
              ],
            ),
            child: const Icon(Icons.auto_awesome_rounded, color: Colors.black, size: 19),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ZENO', style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.w900, letterSpacing: 2.0,
                color: colors.textPrimary,
              )),
              Text(_routeTitle(route).toUpperCase(), style: TextStyle(
                fontSize: 9, fontWeight: FontWeight.w700, letterSpacing: 1.2,
                color: colors.textSecondary,
              )),
            ],
          ),
        ],
      ),
      actions: [
        _HeaderButton(icon: Icons.search_rounded, onTap: () => _openSearch(context), colors: colors),
        const SizedBox(width: 2),
        _HeaderButton(
          icon: Icons.notifications_none_rounded,
          onTap: () => widget.navigationController.toggleNotifications(),
          colors: colors,
        ),
        const SizedBox(width: 10),
      ],
    );
  }

  Widget _buildBottomBar(ZenoSemanticColors colors) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: colors.bgTier2.withValues(alpha: 0.96),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: colors.borderSubtle),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.35), blurRadius: 28, offset: const Offset(0, 10)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(_bottomLabels.length, (index) {
            final selected = _bottomIndex == index;
            return Expanded(
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () => _selectBottom(index),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      width: selected ? 44 : 34,
                      height: 30,
                      decoration: BoxDecoration(
                        gradient: selected ? ZenoTheme.aiGlowGradient : null,
                        color: selected ? null : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        _bottomIcons[index],
                        size: 19,
                        color: selected ? Colors.black : colors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _bottomLabels[index],
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
                        color: selected ? colors.textPrimary : colors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context, ZenoSemanticColors colors) {
    return Drawer(
      backgroundColor: colors.bgTier1,
      width: MediaQuery.of(context).size.width * 0.86,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 20, 16, 18),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [colors.bgTier2, colors.bgTier1],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border(bottom: BorderSide(color: colors.borderSubtle)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 46, height: 46,
                    decoration: BoxDecoration(
                      gradient: ZenoTheme.aiGlowGradient,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(Icons.auto_awesome_rounded, color: Colors.black, size: 23),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('ZENO', style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w900,
                          letterSpacing: 2.2, color: colors.textPrimary,
                        )),
                        const SizedBox(height: 3),
                        Text('BUSINESS OPERATING SYSTEM', style: TextStyle(
                          fontSize: 8, fontWeight: FontWeight.w800,
                          letterSpacing: 1.25, color: colors.accentPrimary,
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: MenuRegistry.all.length,
                itemBuilder: (context, index) => _MobileMenuGroup(
                  category: MenuRegistry.all[index],
                  currentRoute: widget.navigationController.currentRoute,
                  onRoute: _navigate,
                  colors: colors,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openSearch(BuildContext context) {
    showSearch(
      context: context,
      delegate: _ZenoMobileSearchDelegate(onSelect: _navigate),
    );
  }

  String _routeTitle(String route) {
    if (route == 'dashboard' || route == 'home') return 'Command Center';
    if (route.startsWith('sales/') || route.startsWith('billing/')) return 'Billing';
    if (route.startsWith('inventory/')) return 'Inventory';
    if (route.startsWith('orders/') || route.startsWith('procurement/')) return 'Orders';
    if (route.startsWith('customers/')) return 'Customers';
    if (route.startsWith('finance/')) return 'Finance';
    if (route.startsWith('staff/')) return 'Staff';
    if (route.startsWith('suppliers/')) return 'Suppliers';
    if (route.startsWith('ai/')) return 'AI Centre';
    return 'Workspace';
  }
}

class _MobileBusinessSetup extends StatefulWidget {
  const _MobileBusinessSetup();
  @override State<_MobileBusinessSetup> createState() => _MobileBusinessSetupState();
}
class _MobileBusinessSetupState extends State<_MobileBusinessSetup> {
  int step=0; final data=_MobileStoreSetupData(); late final AdministrationController _admin; final Map<String, TextEditingController> _fields={};
  static const steps=[('IDENTITY',Icons.storefront_rounded),('REGION',Icons.public_rounded),('POS',Icons.point_of_sale_rounded),('ONLINE',Icons.qr_code_2_rounded),('TEAM',Icons.groups_rounded),('AI',Icons.auto_awesome_rounded)];
  @override void initState(){super.initState(); _admin=AdministrationController(sl<IAdministrationRepository>()); final p=_admin.company.preferences; data.loadPreferences(p); for(final e in {'storeName':data.storeName,'legalName':data.legalName,'phone':data.phone,'email':data.email,'taxId':data.taxId,'address':data.address,'city':data.city,'zip':data.zip,'invoicePrefix':data.invoicePrefix,'orderPrefix':data.orderPrefix,'receiptPrefix':data.receiptPrefix,'purchasePrefix':data.purchasePrefix,'staffEmail':data.staffEmail,'staffPin':data.staffPin}.entries){_fields[e.key]=TextEditingController(text:e.value);}}
  @override void dispose(){for(final c in _fields.values){c.dispose();}_admin.dispose();super.dispose();}
  @override Widget build(BuildContext context){final c=Theme.of(context).extension<ZenoSemanticColors>()!;return ListView(padding:const EdgeInsets.fromLTRB(14,8,14,110),children:[_header(c),const SizedBox(height:12),_rail(c),const SizedBox(height:12),AnimatedSwitcher(duration:const Duration(milliseconds:180),child:KeyedSubtree(key:ValueKey(step),child:_content(c))),const SizedBox(height:12),Row(children:[if(step>0)Expanded(child:OutlinedButton.icon(onPressed:()=>setState(()=>step--),icon:const Icon(Icons.arrow_back_rounded,size:17),label:const Text('PREVIOUS'))),if(step>0)const SizedBox(width:9),Expanded(child:ElevatedButton.icon(onPressed:_next,icon:Icon(step==5?Icons.check_rounded:Icons.arrow_forward_rounded,size:18),label:Text(step==5?'SAVE & SYNC':'CONTINUE')))])]);}
  Widget _header(ZenoSemanticColors c)=>Container(padding:const EdgeInsets.all(16),decoration:BoxDecoration(gradient:LinearGradient(colors:[c.bgTier2,c.bgTier1]),borderRadius:BorderRadius.circular(20),border:Border.all(color:c.borderSubtle)),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Row(children:[Container(width:42,height:42,decoration:BoxDecoration(gradient:ZenoTheme.aiGlowGradient,borderRadius:BorderRadius.circular(13)),child:const Icon(Icons.storefront_rounded,color:Colors.black,size:21)),const SizedBox(width:11),Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text('STORE SETUP',style:TextStyle(fontSize:18,fontWeight:FontWeight.w900,color:c.textPrimary,letterSpacing:1)),Text('Complete store workspace configuration',style:TextStyle(fontSize:9,color:c.textSecondary))])),Text((step+1).toString()+'/6',style:TextStyle(fontSize:11,fontWeight:FontWeight.w900,color:c.accentPrimary))]),const SizedBox(height:13),ClipRRect(borderRadius:BorderRadius.circular(8),child:LinearProgressIndicator(value:(step+1)/6,minHeight:5,backgroundColor:c.bgTier1,valueColor:AlwaysStoppedAnimation(c.accentPrimary))) ]));
  Widget _rail(ZenoSemanticColors c)=>SizedBox(height:58,child:ListView.separated(scrollDirection:Axis.horizontal,itemCount:6,separatorBuilder:(_,__)=>const SizedBox(width:7),itemBuilder:(_,i){final active=i==step,done=i<step;return InkWell(onTap:()=>setState(()=>step=i),borderRadius:BorderRadius.circular(14),child:Container(width:76,decoration:BoxDecoration(color:active?c.accentPrimary.withValues(alpha:.12):c.bgTier2,borderRadius:BorderRadius.circular(14),border:Border.all(color:active?c.accentPrimary.withValues(alpha:.55):c.borderSubtle)),child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[Icon(done?Icons.check_circle_rounded:steps[i].$2,size:18,color:active||done?c.accentPrimary:c.textSecondary),const SizedBox(height:3),Text(steps[i].$1,style:TextStyle(fontSize:7,fontWeight:FontWeight.w900,color:active?c.textPrimary:c.textSecondary))])));}));
  Widget _content(ZenoSemanticColors c){switch(step){case 0:return _card(c,'BUSINESS IDENTITY',[_input(c,'Store name',data.storeName,(v)=>data.storeName=v,Icons.storefront_outlined),_input(c,'Legal business name',data.legalName,(v)=>data.legalName=v,Icons.business_outlined),_input(c,'Phone',data.phone,(v)=>data.phone=v,Icons.phone_outlined,keyboard:TextInputType.phone),_input(c,'Email',data.email,(v)=>data.email=v,Icons.email_outlined,keyboard:TextInputType.emailAddress),_selector(c,'Main business',data.mainBusiness,['FASHION','RETAIL','FOOD & BEVERAGE','HEALTHCARE','SERVICES','WHOLESALE','ELECTRONICS','FURNITURE'],(v)=>setState(()=>data.mainBusiness=v)),_chips(c,'Sub-business',['Clothing','Footwear','Watches','Eyewear','Bags','Jewelry','Cosmetics','Boutique'],data.subBusinesses,(v)=>setState(()=>data.subBusinesses.contains(v)?data.subBusinesses.remove(v):data.subBusinesses.add(v))),_chips(c,'Business scale',['SMALL • 1 STORE','GROWING • 2–3 BRANCHES','ENTERPRISE • MULTI-CHAIN'],data.scale==''?<String>[]:[data.scale],(v)=>setState(()=>data.scale=v))]);case 1:return _card(c,'REGIONAL & TAX',[_selector(c,'Country',data.country,['India','United States','United Arab Emirates'],(v)=>setState((){data.country=v;data.currency=v=='India'?'INR':v=='United States'?'USD':'AED';})),_selector(c,'State / Place of supply',data.state,['Kerala','Karnataka','Tamil Nadu','Maharashtra','Delhi'],(v)=>setState(()=>data.state=v)),_input(c,'GSTIN / Tax ID',data.taxId,(v)=>data.taxId=v,Icons.receipt_long_outlined),_input(c,'Street address',data.address,(v)=>data.address=v,Icons.location_on_outlined),_input(c,'City',data.city,(v)=>data.city=v,Icons.location_city_outlined),_input(c,'Postal code',data.zip,(v)=>data.zip=v,Icons.markunread_mailbox_outlined,keyboard:TextInputType.number),Row(children:[Expanded(child:_selector(c,'Currency',data.currency,['INR','USD','AED','EUR'],(v)=>setState(()=>data.currency=v))),const SizedBox(width:8),Expanded(child:_selector(c,'Timezone',data.timezone,['Asia/Kolkata','Asia/Dubai','America/New_York'],(v)=>setState(()=>data.timezone=v)))]),_toggle(c,'Tax inclusive pricing','Prices include configured tax',data.taxInclusive,(v)=>setState(()=>data.taxInclusive=v))]);case 2:return _card(c,'OPERATIONS & POS',[_selector(c,'Terminal',data.terminal,['Terminal 1','Terminal 2','Main HQ Terminal','Mobile POS'],(v)=>setState(()=>data.terminal=v)),_selector(c,'Hardware',data.hardware,['Touchscreen POS','Desktop PC','Android Tablet','Handheld Scanner'],(v)=>setState(()=>data.hardware=v)),_selector(c,'Operation mode',data.operationMode,['Counter-Service','Table Service','Self-Checkout','Multi-Register'],(v)=>setState(()=>data.operationMode=v)),_selector(c,'Receipt template',data.receipt,['Thermal 80mm Standard','Thermal 58mm Compact','A4 Enterprise Invoice','Digital e-Receipt'],(v)=>setState(()=>data.receipt=v)),_chips(c,'Costing method',['FIFO','LIFO','Weighted Average','Manual'],[data.costing],(v)=>setState(()=>data.costing=v)),_chips(c,'Payment methods',['Cash','Credit Card','Debit Card','UPI','Digital Wallet','Bank Transfer'],data.payments,(v)=>setState(()=>data.payments.contains(v)?data.payments.remove(v):data.payments.add(v))),Row(children:[Expanded(child:_input(c,'Invoice prefix',data.invoicePrefix,(v)=>data.invoicePrefix=v,Icons.receipt_long_outlined)),const SizedBox(width:8),Expanded(child:_input(c,'Order prefix',data.orderPrefix,(v)=>data.orderPrefix=v,Icons.shopping_bag_outlined))]),Row(children:[Expanded(child:_input(c,'Receipt prefix',data.receiptPrefix,(v)=>data.receiptPrefix=v,Icons.receipt_outlined)),const SizedBox(width:8),Expanded(child:_input(c,'Purchase prefix',data.purchasePrefix,(v)=>data.purchasePrefix=v,Icons.inventory_outlined))])]);case 3:return _card(c,'ONLINE STORE & QR',[Container(padding:const EdgeInsets.all(14),decoration:BoxDecoration(gradient:ZenoTheme.aiGlowGradient,borderRadius:BorderRadius.circular(16)),child:Row(children:[Container(width:88,height:88,decoration:BoxDecoration(color:Colors.white,borderRadius:BorderRadius.circular(12)),child:const Icon(Icons.qr_code_2_rounded,size:68,color:Colors.black)),const SizedBox(width:12),Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[const Text('STORE ACCESS',style:TextStyle(fontSize:9,fontWeight:FontWeight.w900,color:Colors.black)),const SizedBox(height:5),Text(data.systemId,style:const TextStyle(fontSize:12,fontWeight:FontWeight.w900,color:Colors.black)),Text(data.storeUrl,style:const TextStyle(fontSize:8,color:Colors.black))]))])),_toggle(c,'Auto-print POS receipts','Send receipts to configured printer',data.autoPrint,(v)=>setState(()=>data.autoPrint=v)),_toggle(c,'Digital store enabled','Customer ordering and QR access',data.onlineEnabled,(v)=>setState(()=>data.onlineEnabled=v))]);case 4:return _card(c,'TEAM & ACCESS',[_input(c,'Staff email / username',data.staffEmail,(v)=>data.staffEmail=v,Icons.person_outline_rounded,keyboard:TextInputType.emailAddress),_input(c,'4-digit staff PIN',data.staffPin,(v)=>data.staffPin=v,Icons.lock_outline_rounded,keyboard:TextInputType.number,obscure:true),_selector(c,'Primary role',data.staffRole,['Cashier','Store Manager','Accountant','Inventory Lead'],(v)=>setState(()=>data.staffRole=v)),_toggle(c,'RBAC security','Role-based permissions',data.rbac,(v)=>setState(()=>data.rbac=v)),_toggle(c,'Require PIN at POS','Protect cashier operations',data.pinRequired,(v)=>setState(()=>data.pinRequired=v))]);default:return _card(c,'AI & ENTERPRISE WORKFLOWS',[_chips(c,'AI configuration',['Demand Forecasting','Smart Stock Replenishment','Customer Sentiment','Dynamic Pricing'],data.aiConfigs,(v)=>setState(()=>data.aiConfigs.contains(v)?data.aiConfigs.remove(v):data.aiConfigs.add(v))),_chips(c,'Workflow approvals',['Multi-Level Purchase','Discount Overrides','Inventory Adjustments','Refund Approvals'],data.approvals,(v)=>setState(()=>data.approvals.contains(v)?data.approvals.remove(v):data.approvals.add(v)),),Container(padding:const EdgeInsets.all(12),decoration:BoxDecoration(color:c.accentPrimary.withValues(alpha:.06),borderRadius:BorderRadius.circular(14),border:Border.all(color:c.accentPrimary.withValues(alpha:.18))),child:Text('ZENO will initialize your selected operating profile, POS defaults, team controls and AI workflows together.',style:TextStyle(fontSize:10,height:1.35,color:c.textSecondary))) ]);}}
  Widget _card(ZenoSemanticColors c,String title,List<Widget> children)=>Container(padding:const EdgeInsets.all(14),decoration:BoxDecoration(color:c.bgTier2,borderRadius:BorderRadius.circular(19),border:Border.all(color:c.borderSubtle)),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(title,style:TextStyle(fontSize:11,fontWeight:FontWeight.w900,letterSpacing:1.35,color:c.textPrimary)),const SizedBox(height:12),...children.map((w)=>Padding(padding:const EdgeInsets.only(bottom:9),child:w))]));
  Widget _input(ZenoSemanticColors c,String label,String value,ValueChanged<String> onChanged,IconData icon,{TextInputType? keyboard,bool obscure=false})=>TextField(controller:_fields.putIfAbsent(_fieldKey(label),()=>TextEditingController(text:value)),obscureText:obscure,keyboardType:keyboard,onChanged:onChanged,style:TextStyle(fontSize:11,color:c.textPrimary),decoration:InputDecoration(labelText:label,prefixIcon:Icon(icon,size:18),filled:true,fillColor:c.bgTier1,border:OutlineInputBorder(borderRadius:BorderRadius.circular(12),borderSide:BorderSide(color:c.borderSubtle)),enabledBorder:OutlineInputBorder(borderRadius:BorderRadius.circular(12),borderSide:BorderSide(color:c.borderSubtle))));
  String _fieldKey(String label){const m={'Store name':'storeName','Legal business name':'legalName','Phone':'phone','Email':'email','GSTIN / Tax ID':'taxId','Street address':'address','City':'city','Postal code':'zip','Invoice prefix':'invoicePrefix','Order prefix':'orderPrefix','Receipt prefix':'receiptPrefix','Purchase prefix':'purchasePrefix','Staff email / username':'staffEmail','4-digit staff PIN':'staffPin'};return m[label]??label;}
  Widget _selector(ZenoSemanticColors c,String label,String value,List<String> values,ValueChanged<String> onChanged)=>DropdownButtonFormField<String>(initialValue:values.contains(value)?value:values.first,items:values.map((v)=>DropdownMenuItem(value:v,child:Text(v,style:TextStyle(fontSize:10,color:c.textPrimary)))).toList(),onChanged:(v){if(v!=null)onChanged(v);},decoration:InputDecoration(labelText:label,filled:true,fillColor:c.bgTier1,border:OutlineInputBorder(borderRadius:BorderRadius.circular(12),borderSide:BorderSide(color:c.borderSubtle))));
  Widget _chips(ZenoSemanticColors c,String label,List<String> values,List<String> selected,ValueChanged<String> onTap)=>Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(label,style:TextStyle(fontSize:9,fontWeight:FontWeight.w800,color:c.textSecondary)),const SizedBox(height:6),Wrap(spacing:6,runSpacing:6,children:values.map((v){final active=selected.contains(v);return InkWell(onTap:()=>onTap(v),borderRadius:BorderRadius.circular(10),child:Container(padding:const EdgeInsets.symmetric(horizontal:9,vertical:7),decoration:BoxDecoration(color:active?c.accentPrimary.withValues(alpha:.13):c.bgTier1,borderRadius:BorderRadius.circular(10),border:Border.all(color:active?c.accentPrimary.withValues(alpha:.5):c.borderSubtle)),child:Text(v,style:TextStyle(fontSize:8,fontWeight:FontWeight.w800,color:active?c.accentPrimary:c.textSecondary))));}).toList())]);
  Widget _toggle(ZenoSemanticColors c,String title,String subtitle,bool value,ValueChanged<bool> onChanged)=>SwitchListTile(contentPadding:EdgeInsets.zero,dense:true,title:Text(title,style:TextStyle(fontSize:11,fontWeight:FontWeight.w800,color:c.textPrimary)),subtitle:Text(subtitle,style:TextStyle(fontSize:8,color:c.textSecondary)),value:value,onChanged:onChanged,activeThumbColor:c.accentPrimary);
  Future<void> _saveAndSync() async {
    FocusManager.instance.primaryFocus?.unfocus();
    final old=_admin.company;
    final prefs=<String,dynamic>{
      'storeName':data.storeName,'phone':data.phone,'email':data.email,'legalName':data.legalName,'mainBusiness':data.mainBusiness,
      'subBusinesses':List<String>.from(data.subBusinesses),'scale':data.scale,'country':data.country,'state':data.state,
      'city':data.city,'zip':data.zip,'terminal':data.terminal,'hardware':data.hardware,'operationMode':data.operationMode,
      'receipt':data.receipt,'costing':data.costing,'payments':List<String>.from(data.payments),
      'invoicePrefix':data.invoicePrefix,'orderPrefix':data.orderPrefix,'receiptPrefix':data.receiptPrefix,
      'purchasePrefix':data.purchasePrefix,'systemId':data.systemId,'storeUrl':data.storeUrl,'staffEmail':data.staffEmail,
      'staffPin':data.staffPin,'staffRole':data.staffRole,'taxInclusive':data.taxInclusive,'autoPrint':data.autoPrint,
      'onlineEnabled':data.onlineEnabled,'rbac':data.rbac,'pinRequired':data.pinRequired,
      'aiConfigs':List<String>.from(data.aiConfigs),'approvals':List<String>.from(data.approvals),
    };
    await _admin.updateCompany(Company(id:old.id,name:data.storeName,taxId:data.taxId,gst:data.taxId,address:data.address,
      currency:data.currency,timezone:data.timezone,preferences:prefs,isDefault:old.isDefault));
    if(mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('STORE CONFIGURATION SYNCED • '+data.storeName),behavior:SnackBarBehavior.floating));
  }
  void _next(){if(step<5){setState(()=>step++);}else{_saveAndSync();}}
}
class _MobileStoreSetupData{
void loadPreferences(Map<String,dynamic> p){
  if(p.isEmpty)return;
  String str(String k,String fallback)=>p[k] is String && (p[k] as String).isNotEmpty?p[k] as String:fallback;
  List<String> list(String k,List<String> fallback)=>p[k] is List?List<String>.from((p[k] as List).whereType<String>()):fallback;
  storeName=str('storeName',storeName); legalName=str('legalName',legalName); phone=str('phone',phone); email=str('email',email);
  taxId=str('taxId',taxId); address=str('address',address); city=str('city',city); zip=str('zip',zip); mainBusiness=str('mainBusiness',mainBusiness);
  subBusinesses=list('subBusinesses',subBusinesses); scale=str('scale',scale); country=str('country',country); state=str('state',state);
  currency=str('currency',currency); timezone=str('timezone',timezone); terminal=str('terminal',terminal); hardware=str('hardware',hardware);
  operationMode=str('operationMode',operationMode); receipt=str('receipt',receipt); costing=str('costing',costing);
  payments=list('payments',payments); invoicePrefix=str('invoicePrefix',invoicePrefix); orderPrefix=str('orderPrefix',orderPrefix);
  receiptPrefix=str('receiptPrefix',receiptPrefix); purchasePrefix=str('purchasePrefix',purchasePrefix); systemId=str('systemId',systemId);
  storeUrl=str('storeUrl',storeUrl); staffEmail=str('staffEmail',staffEmail); staffPin=str('staffPin',staffPin); staffRole=str('staffRole',staffRole);
  taxInclusive=p['taxInclusive'] is bool?p['taxInclusive'] as bool:taxInclusive; autoPrint=p['autoPrint'] is bool?p['autoPrint'] as bool:autoPrint;
  onlineEnabled=p['onlineEnabled'] is bool?p['onlineEnabled'] as bool:onlineEnabled; rbac=p['rbac'] is bool?p['rbac'] as bool:rbac;
  pinRequired=p['pinRequired'] is bool?p['pinRequired'] as bool:pinRequired; aiConfigs=list('aiConfigs',aiConfigs); approvals=list('approvals',approvals);
}
String storeName='Tagsole Main',legalName='Tagsole Apparel Private Limited',phone='+91',email='branch@zeno.store',mainBusiness='FASHION',scale='SMALL • 1 STORE',country='India',state='Kerala',taxId='32AAAAAA000A1Z5',address='Building 12, Commercial Street',city='Calicut',zip='673001',currency='INR',timezone='Asia/Kolkata',terminal='Terminal 1',hardware='Touchscreen POS',operationMode='Counter-Service',receipt='Thermal 80mm Standard',costing='FIFO',invoicePrefix='INV',orderPrefix='ORD',receiptPrefix='REC',purchasePrefix='PUR',systemId='STR-9821-IND',storeUrl='https://zeno.store/str-9821-ind',staffEmail='cashier@zeno.store',staffPin='1234',staffRole='Cashier';
List<String> subBusinesses=['Clothing','Footwear'],payments=['Cash','Credit Card','Debit Card','UPI'],aiConfigs=['Demand Forecasting','Smart Stock Replenishment'],approvals=['Discount Overrides','Inventory Adjustments'];
bool taxInclusive=true,autoPrint=false,onlineEnabled=true,rbac=true,pinRequired=true;
}

class _MobileBillingView extends StatelessWidget {
  const _MobileBillingView();
  @override Widget build(BuildContext context) {
    final colors=Theme.of(context).extension<ZenoSemanticColors>()!;
    return BlocProvider(
      create: (_) => BillingStudioController(sl<IBillingRepository>()),
      child: BlocBuilder<BillingStudioController,BillingState>(
        builder:(context,state){
          final bill=state.activeBill;
          return ListView(padding:const EdgeInsets.fromLTRB(14,10,14,110),children:[
            Container(padding:const EdgeInsets.all(16),decoration:BoxDecoration(gradient:ZenoTheme.aiGlowGradient,borderRadius:BorderRadius.circular(20)),child:const Row(children:[Icon(Icons.point_of_sale_rounded,color:Colors.black,size:30),SizedBox(width:10),Text('MOBILE POS',style:TextStyle(fontSize:16,fontWeight:FontWeight.w900,color:Colors.black))])),
            const SizedBox(height:10),
            TextField(onSubmitted:(v){if(v.trim().isNotEmpty)context.read<BillingStudioController>().add(AddItemRequested(v.trim()));},decoration:InputDecoration(prefixIcon:Icon(Icons.qr_code_scanner_rounded,color:colors.accentPrimary),hintText:'Scan barcode or enter SKU…',filled:true,fillColor:colors.bgTier2,border:OutlineInputBorder(borderRadius:BorderRadius.circular(16),borderSide:BorderSide(color:colors.borderSubtle)))),
            const SizedBox(height:10),
            if(bill.items.isEmpty) Padding(padding:const EdgeInsets.all(35),child:Center(child:Text('CART READY • SCAN PRODUCT',style:TextStyle(fontWeight:FontWeight.w900,color:colors.textSecondary))))
            else ...bill.items.map((item)=>Container(margin:const EdgeInsets.only(bottom:8),padding:const EdgeInsets.all(12),decoration:BoxDecoration(color:colors.bgTier2,borderRadius:BorderRadius.circular(15),border:Border.all(color:colors.borderSubtle)),child:Row(children:[Expanded(child:Text(item.productName,style:TextStyle(fontWeight:FontWeight.w800,color:colors.textPrimary))),Text('x${item.quantity}',style:TextStyle(fontWeight:FontWeight.w800,color:colors.textSecondary)),const SizedBox(width:12),Text('₹${item.totalAmount.toStringAsFixed(2)}',style:TextStyle(fontWeight:FontWeight.w900,color:colors.accentPrimary))]))),
            Container(padding:const EdgeInsets.all(15),decoration:BoxDecoration(color:colors.bgTier2,borderRadius:BorderRadius.circular(18)),child:Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children:[Text('TOTAL',style:TextStyle(fontWeight:FontWeight.w900,color:colors.textSecondary)),Text('₹${bill.grandTotal.toStringAsFixed(2)}',style:TextStyle(fontSize:24,fontWeight:FontWeight.w900,color:colors.accentPrimary))])),
            const SizedBox(height:10),
            SizedBox(width:double.infinity,height:52,child:ElevatedButton(onPressed:bill.items.isEmpty?null:()=>showDialog(context:context,builder:(_)=>PaymentDialog(bill:bill,onPaymentConfirmed:(p)=>context.read<BillingStudioController>().add(PaymentInitiated(p)))),child:const Text('CHECKOUT',style:TextStyle(fontWeight:FontWeight.w900))))
          ]);
        },
      ),
    );
  }
}

class _MobileInventoryView extends StatefulWidget {
  final ValueChanged<String> onRoute;
  const _MobileInventoryView({required this.onRoute});
  @override State<_MobileInventoryView> createState()=>_MobileInventoryViewState();
}
class _MobileInventoryViewState extends State<_MobileInventoryView> {
  late final InventoryController controller;
  @override void initState(){super.initState(); controller=InventoryController(sl<IInventoryRepository>())..addListener(_refresh)..refreshAll();}
  void _refresh(){if(mounted)setState((){});}
  @override void dispose(){controller.removeListener(_refresh);controller.dispose();super.dispose();}
  @override Widget build(BuildContext context){
    final c=Theme.of(context).extension<ZenoSemanticColors>()!;
    final low=controller.allStockLevels.where((s)=>s.physical-s.reserved<=0).length;
    return ListView(padding:const EdgeInsets.fromLTRB(14,10,14,110),children:[
      Container(padding:const EdgeInsets.all(16),decoration:BoxDecoration(gradient:ZenoTheme.aiGlowGradient,borderRadius:BorderRadius.circular(20)),child:Row(children:[const Icon(Icons.inventory_2_rounded,color:Colors.black,size:30),const SizedBox(width:10),Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[const Text('INVENTORY CONTROL',style:TextStyle(fontSize:16,fontWeight:FontWeight.w900)),Text(controller.isLoading?'SYNCING STOCK…':'LIVE STOCK • ${controller.allStockLevels.length} ITEMS',style:TextStyle(fontSize:9,color:c.textSecondary))]))])),
      const SizedBox(height:10),
      Row(children:[Expanded(child:_metric(c,'STOCK UNITS','${controller.totalPhysicalStock.toStringAsFixed(0)}',Icons.inventory_2_outlined)),const SizedBox(width:8),Expanded(child:_metric(c,'RESERVED','${controller.totalReservedStock.toStringAsFixed(0)}',Icons.lock_outline)),const SizedBox(width:8),Expanded(child:_metric(c,'OUT / LOW','$low',Icons.warning_amber_rounded))]),
      const SizedBox(height:12),
      Container(padding:const EdgeInsets.symmetric(horizontal:12),decoration:BoxDecoration(color:c.bgTier2,borderRadius:BorderRadius.circular(16),border:Border.all(color:c.borderSubtle)),child:TextField(onSubmitted:(v){if(v.trim().isNotEmpty){}},decoration:InputDecoration(icon:Icon(Icons.search_rounded,color:c.accentPrimary),hintText:'Search SKU, product or barcode…',hintStyle:TextStyle(fontSize:10,color:c.textSecondary),border:InputBorder.none))),
      const SizedBox(height:12),
      _actionGrid(c,context),
      const SizedBox(height:14),
      Text('STOCK HEALTH',style:TextStyle(fontSize:10,fontWeight:FontWeight.w900,letterSpacing:1.4,color:c.textSecondary)),
      const SizedBox(height:8),
      if(controller.isLoading) const Center(child:Padding(padding:EdgeInsets.all(30),child:CircularProgressIndicator()))
      else if(controller.allStockLevels.isEmpty) _empty(c)
      else ...controller.allStockLevels.take(12).map((s)=>_stockRow(c,s)),
    ]);
  }
  Widget _metric(ZenoSemanticColors c,String l,String v,IconData icon)=>Container(padding:const EdgeInsets.all(11),decoration:BoxDecoration(color:c.bgTier2,borderRadius:BorderRadius.circular(15),border:Border.all(color:c.borderSubtle)),child:Column(children:[Icon(icon,size:18,color:c.accentPrimary),const SizedBox(height:6),Text(v,style:TextStyle(fontSize:15,fontWeight:FontWeight.w900,color:c.textPrimary)),Text(l,style:TextStyle(fontSize:7,fontWeight:FontWeight.w800,color:c.textSecondary))]));
  Widget _actionGrid(ZenoSemanticColors c,BuildContext x)=>GridView.count(shrinkWrap:true,physics:const NeverScrollableScrollPhysics(),crossAxisCount:4,mainAxisSpacing:8,crossAxisSpacing:8,childAspectRatio:.95,children:[_action(c,x,'ADD PRODUCT',Icons.add_box_outlined,'inventory/products'),_action(c,x,'STOCK IN',Icons.login_rounded,'inventory/transfers'),_action(c,x,'STOCK OUT',Icons.logout_rounded,'inventory/transfers'),_action(c,x,'SCAN',Icons.qr_code_scanner_rounded,'inventory/scanner')]);
  Widget _action(ZenoSemanticColors c,BuildContext x,String l,IconData i,String r)=>InkWell(onTap:()=>widgetNav(x,r),child:Container(decoration:BoxDecoration(color:c.bgTier2,borderRadius:BorderRadius.circular(15),border:Border.all(color:c.borderSubtle)),child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[Icon(i,color:c.accentPrimary,size:22),const SizedBox(height:6),Text(l,textAlign:TextAlign.center,style:TextStyle(fontSize:7,fontWeight:FontWeight.w900,color:c.textPrimary))])));
  void widgetNav(BuildContext x,String r)=>widget.onRoute(r);
  Widget _empty(ZenoSemanticColors c)=>Container(padding:const EdgeInsets.all(30),decoration:BoxDecoration(color:c.bgTier2,borderRadius:BorderRadius.circular(18)),child:Center(child:Text('NO STOCK DATA',style:TextStyle(fontWeight:FontWeight.w900,color:c.textSecondary))));
  Widget _stockRow(ZenoSemanticColors c,StockLevel s)=>Container(margin:const EdgeInsets.only(bottom:7),padding:const EdgeInsets.all(12),decoration:BoxDecoration(color:c.bgTier2,borderRadius:BorderRadius.circular(15),border:Border.all(color:c.borderSubtle)),child:Row(children:[Icon(Icons.inventory_2_outlined,color:c.accentPrimary),const SizedBox(width:9),Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(s.productId,style:TextStyle(fontSize:10,fontWeight:FontWeight.w900,color:c.textPrimary)),Text('Physical ${s.physical.toStringAsFixed(0)} • Reserved ${s.reserved.toStringAsFixed(0)}',style:TextStyle(fontSize:8,color:c.textSecondary))])),Text('${(s.physical-s.reserved).toStringAsFixed(0)}',style:TextStyle(fontSize:15,fontWeight:FontWeight.w900,color:(s.physical-s.reserved)<=0?c.statusDanger:c.statusSuccess))]));
}
class _MobileModuleHub extends StatelessWidget {
  final String route;
  final ValueChanged<String> onRoute;
  const _MobileModuleHub({required this.route,required this.onRoute});
  String get title {
    if(route.startsWith('orders/')) return 'ORDERS & DELIVERY';
    if(route.startsWith('customers/')) return 'CUSTOMER HUB';
    if(route.startsWith('procurement/')) return 'PROCUREMENT';
    if(route.startsWith('finance/')) return 'FINANCE CENTER';
    if(route.startsWith('reports/')) return 'REPORTS & ANALYTICS';
    if(route.startsWith('ai/')) return 'AI COMMAND CENTER';
    if(route.startsWith('hr/')) return 'TEAM & HR';
    if(route.startsWith('admin/')) return 'ADMINISTRATION';
    if(route.startsWith('marketing/')) return 'MARKETING';
    if(route.startsWith('automation/')) return 'AUTOMATION';
    if(route.startsWith('integrations/')) return 'INTEGRATIONS';
    return 'ZENO WORKSPACE';
  }
  IconData get icon {
    if(route.startsWith('orders/')) return Icons.local_shipping_rounded;
    if(route.startsWith('customers/')) return Icons.people_alt_rounded;
    if(route.startsWith('procurement/')) return Icons.shopping_cart_checkout_rounded;
    if(route.startsWith('finance/')) return Icons.account_balance_wallet_rounded;
    if(route.startsWith('reports/')) return Icons.insights_rounded;
    if(route.startsWith('ai/')) return Icons.auto_awesome_rounded;
    if(route.startsWith('hr/')) return Icons.badge_rounded;
    if(route.startsWith('admin/')) return Icons.admin_panel_settings_rounded;
    if(route.startsWith('marketing/')) return Icons.campaign_rounded;
    if(route.startsWith('automation/')) return Icons.bolt_rounded;
    if(route.startsWith('integrations/')) return Icons.hub_rounded;
    return Icons.apps_rounded;
  }
  List<(String,IconData,String)> get actions {
    if(route.startsWith('orders/')) return [('Orders',Icons.shopping_bag_rounded,'orders/dashboard'),('Delivery',Icons.local_shipping_rounded,'orders/dashboard'),('New Order',Icons.add_circle_outline,'orders/dashboard')];
    if(route.startsWith('customers/')) return [('Customers',Icons.people_alt_rounded,'customers/mgmt/list'),('New Customer',Icons.person_add_alt_1_rounded,'customers/mgmt/list'),('CRM',Icons.insights_rounded,'crm')];
    if(route.startsWith('procurement/')) return [('Suppliers',Icons.local_shipping_outlined,'suppliers'),('Purchase',Icons.receipt_long_rounded,'procurement'),('Stock',Icons.inventory_2_outlined,'inventory')];
    if(route.startsWith('finance/')) return [('Finance',Icons.account_balance_wallet_rounded,'finance'),('Payments',Icons.payments_rounded,'finance'),('Reports',Icons.analytics_rounded,'reports')];
    if(route.startsWith('reports/')) return [('Analytics',Icons.insights_rounded,'reports'),('Sales',Icons.point_of_sale_rounded,'sales/pos'),('Finance',Icons.account_balance_wallet_rounded,'finance')];
    if(route.startsWith('ai/')) return [('AI Center',Icons.auto_awesome_rounded,'ai/home'),('Insights',Icons.insights_rounded,'reports'),('Inventory AI',Icons.inventory_2_rounded,'inventory')];
    if(route.startsWith('hr/')) return [('Staff',Icons.badge_rounded,'staff'),('Attendance',Icons.schedule_rounded,'hr'),('Roles',Icons.admin_panel_settings_rounded,'admin')];
    if(route.startsWith('admin/')) return [('Business Setup',Icons.store_rounded,'admin/business-setup'),('Security',Icons.security_rounded,'admin'),('Settings',Icons.settings_rounded,'settings')];
    if(route.startsWith('marketing/')) return [('Campaigns',Icons.campaign_rounded,'marketing'),('Customers',Icons.people_alt_rounded,'customers/mgmt/list'),('Analytics',Icons.insights_rounded,'reports')];
    if(route.startsWith('automation/')) return [('Workflows',Icons.account_tree_rounded,'automation'),('Alerts',Icons.notifications_active_rounded,'notifications'),('AI',Icons.auto_awesome_rounded,'ai/home')];
    return [('Dashboard',Icons.grid_view_rounded,'dashboard'),('Billing',Icons.point_of_sale_rounded,'sales/pos'),('Inventory',Icons.inventory_2_rounded,'inventory')];
  }
  @override Widget build(BuildContext context){
    final c=Theme.of(context).extension<ZenoSemanticColors>()!;
    final a=actions;
    return ListView(padding:const EdgeInsets.fromLTRB(14,10,14,110),children:[
      Container(padding:const EdgeInsets.all(18),decoration:BoxDecoration(gradient:ZenoTheme.aiGlowGradient,borderRadius:BorderRadius.circular(20)),child:Row(children:[Icon(icon,size:30,color:Colors.black),const SizedBox(width:11),Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(title,style:const TextStyle(fontSize:16,fontWeight:FontWeight.w900,color:Colors.black)),Text('MOBILE WORKSPACE • LIVE',style:TextStyle(fontSize:8,fontWeight:FontWeight.w800,color:Colors.black.withOpacity(.65),letterSpacing:1.1))]))])),
      const SizedBox(height:12),Text('QUICK WORKSPACE',style:TextStyle(fontSize:10,fontWeight:FontWeight.w900,letterSpacing:1.5,color:c.textSecondary)),const SizedBox(height:8),
      GridView.count(shrinkWrap:true,physics:const NeverScrollableScrollPhysics(),crossAxisCount:2,crossAxisSpacing:9,mainAxisSpacing:9,childAspectRatio:1.45,children:[for(final x in a) InkWell(onTap:()=>onRoute(x.$3),borderRadius:BorderRadius.circular(17),child:Container(padding:const EdgeInsets.all(14),decoration:BoxDecoration(color:c.bgTier2,borderRadius:BorderRadius.circular(17),border:Border.all(color:c.borderSubtle)),child:Column(crossAxisAlignment:CrossAxisAlignment.start,mainAxisAlignment:MainAxisAlignment.center,children:[Icon(x.$2,size:23,color:c.accentPrimary),const SizedBox(height:9),Text(x.$1,style:TextStyle(fontSize:11,fontWeight:FontWeight.w900,color:c.textPrimary)),const SizedBox(height:3),Text('OPEN WORKSPACE',style:TextStyle(fontSize:7,fontWeight:FontWeight.w700,color:c.textSecondary))]))) ]),
      const SizedBox(height:14),Container(padding:const EdgeInsets.all(14),decoration:BoxDecoration(color:c.bgTier2,borderRadius:BorderRadius.circular(17),border:Border.all(color:c.borderSubtle)),child:Row(children:[Icon(Icons.auto_awesome_rounded,color:c.accentPrimary),const SizedBox(width:10),Expanded(child:Text('ZENO keeps your mobile workflow connected to the same business data and navigation system.',style:TextStyle(fontSize:10,height:1.45,color:c.textSecondary)))])),
    ]);
  }
}

class _MobileCommandCenter extends StatelessWidget {
  final ValueChanged<String> onRoute;
  const _MobileCommandCenter({required this.onRoute});

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).extension<ZenoSemanticColors>()!;
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 104),
      children: [
        Row(
          children: [
            Expanded(
              child: Text('Good morning,\nrun your business.', style: TextStyle(
                fontSize: 27, height: 1.05, fontWeight: FontWeight.w900,
                letterSpacing: -0.8, color: c.textPrimary,
              )),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 7),
              decoration: BoxDecoration(
                color: c.statusSuccess.withValues(alpha: 0.09),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: c.statusSuccess.withValues(alpha: 0.24)),
              ),
              child: Row(children: [
                Container(width: 7, height: 7, decoration: BoxDecoration(
                  color: c.statusSuccess, shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: c.statusSuccess.withValues(alpha: 0.7), blurRadius: 7)],
                )),
                const SizedBox(width: 6),
                Text('LIVE', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900, letterSpacing: 1, color: c.statusSuccess)),
              ]),
            ),
          ],
        ),
        const SizedBox(height: 18),
        _AiCommandCard(onTap: () => onRoute('ai')),
        const SizedBox(height: 14),
        _KpiStrip(),
        const SizedBox(height: 14),
        _InsightCard(onTap: () => onRoute('reports')),
        const SizedBox(height: 14),
        _TodayPulse(onRoute: onRoute),
        const SizedBox(height: 14),
        _RevenueChartCard(onRoute: onRoute),
        const SizedBox(height: 14),
        _RecentActivity(onRoute: onRoute),
        const SizedBox(height: 14),
        _SmartActions(onRoute: onRoute),
        const SizedBox(height: 14),
        _InventoryHealth(onRoute: onRoute),
        const SizedBox(height: 14),
        _OperationsSnapshot(onRoute: onRoute),
        const SizedBox(height: 14),
        _CommandGrid(onRoute: onRoute),
        const SizedBox(height: 14),
        _SmartAlerts(onRoute: onRoute),
        const SizedBox(height: 14),
        _AiRecommendations(onRoute: onRoute),
        const SizedBox(height: 18),
        Row(children: [
          Expanded(child: _ActionCard(
            icon: Icons.point_of_sale_rounded, label: 'NEW BILL', sub: 'Checkout',
            accent: c.accentPrimary, onTap: () => onRoute('sales/pos'),
          )),
          const SizedBox(width: 10),
          Expanded(child: _ActionCard(
            icon: Icons.add_box_rounded, label: 'PRODUCT', sub: 'Add stock',
            accent: c.accentPurple, onTap: () => onRoute('inventory/products'),
          )),
        ]),
        const SizedBox(height: 10),
        Row(children: [
          Expanded(child: _ActionCard(
            icon: Icons.local_shipping_rounded, label: 'DELIVERY', sub: 'Track orders',
            accent: c.statusSuccess, onTap: () => onRoute('orders/dashboard'),
          )),
          const SizedBox(width: 10),
          Expanded(child: _ActionCard(
            icon: Icons.analytics_rounded, label: 'ANALYTICS', sub: 'Business view',
            accent: c.amberGold, onTap: () => onRoute('reports'),
          )),
        ]),
        const SizedBox(height: 20),
        Text('WORKSPACES', style: TextStyle(
          fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1.6, color: c.textSecondary,
        )),
        const SizedBox(height: 10),
        _WorkspaceTile(icon: Icons.inventory_2_rounded, title: 'Inventory Control', subtitle: 'Products • Stock • Suppliers', accent: c.accentPrimary, onTap: () => onRoute('inventory/products')),
        _WorkspaceTile(icon: Icons.groups_rounded, title: 'Customer Hub', subtitle: 'Customers • CRM • Loyalty', accent: c.accentPurple, onTap: () => onRoute('customers')),
        _WorkspaceTile(icon: Icons.auto_awesome_rounded, title: 'AI Command Center', subtitle: 'Insights • Automation • Copilot', accent: c.statusSuccess, onTap: () => onRoute('ai')),
        const SizedBox(height: 6),
        Text('ZENO OS • MOBILE', textAlign: TextAlign.center, style: TextStyle(
          fontSize: 8, fontWeight: FontWeight.w700, letterSpacing: 1.4, color: c.textDisabled,
        )),
      ],
    );
  }
}

class _AiCommandCard extends StatelessWidget {
  final VoidCallback onTap;
  const _AiCommandCard({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).extension<ZenoSemanticColors>()!;
    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF111A2B), Color(0xFF171225)],
            begin: Alignment.topLeft, end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: c.accentPrimary.withValues(alpha: 0.25)),
          boxShadow: [BoxShadow(color: c.accentPrimary.withValues(alpha: 0.07), blurRadius: 28)],
        ),
        child: Row(children: [
          Container(
            width: 50, height: 50,
            decoration: BoxDecoration(
              gradient: ZenoTheme.aiGlowGradient,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.auto_awesome_rounded, color: Colors.black, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ZENO AI COPILOT', style: TextStyle(
                fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1.5, color: c.accentPrimary,
              )),
              const SizedBox(height: 5),
              Text('Ask ZENO anything about your business.', style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w700, color: c.textPrimary,
              )),
              const SizedBox(height: 3),
              Text('Insights • Actions • Automation', style: TextStyle(fontSize: 10, color: c.textSecondary)),
            ],
          )),
          Icon(Icons.arrow_forward_ios_rounded, size: 14, color: c.textSecondary),
        ]),
      ),
    );
  }
}


class _KpiStrip extends StatelessWidget {
  const _KpiStrip();
  @override Widget build(BuildContext context) {
    final c=Theme.of(context).extension<ZenoSemanticColors>()!;
    return SizedBox(height:104, child: ListView(scrollDirection:Axis.horizontal, children:[
      _KpiCard(label:'TODAY SALES',value:'₹ 24.8K',change:'+12.4%',icon:Icons.trending_up_rounded,accent:c.accentPrimary),
      _KpiCard(label:'ORDERS',value:'128',change:'+8.2%',icon:Icons.shopping_bag_outlined,accent:c.accentPurple),
      _KpiCard(label:'PROFIT',value:'₹ 6.4K',change:'+9.7%',icon:Icons.account_balance_wallet_outlined,accent:c.statusSuccess),
    ]));
  }
}
class _KpiCard extends StatelessWidget {
  final String label,value,change; final IconData icon; final Color accent;
  const _KpiCard({required this.label,required this.value,required this.change,required this.icon,required this.accent});
  @override Widget build(BuildContext context){final c=Theme.of(context).extension<ZenoSemanticColors>()!;return Container(width:142,margin:const EdgeInsets.only(right:10),padding:const EdgeInsets.all(13),decoration:BoxDecoration(color:c.bgTier2,borderRadius:BorderRadius.circular(18),border:Border.all(color:c.borderSubtle)),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Icon(icon,size:18,color:accent),const Spacer(),Text(label,style:TextStyle(fontSize:8,fontWeight:FontWeight.w800,letterSpacing:1,color:c.textSecondary)),const SizedBox(height:2),Row(children:[Text(value,style:TextStyle(fontSize:15,fontWeight:FontWeight.w900,color:c.textPrimary)),const Spacer(),Text(change,style:TextStyle(fontSize:8,fontWeight:FontWeight.w800,color:accent))])]);}
}
class _InsightCard extends StatelessWidget {
  final VoidCallback onTap; const _InsightCard({required this.onTap});
  @override Widget build(BuildContext context){final c=Theme.of(context).extension<ZenoSemanticColors>()!;return InkWell(onTap:onTap,borderRadius:BorderRadius.circular(18),child:Container(padding:const EdgeInsets.all(15),decoration:BoxDecoration(color:c.bgTier2,borderRadius:BorderRadius.circular(18),border:Border.all(color:c.borderSubtle)),child:Row(children:[Container(width:38,height:38,decoration:BoxDecoration(color:c.accentPurple.withValues(alpha:.10),borderRadius:BorderRadius.circular(12)),child:Icon(Icons.insights_rounded,color:c.accentPurple,size:20)),const SizedBox(width:12),Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text('AI BUSINESS SIGNAL',style:TextStyle(fontSize:9,fontWeight:FontWeight.w900,letterSpacing:1.2,color:c.accentPurple)),const SizedBox(height:4),Text('Fast-moving products are driving today’s sales.',style:TextStyle(fontSize:12,fontWeight:FontWeight.w700,color:c.textPrimary)),const SizedBox(height:3),Text('Open Analytics for the full intelligence view.',style:TextStyle(fontSize:9,color:c.textSecondary))]),),Icon(Icons.arrow_forward_ios_rounded,size:13,color:c.textSecondary)]));}
}


class _TodayPulse extends StatelessWidget {
  final ValueChanged<String> onRoute;
  const _TodayPulse({required this.onRoute});
  @override Widget build(BuildContext context){
    final c=Theme.of(context).extension<ZenoSemanticColors>()!;
    return Container(padding:const EdgeInsets.all(15),decoration:BoxDecoration(color:c.bgTier2.withValues(alpha:.92),borderRadius:BorderRadius.circular(20),border:Border.all(color:c.borderSubtle)),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
      Row(children:[Text('TODAY PULSE',style:TextStyle(fontSize:10,fontWeight:FontWeight.w900,letterSpacing:1.5,color:c.textSecondary)),const Spacer(),Text('LIVE',style:TextStyle(fontSize:8,fontWeight:FontWeight.w900,letterSpacing:1,color:c.statusSuccess))]),
      const SizedBox(height:13),
      _PulseRow(icon:Icons.warning_amber_rounded,title:'Low stock',value:'7 products',accent:c.amberGold,onTap:()=>onRoute('inventory/products')),
      _PulseRow(icon:Icons.local_shipping_outlined,title:'Deliveries',value:'12 active',accent:c.accentPrimary,onTap:()=>onRoute('orders/dashboard')),
      _PulseRow(icon:Icons.people_outline_rounded,title:'Customers',value:'18 new',accent:c.accentPurple,onTap:()=>onRoute('customers')),
    ]));
  }
}
class _PulseRow extends StatelessWidget {
  final IconData icon; final String title,value; final Color accent; final VoidCallback onTap;
  const _PulseRow({required this.icon,required this.title,required this.value,required this.accent,required this.onTap});
  @override Widget build(BuildContext context){final c=Theme.of(context).extension<ZenoSemanticColors>()!;return InkWell(onTap:onTap,borderRadius:BorderRadius.circular(12),child:Padding(padding:const EdgeInsets.symmetric(vertical:7),child:Row(children:[Container(width:32,height:32,decoration:BoxDecoration(color:accent.withValues(alpha:.10),borderRadius:BorderRadius.circular(10)),child:Icon(icon,size:17,color:accent)),const SizedBox(width:10),Expanded(child:Text(title,style:TextStyle(fontSize:11,fontWeight:FontWeight.w700,color:c.textPrimary))),Text(value,style:TextStyle(fontSize:10,fontWeight:FontWeight.w800,color:c.textSecondary)),const SizedBox(width:5),Icon(Icons.chevron_right_rounded,size:17,color:c.textDisabled)])));}
}


class _RevenueChartCard extends StatelessWidget {
  final ValueChanged<String> onRoute;
  const _RevenueChartCard({required this.onRoute});
  @override Widget build(BuildContext context){
    final c=Theme.of(context).extension<ZenoSemanticColors>()!;
    const values=[12.0,18.0,15.0,24.0,21.0,29.0,26.0];
    return InkWell(onTap:()=>onRoute('reports'),borderRadius:BorderRadius.circular(20),child:Container(padding:const EdgeInsets.all(15),decoration:BoxDecoration(color:c.bgTier2.withValues(alpha:.92),borderRadius:BorderRadius.circular(20),border:Border.all(color:c.borderSubtle)),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
      Row(children:[Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text('REVENUE FLOW',style:TextStyle(fontSize:10,fontWeight:FontWeight.w900,letterSpacing:1.5,color:c.textSecondary)),const SizedBox(height:3),Text('₹ 24.8K',style:TextStyle(fontSize:21,fontWeight:FontWeight.w900,color:c.textPrimary))]),const Spacer(),Text('+12.4%',style:TextStyle(fontSize:10,fontWeight:FontWeight.w900,color:c.statusSuccess))]),
      const SizedBox(height:12),
      SizedBox(height:82,child:CustomPaint(painter:_SparklinePainter(values:values,color:c.accentPrimary),child:const SizedBox.expand())),
      const SizedBox(height:4),
      Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children:[for(final d in ['M','T','W','T','F','S','S'])Text(d,style:TextStyle(fontSize:8,color:c.textDisabled,fontWeight:FontWeight.w700))]),
    ])));
  }
}
class _SparklinePainter extends CustomPainter {
  final List<double> values; final Color color;
  _SparklinePainter({required this.values,required this.color});
  @override void paint(Canvas canvas,Size size){if(values.isEmpty)return;final max=values.reduce((a,b)=>a>b?a:b),min=values.reduce((a,b)=>a<b?a:b);final path=Path();for(var i=0;i<values.length;i++){final x=i*size.width/(values.length-1);final y=size.height-(values[i]-min)/(max-min+0.01)*size.height*.82-size.height*.05;if(i==0)path.moveTo(x,y);else path.lineTo(x,y);}final paint=Paint()..color=color..strokeWidth=2.5..style=PaintingStyle.stroke..strokeCap=StrokeCap.round;canvas.drawPath(path,paint);final fill=Path.from(path)..lineTo(size.width,size.height)..lineTo(0,size.height)..close();canvas.drawPath(fill,Paint()..shader=LinearGradient(begin:Alignment.topCenter,end:Alignment.bottomCenter,colors:[color.withValues(alpha:.18),Colors.transparent]).createShader(Offset.zero&size));}
  @override bool shouldRepaint(covariant _SparklinePainter old)=>old.values!=values||old.color!=color;
}


class _RecentActivity extends StatelessWidget {
  final ValueChanged<String> onRoute;
  const _RecentActivity({required this.onRoute});
  @override Widget build(BuildContext context){final c=Theme.of(context).extension<ZenoSemanticColors>()!;return Container(padding:const EdgeInsets.all(15),decoration:BoxDecoration(color:c.bgTier2.withValues(alpha:.92),borderRadius:BorderRadius.circular(20),border:Border.all(color:c.borderSubtle)),child:Column(children:[Row(children:[Text('RECENT ACTIVITY',style:TextStyle(fontSize:10,fontWeight:FontWeight.w900,letterSpacing:1.5,color:c.textSecondary)),const Spacer(),TextButton(onPressed:()=>onRoute('sales/pos'),child:Text('VIEW ALL',style:TextStyle(fontSize:9,fontWeight:FontWeight.w900,color:c.accentPrimary)))]),_ActivityRow(icon:Icons.receipt_long_rounded,title:'New sale completed',meta:'INV-1048 • 2 min ago',amount:'+ ₹2,480',accent:c.statusSuccess),_ActivityRow(icon:Icons.local_shipping_outlined,title:'Order dispatched',meta:'ORD-2081 • 18 min ago',amount:'In transit',accent:c.accentPrimary),_ActivityRow(icon:Icons.person_add_alt_1_rounded,title:'Customer added',meta:'CRM • 31 min ago',amount:'New',accent:c.accentPurple)]));}
}
class _ActivityRow extends StatelessWidget {final IconData icon;final String title,meta,amount;final Color accent;const _ActivityRow({required this.icon,required this.title,required this.meta,required this.amount,required this.accent});@override Widget build(BuildContext context){final c=Theme.of(context).extension<ZenoSemanticColors>()!;return Padding(padding:const EdgeInsets.symmetric(vertical:7),child:Row(children:[Container(width:34,height:34,decoration:BoxDecoration(color:accent.withValues(alpha:.10),borderRadius:BorderRadius.circular(10)),child:Icon(icon,size:17,color:accent)),const SizedBox(width:10),Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(title,style:TextStyle(fontSize:11,fontWeight:FontWeight.w800,color:c.textPrimary)),const SizedBox(height:2),Text(meta,style:TextStyle(fontSize:8,color:c.textSecondary))]),),Text(amount,style:TextStyle(fontSize:9,fontWeight:FontWeight.w900,color:accent))]));}
}


class _SmartActions extends StatelessWidget {final ValueChanged<String> onRoute;const _SmartActions({required this.onRoute});@override Widget build(BuildContext context){final c=Theme.of(context).extension<ZenoSemanticColors>()!;return Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text('SMART ACTIONS',style:TextStyle(fontSize:10,fontWeight:FontWeight.w900,letterSpacing:1.5,color:c.textSecondary)),const SizedBox(height:9),Row(children:[Expanded(child:_SmartAction(icon:Icons.qr_code_scanner_rounded,label:'SCAN',accent:c.accentPrimary,onTap:()=>onRoute('inventory/scanner'))),const SizedBox(width:8),Expanded(child:_SmartAction(icon:Icons.receipt_long_rounded,label:'INVOICE',accent:c.accentPurple,onTap:()=>onRoute('sales/pos'))),const SizedBox(width:8),Expanded(child:_SmartAction(icon:Icons.person_search_rounded,label:'CUSTOMER',accent:c.statusSuccess,onTap:()=>onRoute('customers'))),const SizedBox(width:8),Expanded(child:_SmartAction(icon:Icons.auto_awesome_rounded,label:'AI',accent:c.amberGold,onTap:()=>onRoute('ai')))]));}}
class _SmartAction extends StatelessWidget {final IconData icon;final String label;final Color accent;final VoidCallback onTap;const _SmartAction({required this.icon,required this.label,required this.accent,required this.onTap});@override Widget build(BuildContext context){final c=Theme.of(context).extension<ZenoSemanticColors>()!;return InkWell(onTap:onTap,borderRadius:BorderRadius.circular(15),child:Container(height:72,decoration:BoxDecoration(color:c.bgTier2,borderRadius:BorderRadius.circular(15),border:Border.all(color:c.borderSubtle)),child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[Icon(icon,size:20,color:accent),const SizedBox(height:7),Text(label,style:TextStyle(fontSize:8,fontWeight:FontWeight.w900,letterSpacing:.9,color:c.textPrimary))])));}}


class _InventoryHealth extends StatelessWidget {final ValueChanged<String> onRoute;const _InventoryHealth({required this.onRoute});@override Widget build(BuildContext context){final c=Theme.of(context).extension<ZenoSemanticColors>()!;return InkWell(onTap:()=>onRoute('inventory/products'),borderRadius:BorderRadius.circular(20),child:Container(padding:const EdgeInsets.all(15),decoration:BoxDecoration(color:c.bgTier2,borderRadius:BorderRadius.circular(20),border:Border.all(color:c.borderSubtle)),child:Column(children:[Row(children:[Text('INVENTORY HEALTH',style:TextStyle(fontSize:10,fontWeight:FontWeight.w900,letterSpacing:1.5,color:c.textSecondary)),const Spacer(),Icon(Icons.arrow_forward_rounded,size:16,color:c.textSecondary)]),const SizedBox(height:13),Row(children:[Expanded(child:_HealthMetric(label:'IN STOCK',value:'84%',accent:c.statusSuccess)),const SizedBox(width:8),Expanded(child:_HealthMetric(label:'LOW STOCK',value:'7',accent:c.amberGold)),const SizedBox(width:8),Expanded(child:_HealthMetric(label:'OUT',value:'2',accent:c.statusDanger))])])));}}
class _HealthMetric extends StatelessWidget {final String label,value;final Color accent;const _HealthMetric({required this.label,required this.value,required this.accent});@override Widget build(BuildContext context){final c=Theme.of(context).extension<ZenoSemanticColors>()!;return Container(padding:const EdgeInsets.symmetric(vertical:11,horizontal:8),decoration:BoxDecoration(color:accent.withValues(alpha:.06),borderRadius:BorderRadius.circular(13),border:Border.all(color:accent.withValues(alpha:.16))),child:Column(children:[Text(value,style:TextStyle(fontSize:18,fontWeight:FontWeight.w900,color:accent)),const SizedBox(height:3),Text(label,style:TextStyle(fontSize:7,fontWeight:FontWeight.w900,letterSpacing:.8,color:c.textSecondary))]));}}


class _OperationsSnapshot extends StatelessWidget {final ValueChanged<String> onRoute;const _OperationsSnapshot({required this.onRoute});@override Widget build(BuildContext context){final c=Theme.of(context).extension<ZenoSemanticColors>()!;return Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text('OPERATIONS',style:TextStyle(fontSize:10,fontWeight:FontWeight.w900,letterSpacing:1.5,color:c.textSecondary)),const SizedBox(height:9),Row(children:[Expanded(child:_OpsTile(icon:Icons.pending_actions_rounded,label:'Pending',value:'14',accent:c.amberGold,onTap:()=>onRoute('orders/dashboard'))),const SizedBox(width:9),Expanded(child:_OpsTile(icon:Icons.check_circle_outline_rounded,label:'Completed',value:'96',accent:c.statusSuccess,onTap:()=>onRoute('orders/dashboard'))),const SizedBox(width:9),Expanded(child:_OpsTile(icon:Icons.payments_outlined,label:'Payments',value:'18',accent:c.accentPrimary,onTap:()=>onRoute('finance')))]));}}
class _OpsTile extends StatelessWidget {final IconData icon;final String label,value;final Color accent;final VoidCallback onTap;const _OpsTile({required this.icon,required this.label,required this.value,required this.accent,required this.onTap});@override Widget build(BuildContext context){final c=Theme.of(context).extension<ZenoSemanticColors>()!;return InkWell(onTap:onTap,borderRadius:BorderRadius.circular(16),child:Container(padding:const EdgeInsets.symmetric(vertical:12,horizontal:8),decoration:BoxDecoration(color:c.bgTier2,borderRadius:BorderRadius.circular(16),border:Border.all(color:c.borderSubtle)),child:Column(children:[Icon(icon,size:19,color:accent),const SizedBox(height:7),Text(value,style:TextStyle(fontSize:16,fontWeight:FontWeight.w900,color:c.textPrimary)),const SizedBox(height:2),Text(label,style:TextStyle(fontSize:8,fontWeight:FontWeight.w700,color:c.textSecondary))])));}}

class _CommandGrid extends StatelessWidget {final ValueChanged<String> onRoute;const _CommandGrid({required this.onRoute});@override Widget build(BuildContext context){final c=Theme.of(context).extension<ZenoSemanticColors>()!;final items=[('New Bill',Icons.receipt_long_rounded,'sales/pos',c.accentPrimary),('Products',Icons.inventory_2_outlined,'inventory',c.accentPrimary),('Customers',Icons.people_alt_outlined,'crm',c.statusSuccess),('Deliveries',Icons.local_shipping_outlined,'orders/dashboard',c.amberGold),('Reports',Icons.insights_rounded,'reports',c.accentPrimary),('AI Center',Icons.auto_awesome_rounded,'ai',c.accentPrimary)];return Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text('COMMANDS',style:TextStyle(fontSize:10,fontWeight:FontWeight.w900,letterSpacing:1.5,color:c.textSecondary)),const SizedBox(height:9),GridView.builder(shrinkWrap:true,physics:const NeverScrollableScrollPhysics(),itemCount:items.length,gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:3,crossAxisSpacing:9,mainAxisSpacing:9,childAspectRatio:1.18),itemBuilder:(_,i){final x=items[i];return InkWell(onTap:()=>onRoute(x.$3),borderRadius:BorderRadius.circular(15),child:Container(decoration:BoxDecoration(color:c.bgTier2,borderRadius:BorderRadius.circular(15),border:Border.all(color:c.borderSubtle)),child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[Icon(x.$2,size:22,color:x.$4),const SizedBox(height:7),Text(x.$1,textAlign:TextAlign.center,style:TextStyle(fontSize:9,fontWeight:FontWeight.w800,color:c.textPrimary))])));})]);}}

class _SmartAlerts extends StatelessWidget {final ValueChanged<String> onRoute;const _SmartAlerts({required this.onRoute});@override Widget build(BuildContext context){final c=Theme.of(context).extension<ZenoSemanticColors>()!;final items=[('7 products need restocking','Inventory','inventory',Icons.inventory_2_outlined,c.amberGold),('12 deliveries are active','Delivery','orders/dashboard',Icons.local_shipping_outlined,c.accentPrimary),('3 invoices need attention','Billing','sales/pos',Icons.receipt_long_rounded,c.statusDanger)];return Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children:[Text('SMART ALERTS',style:TextStyle(fontSize:10,fontWeight:FontWeight.w900,letterSpacing:1.5,color:c.textSecondary)),Text('LIVE',style:TextStyle(fontSize:8,fontWeight:FontWeight.w900,color:c.statusSuccess))]),const SizedBox(height:9),...items.map((x)=>Padding(padding:const EdgeInsets.only(bottom:7),child:InkWell(onTap:()=>onRoute(x.$3),borderRadius:BorderRadius.circular(14),child:Container(padding:const EdgeInsets.all(12),decoration:BoxDecoration(color:c.bgTier2,borderRadius:BorderRadius.circular(14),border:Border.all(color:c.borderSubtle)),child:Row(children:[Container(width:34,height:34,decoration:BoxDecoration(color:x.$5.withOpacity(.10),borderRadius:BorderRadius.circular(10)),child:Icon(x.$4,size:18,color:x.$5)),const SizedBox(width:10),Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(x.$1,style:TextStyle(fontSize:11,fontWeight:FontWeight.w800,color:c.textPrimary)),const SizedBox(height:3),Text(x.$2,style:TextStyle(fontSize:9,color:c.textSecondary))])),Icon(Icons.chevron_right_rounded,size:18,color:c.textDisabled)]))))]);}}

class _AiRecommendations extends StatelessWidget {final ValueChanged<String> onRoute;const _AiRecommendations({required this.onRoute});@override Widget build(BuildContext context){final c=Theme.of(context).extension<ZenoSemanticColors>()!;return Container(padding:const EdgeInsets.all(14),decoration:BoxDecoration(gradient:ZenoTheme.aiGlowGradient,borderRadius:BorderRadius.circular(18),border:Border.all(color:c.accentPrimary.withOpacity(.22))),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Row(children:[Icon(Icons.auto_awesome_rounded,size:17,color:c.accentPrimary),const SizedBox(width:7),Text('ZENO AI RECOMMENDATIONS',style:TextStyle(fontSize:10,fontWeight:FontWeight.w900,letterSpacing:1.2,color:c.textPrimary)),const Spacer(),Container(padding:const EdgeInsets.symmetric(horizontal:7,vertical:3),decoration:BoxDecoration(color:c.bgTier1.withOpacity(.65),borderRadius:BorderRadius.circular(20)),child:Text('AI',style:TextStyle(fontSize:8,fontWeight:FontWeight.w900,color:c.accentPrimary)))]),const SizedBox(height:11),_rec(c,'Restock fast-moving products before tomorrow','Inventory','inventory'),const SizedBox(height:7),_rec(c,'Follow up with customers who have pending orders','CRM','crm')]);}Widget _rec(ZenoSemanticColors c,String title,String tag,String route)=>InkWell(onTap:()=>onRoute(route),borderRadius:BorderRadius.circular(12),child:Container(padding:const EdgeInsets.symmetric(horizontal:10,vertical:9),decoration:BoxDecoration(color:c.bgTier1.withOpacity(.55),borderRadius:BorderRadius.circular(12)),child:Row(children:[Expanded(child:Text(title,style:TextStyle(fontSize:10,fontWeight:FontWeight.w700,color:c.textPrimary))),Text(tag,style:TextStyle(fontSize:8,fontWeight:FontWeight.w800,color:c.textSecondary)),const SizedBox(width:4),Icon(Icons.arrow_forward_ios_rounded,size:10,color:c.textDisabled)])));}

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String sub;
  final Color accent;
  final VoidCallback onTap;
  const _ActionCard({required this.icon, required this.label, required this.sub, required this.accent, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).extension<ZenoSemanticColors>()!;
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: c.bgTier2.withValues(alpha: 0.92),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: c.borderSubtle),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(icon, size: 22, color: accent),
          const SizedBox(height: 15),
          Text(label, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1.1, color: c.textPrimary)),
          const SizedBox(height: 3),
          Text(sub, style: TextStyle(fontSize: 9, color: c.textSecondary)),
        ]),
      ),
    );
  }
}

class _WorkspaceTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color accent;
  final VoidCallback onTap;
  const _WorkspaceTile({required this.icon, required this.title, required this.subtitle, required this.accent, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).extension<ZenoSemanticColors>()!;
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: InkWell(
        borderRadius: BorderRadius.circular(17),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(
            color: c.bgTier2.withValues(alpha: 0.84),
            borderRadius: BorderRadius.circular(17),
            border: Border.all(color: c.borderSubtle),
          ),
          child: Row(children: [
            Container(
              width: 42, height: 42,
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(13),
                border: Border.all(color: accent.withValues(alpha: 0.22)),
              ),
              child: Icon(icon, size: 20, color: accent),
            ),
            const SizedBox(width: 12),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: c.textPrimary)),
                const SizedBox(height: 3),
                Text(subtitle, style: TextStyle(fontSize: 9, color: c.textSecondary)),
              ],
            )),
            Icon(Icons.chevron_right_rounded, size: 19, color: c.textSecondary),
          ]),
        ),
      ),
    );
  }
}

class _HeaderButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final ZenoSemanticColors colors;
  const _HeaderButton({required this.icon, required this.onTap, required this.colors});

  @override
  Widget build(BuildContext context) => IconButton(
    onPressed: onTap,
    icon: Container(
      width: 38, height: 38,
      decoration: BoxDecoration(
        color: colors.bgTier2,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.borderSubtle),
      ),
      child: Icon(icon, size: 19, color: colors.textPrimary),
    ),
  );
}

class _AuroraBackground extends StatelessWidget {
  const _AuroraBackground();

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).extension<ZenoSemanticColors>()!;
    return IgnorePointer(
      child: Stack(children: [
        Positioned(top: -110, right: -90, child: _GlowOrb(color: c.accentPrimary, size: 250)),
        Positioned(top: 250, left: -150, child: _GlowOrb(color: c.accentPurple, size: 300)),
      ]),
    );
  }
}

class _GlowOrb extends StatelessWidget {
  final Color color;
  final double size;
  const _GlowOrb({required this.color, required this.size});

  @override
  Widget build(BuildContext context) => Container(
    width: size, height: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: RadialGradient(colors: [color.withValues(alpha: 0.10), Colors.transparent]),
    ),
  );
}

class _MobileMenuGroup extends StatelessWidget {
  final ZenoMenuCategory category;
  final String currentRoute;
  final ValueChanged<String> onRoute;
  final ZenoSemanticColors colors;

  const _MobileMenuGroup({required this.category, required this.currentRoute, required this.onRoute, required this.colors});

  @override
  Widget build(BuildContext context) {
    final items = category.columns.expand((column) => column.items).where((item) => item.route != null).toList();
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        leading: Icon(category.icon, color: category.color, size: 20),
        title: Text(category.label, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: colors.textPrimary)),
        iconColor: colors.accentPrimary,
        collapsedIconColor: colors.textSecondary,
        tilePadding: const EdgeInsets.symmetric(horizontal: 18),
        childrenPadding: const EdgeInsets.only(left: 14, right: 10, bottom: 4),
        children: [
          for (final item in items)
            ListTile(
              dense: true,
              visualDensity: const VisualDensity(vertical: -1),
              leading: Icon(item.icon, size: 17, color: item.color ?? category.color),
              title: Text(item.label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: colors.textPrimary)),
              trailing: currentRoute == item.route ? Icon(Icons.check_rounded, size: 16, color: colors.accentPrimary) : null,
              onTap: () {
                Navigator.of(context).pop();
                onRoute(item.route!);
              },
            ),
        ],
      ),
    );
  }
}

class _ZenoMobileSearchDelegate extends SearchDelegate<String> {
  final ValueChanged<String> onSelect;
  _ZenoMobileSearchDelegate({required this.onSelect});

  List<ZenoMenuItem> get _items => MenuRegistry.all
      .expand((category) => category.columns)
      .expand((column) => column.items)
      .where((item) => item.route != null)
      .toList();

  @override
  List<Widget>? buildActions(BuildContext context) => [
    if (query.isNotEmpty) IconButton(icon: const Icon(Icons.clear_rounded), onPressed: () => query = ''),
  ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
    icon: const Icon(Icons.arrow_back_rounded),
    onPressed: () => close(context, ''),
  );

  @override
  Widget buildResults(BuildContext context) => _results(context);

  @override
  Widget buildSuggestions(BuildContext context) => _results(context);

  Widget _results(BuildContext context) {
    final q = query.trim().toLowerCase();
    final results = _items.where((item) => q.isEmpty || item.label.toLowerCase().contains(q)).take(30).toList();
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final item = results[index];
        return ListTile(
          leading: Icon(item.icon),
          title: Text(item.label),
          onTap: () {
            close(context, item.route!);
            onSelect(item.route!);
          },
        );
      },
    );
  }
}
