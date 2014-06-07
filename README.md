Time-Tracker
============

An iOS app with time tracking

###Step 1: Create the list view controller
- Either in Pomodoro or in a new app create a new list view controller
- Add it to the tab, or to the window's rootViewController inside of a navigation controller

###Step 2: Setting up a tableViewDatasource
- Create a new datasource object (ListTableViewDatasource subclass of NSObject)
- Add the tableViewDatasource protocol required methods 
- Add a datasource property to your list viewcontroller (strong)
- Initialize the datasource in the init method
- Add a tableview property to list viewcontroller
- Initialize the tableview and add it to the viewcontroller's view
- Set the datasource to your datasource property

