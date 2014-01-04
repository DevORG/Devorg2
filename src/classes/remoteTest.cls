global class remoteTest {
@RemoteAction
global static Contact[] findContacts(string Name) {
Name = '%'+Name+'%';
Contact[] c = [SELECT ID, Name, Phone, Email from Contact where NAME LIKE :Name ];
return c;
}
}