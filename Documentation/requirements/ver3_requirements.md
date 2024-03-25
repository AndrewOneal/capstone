# Version 3 Requirements

## Front End

* Epic: As a wiki user, I want to have an easily navigable set of pages to view and navigate the wiki, so that I can explore the information about the series, parts, and characters available in this application.
  * User Story: As a wiki reader, I want to be able to navigate all available wikis in an alphabetical list, so that I can easily find the wiki that I want to access.
  * User Story: As a wiki viewer, I want to have a page that displays the current wiki I have navigated to with buttons to go to either the episodes or the characters list, so that I can easily tell what wiki I am on and be able to navigate to its contents.
  * User Story: As a wiki viewer, I want to have a page that displays the list of parts (episodes/chapters) in the current wiki that will direct me to the part page when clicked, so that I can navigate through the list of episodes and choose the one I want to read more about.
  * User Story: As a wiki viewer, I want to have a page for the specific part I am interested in that displays a summary of the part, so that I can be informed about the episode I am viewing.
  * User Story: As a wiki viewer, I want to have a page that displays an alphabetized list of characters for the current wiki that lead to their respective character pages when clicked, so that I can easily navigate the characters of the current wiki.
  * User Story: As a wiki viewer, I want to have a page for each character in the current wiki that displays a short summary of what happens to them in each part, so that I can stay up to date with what is going on with my favorite character.
  * User Story: As a wiki viewer, I want to have a settings button on each wiki to input what part I am at in the show, so that my settings can be saved for when I browse the wiki.
    
* Epic: As a wiki user, I want to have authentication pages, so that I can login or create an account.
  * User Story: As a wiki user, I want to have a login page to login to the app with a button to be redirected to a register page, so that I can either log in or navigate to the page that allows me to create an account.
  * User Story: As a wiki user, I want to have a register page to register an account with a button to be redirected to the login page, so that I can create my account or naviage to the page that allows me to login.

* Epic: As a wiki user, I want to have buttons and pages to be able to create a new wiki, so that when the wiki I want does not exist, I can create it.
  * User Story: As a wiki creator, I want to have a persistent add button on the wiki list, so that when the wiki I want does not exist, I can easily go to the form to create one.
  * User Story: As a wiki creator, I want to have a "Create a Wiki" form page to create a new wiki, so that I can input a title, section names, number of sections, number of characters, and a description of series for the wiki I am creating.
    
* Epic: As a wiki user, I want to be able to edit the information in a wiki, so that I can correct missing or incorrect information.
  * User Story: As a wiki editor, I want to have a persistent add button on the parts list and part pages, so that I can add missing parts anywhere in the parts section of the application.
  * User Story: As a wiki editor, I want to have a persistent edit button to edit the list of characters, so that when I notice something is out of place or missing, I can fix it.
  * User Story: As a wiki editor, I want to have a persistent edit button on the character page to edit the part sections of the character, so that when I notice something is out of place or missing, I can fix it.

## Back End

* Epic: As a wiki user, I want to be able to create data so that I can contribute to the wikis and create my account, so that I can use all the features of the application.
  * User Story: As a wiki user, I want to have a database function to register my account, so that my account can be properly created and saved in the database.
  * User Story: As a wiki user, I want to have a database function to create new wiki, character details, and part summaries, so that my added content can be properly created and stored in the database.

* Epic: As a wiki user, I want to be able to update data in the database so that I can change my password, toggle administrator privileges, and edit data within the application, so that I can use all the features of the application.
  * User Story: As an admin, I want a database function to change my role to access the administrator privileges, so that I can use my privileges properly.
  * User Story: As a wiki user, I want a database function to update my password, so that I can secure my account or reset my password if I forget it.
  * User Story: As a wiki user, I want a database function to edit part summaries, character details, and wiki details, so that I can correct wiki information.

* Epic: As a wiki user, I want to be able to delete data in the database, so that I can remove unnessecary or incorrect information or delete my account
  * User Story: As a wiki user, I want a database function to remove character information, part summaries, and the wiki itself, so that I can remove unnessecary or incorrect information or simply start fresh.
  * User Story: As a wiki user, I want a database function to delete my account, so that I can delete my account when I am done with it and remove my user data.
    
* Epic: As a wiki user, I want to to be bale to read data in the database, so that I can view the data in the application and read the information in the wiki.
  * User Story: As a wiki user, I want a database function to retrieve my login details, so that I can log in and use my stored settings for the application.
  *  User Story: As a wiki user, I want a database function to retrieve character details, wiki details, and part summaries, so that I can read the wiki's information and learn more about the current show I am watching.

## General
* Epic: As a user, I want to be able to run this application on IOS, so that I can use my iPhone to access the application.
