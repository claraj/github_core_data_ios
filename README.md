#  Hello Core Data & JSON

Getting data from an API and decoding it into Core Data entity 

Uses GitHub's public API. Doesn't bother to decode all of the fields. 

Setup steps, for a similar project 

- Create the Entity with whatever attributes needed
- In the xcdatamodeld,  Editor menu > Create NSManagedObjectSubclass 
- In thre xcdatamodeld, select the Entity.  Select the Data Model Inspector, change Codegen to Manual/None

Note that this entity has a constraint on the name attribute so names must be unique. 
