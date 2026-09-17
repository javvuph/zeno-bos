part of '../isar_finance_repository.dart';

extension IsarFinanceRepositoryPayablesBankPart on IsarFinanceRepository {
  Future<List<AccountsPayable>> getAccountsPayableImpl() async {
    final results = await payableCol.where().findAll();
    return results
        .map((e) => AccountsPayable(
              id: e.uuid,
              supplierId: e.supplierId,
              vendorBillId: e.vendorBillId,
              invoiceNumber: e.invoiceNumber,
              amount: e.amount,
              dueDate: e.dueDate,
              status: PaymentStatus.values.firstWhere((s) => s.name == e.status,
                  orElse: () => PaymentStatus.pending),
            ))
        .toList();
  }

  Future<void> saveAccountsPayableImpl(AccountsPayable payable) async {
    final existing =
        await payableCol.filter().uuidEqualTo(payable.id).findFirst();
    final entry = (existing ?? AccountsPayableCollection())
      ..uuid = payable.id
      ..supplierId = payable.supplierId
      ..vendorBillId = payable.vendorBillId
      ..invoiceNumber = payable.invoiceNumber
      ..amount = payable.amount
      ..dueDate = payable.dueDate
      ..status = payable.status.name;

    await db.isar.writeTxn(() async {
      await payableCol.put(entry);
    });
  }

  Future<List<Payment>> getPaymentsImpl() async {
    final results = await paymentCol.where().findAll();
    return results
        .map((e) => Payment(
              id: e.uuid,
              payableId: e.payableId,
              supplierId: '', // Mocked
              amount: e.amount,
              currency: 'USD',
              method: PaymentMethod.values.firstWhere((m) => m.name == e.method,
                  orElse: () => PaymentMethod.bankTransfer),
              paymentDate: e.paymentDate,
            ))
        .toList();
  }

  Future<void> savePaymentImpl(Payment payment) async {
    final entry =
        (await paymentCol.filter().uuidEqualTo(payment.id).findFirst()) ??
            PaymentCollection();
    entry.uuid = payment.id;
    entry.payableId = payment.payableId;
    entry.amount = payment.amount;
    entry.paymentDate = payment.paymentDate;
    entry.method = payment.method.name;

    await db.isar.writeTxn(() async {
      await paymentCol.put(entry);
    });
  }

  Future<List<BankAccount>> getBankAccountsImpl() async {
    final results = await bankAccCol.where().findAll();
    return results
        .map((e) => BankAccount(
              id: e.uuid,
              name: e.name,
              accountNumber: e.accountNumber,
              bankName: e.bankName,
              branchName: e.branchName,
              type: BankAccountType.values.firstWhere((t) => t.name == e.type,
                  orElse: () => BankAccountType.current),
              currency: e.currency,
              currentBalance: e.currentBalance,
              availableBalance: e.availableBalance,
              isActive: e.isActive,
              swiftCode: e.swiftCode,
              ifscCode: e.ifscCode,
            ))
        .toList();
  }

  Future<void> saveBankAccountImpl(BankAccount account) async {
    final existing =
        await bankAccCol.filter().uuidEqualTo(account.id).findFirst();
    final a = (existing ?? BankAccountCollection())
      ..uuid = account.id
      ..name = account.name
      ..accountNumber = account.accountNumber
      ..bankName = account.bankName
      ..branchName = account.branchName
      ..type = account.type.name
      ..currency = account.currency
      ..currentBalance = account.currentBalance
      ..availableBalance = account.availableBalance
      ..isActive = account.isActive
      ..swiftCode = account.swiftCode
      ..ifscCode = account.ifscCode;

    await db.isar.writeTxn(() async {
      await bankAccCol.put(a);
    });
  }

  Future<List<BankTransaction>> getBankTransactionsImpl(String accountId) async {
    final results =
        await bankTxCol.filter().bankAccountIdEqualTo(accountId).findAll();
    return results
        .map((e) => BankTransaction(
              id: e.uuid,
              bankAccountId: e.bankAccountId,
              date: e.date,
              description: e.description,
              amount: e.amount,
              type: BankTransactionType.values.firstWhere(
                  (t) => t.name == e.type,
                  orElse: () => BankTransactionType.deposit),
              status: BankTransactionStatus.values.firstWhere(
                  (s) => s.name == e.status,
                  orElse: () => BankTransactionStatus.cleared),
              referenceNumber: e.referenceNumber,
              counterPartyName: e.counterPartyName,
            ))
        .toList();
  }

  Future<void> recordBankTransactionImpl(BankTransaction transaction) async {
    final existing =
        await bankTxCol.filter().uuidEqualTo(transaction.id).findFirst();
    final tx = (existing ?? BankTransactionCollection())
      ..uuid = transaction.id
      ..bankAccountId = transaction.bankAccountId
      ..date = transaction.date
      ..description = transaction.description
      ..amount = transaction.amount
      ..type = transaction.type.name
      ..status = transaction.status.name
      ..referenceNumber = transaction.referenceNumber
      ..counterPartyName = transaction.counterPartyName;

    await db.isar.writeTxn(() async {
      await bankTxCol.put(tx);
    });
  }
}
