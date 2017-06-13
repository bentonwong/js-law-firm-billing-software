# README

Law Firm Billing Software with jQuery Front End v.2.0 by Benton Wong

This application is for lawyers to log their time for matters they are working on, create, view, and view activities of lawyers and matters, add and update clients, and view outstanding balances owed by particular clients.

##Features

  Original Features
  -Allows creation and editing of lawyer and client profiles, matters, and their time entries
  -View all the matters associated with a client
  -View a client's current invoice
  -View time entries associated with a matter
  -View list all outstanding accounts receivables
  -View list of all clients with outstanding balances
  -Each matter has a supervising attorney, who will be only one authorized to edit matters and delete associated time entries
  -Lawyers can only edit their own individual profiles

  New Front End Features

  -Form to directly add time entry and immediately adds it to the displayed list of other time entries without a page refresh
  -Client profiles can be flipped through without a page refresh
  -Lawyer matters on individual lawyer show pages are rendered via jQuery and AJAX and uses Javascript to calculate hours billed for it

Getting Started

  1) Set up lawyer account by going to the root page at '/'.
  2) New lawyers can either click "Sign Up" to set up a new lawyer account or if they have a Google account, they can click "Sign in with Google".  NOTE: If a lawyer does sign up via a Google account, the lawyer must go to their lawyer profile to set their rate by clicking on their name in the upper right hand corner.  This will lead to the lawyer profile page.  Each lawyer profile page has a link to edit their own individual profiles. The lawyer will not be able to save any time entries without a rate.
  3) To create a new time entry for a matter, lawyers can either go to the associated matter page and click on the link "Enter a new time entry" or go to the Time Entry page itself through Time Entry navigation link at footer of the site.
  4) To create a new client, lawyers can go to the Clients page via the navigation link at footer of the site.
  5) To create a new matter, lawyers can go to the Matters page via the navigation link at footer of the site.
  6) To logout, lawyers can click on the logout link next to their name in the upper right hand corner of the screen.

Development

  v.1.0 was built on Rails with ActiveRecord.
  v.2.0 was built on top of v.1.0 with a jQuery front end with dynamic features.

## Contributing

  Bug reports and pull requests are welcome on GitHub at https://github.com/bentonwong/law-firm-billing-software. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The application is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
