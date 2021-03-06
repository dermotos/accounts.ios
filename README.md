## Accounts

*Author* : Dermot O'Sullivan

*Date* :  21-Jan-2018

## Notes

### Structure

This project was built using a MVVM design pattern. The majority of the logic of the application is contained in the View Models and the classes that support them. This is then shared across the various targets including iPhone/iPad, Watch OS and the Today Extension.

### AccountKit

This is the main framework which handles loading the accounts from JSON, creating view models, and providing that data to ViewControllers on iPhone, iPad, Today Extension, and WatchOS interfaces.

In a real world application, the functionality contained within this framework would most likely be separated across multiple frameworks. There are multiple unit tests supporting the functionality of this framework, however they are non-exhaustive due to time considerations, given that this project is an example of work.



