Rails App with a jQuery Front End

[x]  Must render at least one index page (index resource - 'list of things') via jQuery and an Active Model Serialization JSON Backend. For example, in a blog domain with users and posts, you might display the index of the users posts on the users show page, fetching the posts via an AJAX GET request, with the backend rendering the posts in JSON format, and then appending the posts to the page.

Each matter has many time entries that belong only to that matter.  All time entries for a specific matter are listed on that matter's show page as a table.  The data for that table is obtained via jQuery/AJAX request and uses AMS to populate the time entry list with customized JSON containing relevant/helpful data. JQuery builds the table by parsing the JSON for each time entry, reformats it into an HTML string, and jQuery appends that HTML string to that table.

[x] Must render at least one show page (show resource - 'one specific thing') via jQuery and an Active Model Serialization JSON Backend. For example, in the blog domain, you might allow a user to sift through the posts by clicking a 'Next' button on the posts show page, with the next post being fetched and rendered via JQuery/AJAX.

The client show page renders client profiles via jQuery, AMS JSON Backend.  A lawyer can sift through clients by clicking a 'Next Client' and a 'Previous Client' button on the clients show page with the adjacent client fetched and rendered via JQuery/AJAX.

[x] The rails API must reveal at least one has-many relationship in the JSON that is then rendered to the page. For example if each of those posts has many comments, you could render those comments as well on that show page.

A lawyer has many matters that they supervise and clients. At '/lawyers.json', a JSON is rendered listing all the lawyers and all the matters they are supervising and their clients. On each lawyer's show page, the cases that lawyer supervises is listed on that page.

[x] Must use your Rails API and a form to create a resource and render the response without a page refresh. For example, a user might be able to add a comment to a post, and the comment would be serialized, and submitted via an AJAX POST request, with the response being the new object in JSON and then appending that new comment to the DOM using JavaScript (ES6 Template Literals, can help out a lot with this).

A form to enter a new Time Entry is displayed on each Matter's show page allowing a lawyer to enter a new time entry directly on that page.  Valid entries are immediately appended to the displayed list of associated time entries.

[x] Must translate the JSON responses into Javascript Model Objects. The Model Objects must have at least one method on the prototype. Formatters work really well for this. Borrowing from the previous example, instead of plainly taking the JSON response of the newly created comment and appending it to the DOM, you would create a Comment prototype object and add a function to that prototype to perhaps concatenate (format) the comments authors first and last name. You would then use the object to append the comment information to the DOM.

AJAX GET JSON responses for lawyers, time entries, and clients are translated into Objects to build data_templates to be rendered in the DOM.  In addition, each of these models have at least 1 prototype:

  Lawyers = calculate hours billed
  Clients = concatenate and format the display of the client's phone and email contact information into one line and add appropriate labels
  Time Entries = calculate the attorney fee for a time entry (i.e. the billing lawyer's rate x the duration)
