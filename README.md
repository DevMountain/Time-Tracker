Time-Tracker
============

An iOS app with time tracking

###Step 1: Create the list view controller
- Either in Pomodoro or in a new app create a new ```ListViewController``` (list of ```Project``` instances)
- Add it to the window's ```rootViewController``` inside of a navigation controller

###Step 2: Setting up a tableViewDatasource
- Create a new datasource object (```ListTableViewDatasource``` subclass of NSObject)
- Add the UITableViewDatasource protocol required methods
- Add a ```dataSource``` property to your list viewcontroller (strong)
- Initialize the ```dataSource``` in the init method
- Add a ```tableView``` property to ```ListViewController```
- Initialize the ```tableView``` and add it to the viewcontroller's view
- Set the datasource of ```tableView``` to your ```dataSource``` property

###Step 3: Create a model and model controller
*See "Entries" for a sample project*
- Create a ```Project``` class with necessary properties
  - Each ```Project``` instance should hold an array of ```Entries``
  - You'll need an ```AddEntry:``` and ```RemoveEntry:``` method
- Create an ```Entry``` (work period) class with necessary properties
- Create a ```ProjectController``` singleton class (add the instancetype method)
  - The ```ProjectController``` should hold an array of ```Project``` instances
  - You'll need an ```AddProject:``` and ```RemoveProject:``` method

- You'll need methods that convert the objects (```Project``` and ```Entry```) to and from dictionaries
    - (This allows you to store the model in NSUserDefaults)
    - Don't forget to implement storing of ```Projects``` to NSUserDefaults (loadFromDefaults, syncronize)
      -*Look back at "Day-X" for example*
- Now you can use the ```ProjectController``` for the row count and row value for the ```tableView```
  - Use the ```title``` Property of Project for the cell label

###Step 4: Add a ```DetailViewController``` (```Project``` instance detail)
- Create a ```DetailViewController``` with an XIB file
- Add a ```titleTextField``` for the title
- Add a ```timeLabel``` to show the total time
- Add a ```tableView``` to show the list of ```Entries```
- Add a UIToolBar with an Add, Check In, Check Out, and Report button
- Add those objects as properties on the view
  - Wire them up
- Add a method for each button
  - Add
  - Clock In
  - Clock Out
  - Report

###Step 5: Add UITextFieldDelegate methods to capture the title
- Add the textFieldShould return method to dismiss the Keyboard
- Add a textFieldShouldEndEditing method to store the text of the ```titleTextField``` as the ```project.title```
- Wire files owner as the delegate of the text field in the XIB file

###Step 6: Add a datasource for the tableview
- Create a new datasource object (```DetailTableViewDatasource``` subclass of NSObject)
- Add the UITableViewDataSource protocol required methods
- Add a ```dataSource``` property to your ```DetailViewController``` (strong)
- Initialize the ```dataSource``` in the init method
- Set the ```self.tableView.dataSource``` to your ```dataSource``` property

###Step 7: Show a list of entries
- Add a public ```Project``` property to the ```DetailViewController```
- In the didSelectRow method in the ```ListViewController``` set the ```DetailViewController```'s ```Project``` property as the ```project``` in the ```ProjectController```'s project list at the index selected
- Add a public ```Project``` property to the ```DetailTableViewDatasource```
- In the viewDidLoad method of the ```DetailViewController``` set the ```dataSource```'s ```project``` property to ```self.property```
- NumberOfRows should be equal to number of entries
- Set the cell's ```textLabel.text``` to the ```entry```'s start and end date
  - Feel free to format them if you'd like it to look pretty: [http://gtiapps.com/?p=1086](http://gtiapps.com/?p=1086)

###Step 8: Add a Clock In and Clock Out method to the ```Project``` object
- Add a method ```startNewEntry```
  - In that method create a new ```Entry```, and set the start time to now
  - Store that entry as a ```currentEntry``` private property of ```Project```
- Add a method ```endCurrentEntry```
  - In that method set the end time of ```currentEntry``` to now
- Call those methods when the user selects clockIn or clockOut BarButtonItems on your UIToolBar
  - Be sure to reload the ```tableView```'s data

###Step 9: Create a custom entry screen
- Create a new ```CustomEntryViewController``` with an XIB file
- Add a public ```Project``` property to your ```CustomEntryViewController```
- Add a *fake* navigation bar 
  - Add a cancel and save button and a title
- Wire up the cancel and save buttons to IBActions ```cancel``` and ```save```
- Add date pickers and title labels
  - Add two date pickers and wire them up to ```startDatePicker``` and ```endDatePicker``` IBOutlet properties
  - Add two labels ```startDateLabel``` and ```endDateLabel``` above the pickers to show which is which (they don't need to be wired)
- In the ```save``` method create a new ```Entry``` and set the start and end times from the picker views
- In both the ```save``` and ```cancel``` method call "dismissViewController"
- In the add method of the ```DetailViewController```, instantiate a ```CustomEntryViewController```, set the ```project``` property, and call "presentViewController" to show it

###Step 10: Add reporting
- Add the MessageUI library to your project
- In the report method, instantiate an MFMailComposeViewController 
- Create a string of all of the entry times (loop through the ```entries``` and append the times to the string)
- Set the message string as the messageBody of the viewController
- Call presentViewController on the mailComposeViewController
