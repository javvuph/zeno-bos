part of '../isar_finance_repository.dart';

extension IsarFinanceRepositoryLedgerPart on IsarFinanceRepository {
  Future<List<Account>> getChartOfAccountsImpl() async {
    final results = await accCol.where().findAll();
    return results
        .map((e) => Account(
              id: e.uuid,
              code: e.code,
              name: e.name,
              category: AccountCategory.values.firstWhere(
                  (c) => c.name == e.category,
                  orElse: () => AccountCategory.asset),
              type: AccountType.values.firstWhere((t) => t.name == e.type,
                  orElse: () => AccountType.cash),
              parentId: e.parentId,
              currency: e.currency,
              isActive: e.isActive,
              isSystemAccount: e.isSystemAccount,
              currentBalance: e.currentBalance,
            ))
        .toList();
  }

  Future<void> saveAccountImpl(Account account) async {
    final existing = await accCol.filter().uuidEqualTo(account.id).findFirst();
    final a = (existing ?? AccountCollection())
      ..uuid = account.id
      ..code = account.code
      ..name = account.name
      ..category = account.category.name
      ..type = account.type.name
      ..currency = account.currency
      ..parentId = account.parentId
      ..isActive = account.isActive
      ..isSystemAccount = account.isSystemAccount;

    await db.isar.writeTxn(() async {
      await accCol.put(a);
    });
  }

  Future<void> postJournalEntryImpl(JournalEntry entry) async {
    final j = JournalEntryCollection()
      ..uuid = entry.id
      ..referenceNumber = entry.referenceNumber
      ..date = entry.date
      ..description = entry.description
      ..status = entry.status.name
      ..sourceModule = entry.sourceModule
      ..sourceDocumentId = entry.sourceDocumentId
      ..lines = entry.lines
          .map((l) => JournalLineEmbedded()
            ..accountId = l.accountId
            ..debit = l.debit
            ..credit = l.credit
            ..memo = l.memo)
          .toList();

    await db.isar.writeTxn(() async {
      await journalCol.put(j);

      // Update account balances
      for (var line in entry.lines) {
        final acc =
            await accCol.filter().uuidEqualTo(line.accountId).findFirst();
        if (acc != null) {
          acc.currentBalance += (line.debit - line.credit);
          await accCol.put(acc);
        }
      }
    });
  }

  Future<List<JournalEntry>> getLedgerEntriesImpl(
      String accountId, DateTime start, DateTime end) async {
    final results = await journalCol
        .filter()
        .dateBetween(start, end)
        .and()
        .linesElement((q) => q.accountIdEqualTo(accountId))
        .findAll();

    return results
        .map((e) => JournalEntry(
              id: e.uuid,
              referenceNumber: e.referenceNumber,
              date: e.date,
              description: e.description,
              createdById: 'admin',
              sourceModule: e.sourceModule,
              sourceDocumentId: e.sourceDocumentId,
              status: JournalEntryStatus.values.firstWhere(
                  (s) => s.name == e.status,
                  orElse: () => JournalEntryStatus.posted),
              lines: e.lines
                      ?.map((l) => JournalLine(
                            accountId: l.accountId,
                            debit: l.debit,
                            credit: l.credit,
                            memo: l.memo,
                          ))
                      .toList() ??
                  [],
            ))
        .toList();
  }

  Future<List<JournalEntry>> getAllJournalEntriesImpl() async {
    final results = await journalCol.where().findAll();
    return results
        .map((e) => JournalEntry(
              id: e.uuid,
              referenceNumber: e.referenceNumber,
              date: e.date,
              description: e.description,
              createdById: 'admin',
              sourceModule: e.sourceModule,
              sourceDocumentId: e.sourceDocumentId,
              status: JournalEntryStatus.values.firstWhere(
                  (s) => s.name == e.status,
                  orElse: () => JournalEntryStatus.posted),
              lines: e.lines
                      ?.map((l) => JournalLine(
                            accountId: l.accountId,
                            debit: l.debit,
                            credit: l.credit,
                            memo: l.memo,
                          ))
                      .toList() ??
                  [],
            ))
        .toList();
  }

  Future<List<FiscalPeriod>> getFiscalPeriodsImpl() async {
    final results = await periodCol.where().findAll();
    return results
        .map((e) => FiscalPeriod(
              id: e.uuid,
              name: e.name,
              startDate: e.startDate,
              endDate: e.endDate,
              status: FiscalPeriodStatus.values.firstWhere(
                  (s) => s.name == e.status,
                  orElse: () => FiscalPeriodStatus.open),
              isAdjustmentPeriod: e.isAdjustmentPeriod,
            ))
        .toList();
  }

  Future<void> updatePeriodStatusImpl(
      String periodId, FiscalPeriodStatus status) async {
    final existing = await periodCol.filter().uuidEqualTo(periodId).findFirst();
    if (existing != null) {
      existing.status = status.name;
      await db.isar.writeTxn(() async {
        await periodCol.put(existing);
      });
    }
  }

  Future<double> getAccountBalanceImpl(String accountId) async {
    final acc = await accCol.filter().uuidEqualTo(accountId).findFirst();
    return acc?.currentBalance ?? 0.0;
  }
}
