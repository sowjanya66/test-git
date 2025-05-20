trigger AccountNameTrigger on Account (before insert, before update) {
    Map<String, Account> accountMap = new Map<String, Account>();
    System.debug('TRigger size'+ Trigger.new.size());
    for (Account ac : Trigger.new) {
        if (ac.Name != null) {
            accountMap.put(ac.Name, ac);
        }
    }
    
    if (!accountMap.isEmpty()) {
        List<Account> existingAccounts = [SELECT Id, Name FROM Account WHERE Name IN :accountMap.keySet()];
        
        for (Account existingAcc : existingAccounts) {
            Account newAcc = accountMap.get(existingAcc.Name);
            if (newAcc != null && newAcc.Id != existingAcc.Id) {
                newAcc.Name.addError('Duplicate Account Name. Please enter a unique name.');
            }
        }
    }
}