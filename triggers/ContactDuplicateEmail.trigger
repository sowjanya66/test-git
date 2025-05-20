trigger ContactDuplicateEmail on Contact (before insert, before update) {

    Map<String, Contact> emailToContactMap = new Map<String, Contact>();
    Map<String, Integer> emailToContactCount = new Map<String, Integer>();
    // Check if the email field is populated
    for (Contact contact : Trigger.new) {
        if (contact.Email != null) {
            // Query for existing contacts with the same email
         emailToContactMap.put(contact.Email, contact);
         emailToContactCount.put(contact.Email, emailToContactCount.get(contact.Email) == null ? 1 : emailToContactCount.get(contact.Email) + 1);
        }
    }

    if(emailToContactCount.size() > 0) {
        // Query for existing contacts with the same email
 // Query for existing contacts with the same email
        // Check for duplicates in the trigger context
        for (Contact contact : Trigger.new) {
            if (contact.Email != null && emailToContactCount.get(contact.Email) > 1) {
                contact.addError('New Duplicate Email. Please enter a unique email address.');
            }
        }
    }
    

if(!emailToContactMap.isEmpty()){
       List<Contact> existingContacts = [SELECT Id , email FROM Contact WHERE Email IN  :emailToContactMap.keySet()];
            if (!existingContacts.isEmpty()) {
                // Add an error to the email field if a duplicate is found
                for(Contact existingContact : existingContacts) {
                 if(emailToContactMap.containsKey(existingContact.email)) {
                 emailToContactMap.get(existingContact.email).addError('Email Duplicate');
                   // Add an error to the email field of the new contact')
         
                   // Add an error to the email field of the new contact
                }
            }
        }
}
}