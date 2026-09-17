part of '../isar_customer_repository.dart';

extension IsarCustomerRepositoryCorePart on IsarCustomerRepository {
  Future<List<Customer>> getAllCustomersImpl() async {
    final results = await custCol.filter().isDeletedEqualTo(false).findAll();
    return results.map((e) => _mapToDomain(e)).toList();
  }

  Future<Customer?> getCustomerByIdImpl(String id) async {
    final e = await custCol.filter().uuidEqualTo(id).findFirst();
    return e != null ? _mapToDomain(e) : null;
  }

  Future<List<Customer>> searchCustomersImpl(String query) async {
    final results = await custCol
        .filter()
        .nameContains(query, caseSensitive: false)
        .or()
        .customerCodeContains(query, caseSensitive: false)
        .or()
        .phoneContains(query)
        .findAll();
    return results.map((e) => _mapToDomain(e)).toList();
  }

  Future<List<Customer>> getDeletedCustomersImpl() async {
    final results = await custCol.filter().isDeletedEqualTo(true).findAll();
    return results.map((e) => _mapToDomain(e)).toList();
  }

  Future<void> saveCustomerImpl(Customer customer) async {
    final existing =
        await custCol.filter().uuidEqualTo(customer.id).findFirst();
    final c = (existing ?? CustomerCollection())
      ..uuid = customer.id
      ..customerCode = customer.customerCode
      ..type = customer.type.name
      ..name = customer.name
      ..companyName = customer.companyName
      ..taxId = customer.taxId
      ..email = customer.email
      ..phone = customer.phone
      ..whatsapp = customer.whatsapp
      ..tier = customer.tier.name
      ..categoryId = customer.categoryId
      ..segmentId = customer.segmentId
      ..territoryId = customer.territoryId
      ..salesRepId = customer.salesRepId
      ..groupIds = customer.groupIds
      ..outstandingBalance = customer.credit.currentBalance
      ..creditLimit = customer.credit.creditLimit
      ..isCreditBlocked = customer.credit.isBlocked
      ..loyaltyPoints = customer.loyalty.points.toInt()
      ..lifetimeSpent = customer.loyalty.totalSpent
      ..tags = customer.tags
      ..branchId = customer.branchId
      ..companyId = customer.companyId
      ..lastPurchaseAt = customer.lastPurchaseAt
      ..updatedAt = DateTime.now();

    c.addresses = customer.addresses
        .map((a) => CustomerAddressEmbedded()
          ..uuid = a.id
          ..label = a.label
          ..addressLine1 = a.addressLine1
          ..addressLine2 = a.addressLine2
          ..city = a.city
          ..state = a.state
          ..zipCode = a.zipCode
          ..country = a.country
          ..type = a.type.name
          ..isDefault = a.isDefault)
        .toList();

    c.contacts = customer.contacts
        .map((con) => CustomerContactEmbedded()
          ..uuid = con.id
          ..name = con.name
          ..role = con.role ?? ''
          ..email = con.email
          ..phone = con.phone
          ..isPrimary = con.isPrimary)
        .toList();

    await db.isar.writeTxn(() async {
      await custCol.put(c);
    });
  }

  Future<void> updateTierImpl(String id, CustomerTier tier) async {
    final existing = await custCol.filter().uuidEqualTo(id).findFirst();
    if (existing != null) {
      existing.tier = tier.name;
      await db.isar.writeTxn(() async {
        await custCol.put(existing);
      });
    }
  }

  Future<void> deleteCustomerImpl(String id) async {
    final existing = await custCol.filter().uuidEqualTo(id).findFirst();
    if (existing != null) {
      existing.isDeleted = true;
      await db.isar.writeTxn(() async {
        await custCol.put(existing);
      });
    }
  }

  Future<void> restoreCustomerImpl(String id) async {
    final existing = await custCol.filter().uuidEqualTo(id).findFirst();
    if (existing != null) {
      existing.isDeleted = false;
      await db.isar.writeTxn(() async {
        await custCol.put(existing);
      });
    }
  }

  Future<List<CustomerInteraction>> getInteractionsImpl(String customerId) async {
    final results =
        await interactCol.filter().customerIdEqualTo(customerId).findAll();
    return results
        .map((e) => CustomerInteraction(
              id: e.uuid,
              customerId: e.customerId,
              type: InteractionType.values.firstWhere((t) => t.name == e.type,
                  orElse: () => InteractionType.note),
              summary: e.summary,
              details: e.details,
              timestamp: e.timestamp,
              userId: e.userId,
            ))
        .toList();
  }

  Future<void> logInteractionImpl(CustomerInteraction interaction) async {
    final i = CustomerInteractionCollection()
      ..uuid = interaction.id
      ..customerId = interaction.customerId
      ..type = interaction.type.name
      ..summary = interaction.summary
      ..details = interaction.details
      ..timestamp = interaction.timestamp
      ..userId = interaction.userId;
    await db.isar.writeTxn(() async {
      await interactCol.put(i);
    });
  }

  Future<List<CustomerCategory>> getCategoriesImpl() async {
    final results = await catCol.where().findAll();
    return results
        .map((e) => CustomerCategory(id: e.uuid, code: e.code, name: e.name))
        .toList();
  }

  Future<void> saveCategoryImpl(CustomerCategory category) async {
    final c = CustomerCategoryCollection()
      ..uuid = category.id
      ..code = category.code
      ..name = category.name;
    await db.isar.writeTxn(() async {
      await catCol.put(c);
    });
  }

  Future<List<CustomerGroup>> getCustomerGroupsImpl() async {
    final results = await groupCol.where().findAll();
    return results
        .map((e) => CustomerGroup(
            id: e.uuid, name: e.name, parentId: e.parentId, color: e.color))
        .toList();
  }

  Future<void> saveCustomerGroupImpl(CustomerGroup group) async {
    final g = CustomerGroupCollection()
      ..uuid = group.id
      ..name = group.name
      ..parentId = group.parentId
      ..color = group.color;
    await db.isar.writeTxn(() async {
      await groupCol.put(g);
    });
  }

  Future<List<SalesTerritory>> getTerritoriesImpl() async {
    final results = await terrCol.where().findAll();
    return results
        .map((e) => SalesTerritory(
            id: e.uuid,
            code: e.code,
            name: e.name,
            region: e.region,
            parentId: e.parentId))
        .toList();
  }

  Future<void> saveTerritoryImpl(SalesTerritory territory) async {
    final t = SalesTerritoryCollection()
      ..uuid = territory.id
      ..code = territory.code
      ..name = territory.name
      ..region = territory.region
      ..parentId = territory.parentId;
    await db.isar.writeTxn(() async {
      await terrCol.put(t);
    });
  }

  Customer _mapToDomain(CustomerCollection e) {
    return Customer(
      id: e.uuid,
      customerCode: e.customerCode,
      type: CustomerType.values.firstWhere((t) => t.name == e.type,
          orElse: () => CustomerType.individual),
      name: e.name,
      companyName: e.companyName,
      taxId: e.taxId,
      email: e.email,
      phone: e.phone,
      whatsapp: e.whatsapp,
      tier: CustomerTier.values.firstWhere((t) => t.name == e.tier,
          orElse: () => CustomerTier.standard),
      categoryId: e.categoryId,
      segmentId: e.segmentId,
      territoryId: e.territoryId,
      salesRepId: e.salesRepId,
      groupIds: e.groupIds,
      addresses: e.addresses
              ?.map((a) => CustomerAddress(
                    id: a.uuid,
                    label: a.label,
                    addressLine1: a.addressLine1,
                    addressLine2: a.addressLine2,
                    city: a.city,
                    state: a.state,
                    zipCode: a.zipCode,
                    country: a.country,
                    type: AddressType.values.firstWhere((t) => t.name == a.type,
                        orElse: () => AddressType.billing),
                    isDefault: a.isDefault,
                  ))
              .toList() ??
          [],
      contacts: e.contacts
              ?.map((c) => CustomerContact(
                    id: c.uuid,
                    name: c.name,
                    role: c.role,
                    email: c.email,
                    phone: c.phone,
                    isPrimary: c.isPrimary,
                  ))
              .toList() ??
          [],
      credit: CustomerCredit(
        currentBalance: e.outstandingBalance,
        creditLimit: e.creditLimit,
        isBlocked: e.isCreditBlocked,
      ),
      loyalty: CustomerLoyalty(
        points: e.loyaltyPoints.toDouble(),
        totalSpent: e.lifetimeSpent,
      ),
      createdAt: e.createdAt,
      updatedAt: e.updatedAt,
      lastPurchaseAt: e.lastPurchaseAt,
    );
  }
}
