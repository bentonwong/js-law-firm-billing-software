Rails App with a jQuery Front End

[x]  Must render at least one index page (index resource - 'list of things') via jQuery and an Active Model Serialization JSON Backend. For example, in a blog domain with users and posts, you might display the index of the users posts on the users show page, fetching the posts via an AJAX GET request, with the backend rendering the posts in JSON format, and then appending the posts to the page.

Each matter has many time entries that belong only to that matter.  All time entries for a specific matter are listed on that matter's show page as a table.  The data for that table is obtained via jQuery/AJAX request and uses AMS to populate the time entry list with customized JSON containing relevant/helpful data. JQuery builds the table by parsing the JSON for each time entry, reformats it into an HTML string, and jQuery appends that HTML string to that table.

[] Must render at least one show page (show resource - 'one specific thing') via jQuery and an Active Model Serialization JSON Backend. For example, in the blog domain, you might allow a user to sift through the posts by clicking a 'Next' button on the posts show page, with the next post being fetched and rendered via JQuery/AJAX.

[] The rails API must reveal at least one has-many relationship in the JSON that is then rendered to the page. For example if each of those posts has many comments, you could render those comments as well on that show page.

A lawyer has many matters that they supervise. At '/lawyers.json', a JSON is rendered listing all the lawyers and all the matters they are supervising. Need to figure out the best way to render this.

[x] Must use your Rails API and a form to create a resource and render the response without a page refresh. For example, a user might be able to add a comment to a post, and the comment would be serialized, and submitted via an AJAX POST request, with the response being the new object in JSON and then appending that new comment to the DOM using JavaScript (ES6 Template Literals, can help out a lot with this).

A form to enter a new Time Entry is displayed on each Matter's show page allowing a lawyer to enter a new time entry directly on that page.  Valid entries are immediately appended to the displayed list of associated time entries.

[] Must translate the JSON responses into Javascript Model Objects. The Model Objects must have at least one method on the prototype. Formatters work really well for this.
Borrowing from the previous example, instead of plainly taking the JSON response of the newly created comment and appending it to the DOM, you would create a Comment prototype object and add a function to that prototype to perhaps concatenate (format) the comments authors first and last name. You would then use the object to append the comment information to the DOM.


Rails Portfolio Project Requirements

[x] Use the Ruby on Rails framework.

  System built on Rails 5.0.2.

[x] Your models must include a has_many, a belongs_to, and a has_many :through relationship. You can include more models to fill out your domain, but there must be at least a model acting as a join table for the has_many through.

  System is a law firm billing app where there are lawyers, matters, clients, and time entries represented as objects.  They are associated as follows:
  -a lawyer has_many matters
  -a lawyer has_many clients, through matters
  -a matters belongs_to both a lawyer and a client (the matters model acts as the join table)
  -a client has_many matters
  -a client has_many lawyers, through matters
  -matters has_many time entries
  -lawyers has_many time entries
  -time entry belongs_to a matter and a lawyer
  -notes has_one matter_note
  -note has_one matter, through matter_notes
  -matters has_many matter_notes
  -matters has_many notes, through matter_notes
  -matter_notes, belongs_to matters and notes (the matter_notes acts as the join table)

[x] Your models should include reasonable validations for the simple attributes. You don't need to add every possible validation or duplicates, such as presence and a minimum length, but the models should defend against invalid data.

  Validations check forms before saving for the following:
  -presence of names, emails, passwords, dates, descriptions
  -all numerical values are equal or greater than 0
  -lawyer and client emails are unique and meet the format of an email address
  -time entry descriptions are at least 2 to 100 characters in length
  -client and lawyer ids are present to create the join table row
  -login email and passwords are valid and not blank

[x] You must include at least one class level ActiveRecord scope methods. To some extent these class scopes can be added to power a specific individual feature, such as "My Overdue Tasks" in a TODO application, scoping all tasks for the user by a datetime scope for overdue items, @user.tasks.overdue. Reports make for a good usage of class scopes, such as "Most Valuable Cart by Customer" where the code would implement a Cart.most_valuable and Cart.by_customer which could be combined as Cart.most_valuable.by_customer(@customer).

  TimeEntry Class has 2 class level methods:

    1)  TimeEntry::accounts_receivable

    Method goes through all the time entries, selects the entries that are billable and unpaid, and the sums up the value of all those time entries to determine all fees due to the firm that the firm has yet to receive.

    2) Client::outstanding_clients

    Method goes through all the time entries, selects the entries that are billable and unpaid, and then returns a unique list of clients associated with those unpaid time entries.

[x] You must include a nested form that writes to an associated model through a custom attribute writer. An example of this would be a New Recipe form that allowed you to add ingredients that are unique across recipes (thereby requiring a join model, or imagine being able to see all recipes that include Chicken), along with a quantity or description of the ingredient in the recipe. On this form you would have a series of fields named recipe[ingredient_attributes][0][name] and recipe[ingredient_attributes][0][description] which would write to the recipe model through a method ingredient_attributes=. This method cannot be provided via the accepts_nested_attributes_for macro because the custom writer would be responsible for finding or creating a recipe by name and then creating the row in the join model recipe_ingredients with the recipe_id, the ingredient_id, and the description from the form.

  A nested form is built into the new matter and edit matter form to allow lawyers to write a dated note to a matter. Notes are then saved and displayed on that matter's show page in reverse chronological order.  In the html, it has the following name fields for the form:

    date(month): matter[notes_attributes][0][date_2i]
    date(day): matter[notes_attributes][0][date_3i]
    date(year): matter[notes_attributes][0][date_1i]
    content: matter[notes_attributes][0][content]

  A method called notes_attributes= is in the Matters model as a custom writer for creating the note and then adding it to the join table matter_notes.

[x] Your application must provide a standard user authentication, including signup, login, logout, and passwords. You can use Devise but given the complexity of that system, you should also feel free to roll your own authentication logic.

  System uses a simple authentication process that includes a process for signup, login, logout, and password.  Only lawyers are allowed to have accounts and thus, the lawyer class uses a has_secure_password and password are encrypted via password_digest and bcrypt.
  Devise was not implemented here.

[x] Your authentication system should allow login from some other service. Facebook, twitter, foursquare, github, etc...

  System allows login from Google via omniauth-google-oauth2.

[x] You must make use of a nested resource with the appropriate RESTful URLs. Additionally, your nested resource must provide a form that relates to the parent resource. Imagine an application with user profiles. You might represent a person's profile via the RESTful URL of /profiles/1, where 1 is the primary key of the profile. If the person wanted to add pictures to their profile, you could represent that as a nested resource of /profiles/1/pictures, listing all pictures belonging to profile 1. The route /profiles/1/pictures/new would allow me to upload a new picture to profile 1. Focus on making a working application first and then adding more complexity. Making a nested URL resource like '/divisions/:id/teams/new' is great. Having a complex nested resource like 'countries/:id/sports/:id/divisions/:id/teams/new' is going to make this much harder on you

  System uses standard RESTful URLs (e.g. '/lawyers' or lawyer_path to render the lawyer index page or '/clients/:id/edit' to edit a client's information as edit_client_path).

  Time entries are provided as a nested resource that relates to matters as a parent resource.
  -A new time entry form is render to allow a lawyer to add to a specific matter via '/matters/:id/time_entries/new'
  -Time entries related to a particular matter are viewable via '/matters/:id/time_entries'

[x] Your forms should correctly display validation errors. Your fields should be enclosed within a fields_with_errors class and error messages describing the validation failures must be present within the view.

  Fields_with_errors are used in forms to validate data being entered to create and update lawyer, client, matter, and time entry objects.
  A simpler system to display validation errors was employed for the sessions controller when verifying credentials only since verification does not save data to the database trigger error messages. If credentials are invalid, the user is redirected to the originating form and with an appropriate error message.

[x] Your application must be, within reason, a DRY (Do-Not-Repeat-Yourself) rails app. Logic present in your controllers should be encapsulated as methods in your models. Your views should use helper methods and partials to be as logic-less as possible. Follow patterns in the Rails Style Guide and the Ruby Style Guide.

  -In views, forms have been made DRY through use of partials.
  -In controllers, before_actions are used and controllers with complex actions are broken down into methods that have been moved to the ApplicationHelper when appropriate.
  -In models, methods have been refactored extensively.
