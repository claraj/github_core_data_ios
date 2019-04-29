#  Hello Core Data & JSON

Getting data from an API and decoding it into Core Data entity 

Uses GitHub's public API. Doesn't bother to decode all of the fields. 

Setup steps, for a similar project 

- Create the Entity with whatever attributes needed
- In the xcdatamodeld,  Editor menu > Create NSManagedObjectSubclass 
- In the xcdatamodeld, select the Entity.  Select the Data Model Inspector, change Codegen to Manual/None

See the UserEntity+CoreDataClass.swift file. 

### Notes unrelated to the decoding JSON into Core Data enties 

Uses a NSManagedResultsController. 
Note that this entity has a constraint on the login attribute so names must be unique. 
But, with NSManagedResultsController there may be an in-memory and persistent store version of objects, and if an object is created but then when it's saved, there's a constraint validation - which object wins? By default, the in-memory version  
See comment in AppDelegate.swift didFinishLaunchingWithOptions for the fix. 

