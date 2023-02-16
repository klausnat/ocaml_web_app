# `Web-application for Nobias, on Dream framework`

<br>

This example is a simple Web server with a PostgreSQL database.

This example do not use Docker and Docker Compose yet (I am working on it now)

<pre><code><b>$ cd nobias/web_app</b></code></pre>

<br>
You will need up and running postgres on your laptop, I created file schema.sql where you can take
initial queries to create test database.
<br >

Code is in file form.eml.ml <br />

First, we define a prepared statement using Caqti, a library for talking to SQL databases:
<pre><code><b>
let list_comments msg =
   let query =
    Caqti_type.string ->* Caqti_type.(tup4 string string string string) @@
    {eos|
      SELECT tf, tissue, cell_type, cell_line FROM tfs WHERE target = ? |eos} in
  fun (module Db : DB) ->
    let%lwt comments_or_error = Db.collect_list query (msg) in
    Caqti_lwt.or_fail comments_or_error
</b></code></pre>

<p> Here insert your postgresql username:password, postgres usually uses 5432 port</p>

<pre><code><b>
@@ Dream.sql_pool "postgresql://natalie:natalie@localhost:5432"          
</b></code></pre>


<pre><code><b>$ dune exec ./form.exe</b></code></pre>
visit your http://localhost:8080 and try out the application.
With test database try to search for NAT gene - it should give couple of results,
we only have 2 rows in test database

<p> <b> This is just routing for fetching design </b></p>
<pre><code><b>
Dream.get "/assets/**" (Dream.static "assets");
Dream.get "/images/**" (Dream.static "images")
</b></code></pre>

<p> <b> About POST form </b></p>

then we have html design with POST form, and some prepared design to show results retrieved from Database

The CSRF token was added to the form using
[`Dream.csrf_tag`](https://aantron.github.io/dream/#val-csrf_tag). Its output
looks something like this:

```html
<form method="POST" action="/">
  <input name="dream.csrf" type="hidden" value="j8vjZ6...">
  <input name="message" autofocus>
</form>
```

That generated, hidden `dream.csrf` field helps to [prevent CSRF
attacks](https://cheatsheetseries.owasp.org/cheatsheets/Cross-Site_Request_Forgery_Prevention_Cheat_Sheet.html).
It should be the [first
field](https://portswigger.net/web-security/csrf/tokens#how-should-csrf-tokens-be-transmitted)
in your form.

When the form is submitted and parsed using
[`Dream.form`](https://aantron.github.io/dream/#val-form), `Dream.form` expects
to find the `dream.csrf` field, and checks it. If there is anything wrong with
the CSRF token, [`Dream.form`](https://aantron.github.io/dream/#val-form) will
return a [value other than
`` `Ok _``](https://aantron.github.io/dream/#type-form_result).

<br>

The form fields carried inside `` `Ok _`` are returned in sorted order, so we
can reliably pattern-match on them.

<br>

This example replied to the form POST directly with HTML. We also can use
[`Dream.redirect`](https://aantron.github.io/dream/#val-redirect)
instead, to forward the browser to another page that will display the outcome.

<br>
