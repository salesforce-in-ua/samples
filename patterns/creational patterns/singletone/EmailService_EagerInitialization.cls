public class EmailService {
    private final static EmailService instance = new EmailService();
    private static Map<Id, User> admins;

    private EmailService(){
        admins = new Map<ID, User>([
            SELECT Id
            FROM User
            WHERE Profile.Name = 'System Administrator'
        ]);
    }

    public static EmailService getInstance(){
        return instance;
    }

    public void sendNotificationToAdmins(String subject, String emailBody){
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.toAddresses = new List<Id>(admins.keySet());
        message.subject = subject;
        message.plainTextBody = emailBody;
        Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage> {message};
        Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
        if (results[0].success) {
            System.debug('The email was sent successfully.');
        } else {
            System.debug('The email failed to send: '
                + results[0].errors[0].message);
        } 
    }
}
