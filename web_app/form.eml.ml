module type DB = Caqti_lwt.CONNECTION
open Caqti_request.Infix

(* @TODO create list of possible queries in a seaparate module 
   like in example with bikes in Caqti library *)
let list_comments msg =
   let query =
    Caqti_type.string ->* Caqti_type.(tup4 string string string string) @@
    {eos|
      SELECT tf, tissue, cell_type, cell_line FROM tfs WHERE target = ? |eos} in
  fun (module Db : DB) ->
    let%lwt comments_or_error = Db.collect_list query (msg) in
    Caqti_lwt.or_fail comments_or_error

let show_form ?gene ?comments request =
  <!DOCTYPE HTML>
  <html>
  <head>
    <title>Nobias Terapeutics</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <!--[if lte IE 8]><script src="assets/js/ie/html5shiv.js"></script><![endif]-->
    <link rel="stylesheet" href="assets/css/main.css" />
    <!--[if lte IE 8]><link rel="stylesheet" href="assets/css/ie8.css" /><![endif]-->
    <!--[if lte IE 9]><link rel="stylesheet" href="assets/css/ie9.css" /><![endif]-->
  </head>
  <body>
    <div id="page-wrapper">
      <!-- Header -->
      <div id="header">
      <!-- Logo -->
        <h1><a href="#" id="logo">Nobias <em>Therapeutics</em></a></h1>
        <!-- Nav -->
        <nav id="nav">
          <ul>
            <li><a href="#">Home</a></li>
            <li class="current"><a href="#">Query gene</a></li>
            <li><a href="#">TF list</a></li>
            <li>
              <a href="#">Dropdown menu</a>
              <ul>
                <li><a href="#">Link one</a></li>
                <li><a href="#">Link two</a></li>
              </ul>
            </li>
            <li><a href="#">Contact</a></li>
            <li><a href="#">Info</a></li>
          </ul>
        </nav>
      </div>
      <!-- Main -->
      <section class="wrapper style1">
        <div class="container">
          <div id="content">
            <article>
                   
              <header>
                <h2>Query Gene</h2>
                <p>Browse the TF-target regulations for a query gene. </p>
                <p>
                  <div class="row 50%">
                    <div class="6u 12u(mobilep)">
                      <form method="POST" action="/">
                        <%s! Dream.csrf_tag request %>
                        <input type="text"
                           name="gene"
                           id="name"
                           placeholder="Enter gene symbol e.g. STPG1" />
                      
                    </div>
                    <div class="6u 12u(mobilep)">
                      <input type="submit" class="button alt" value="Search" /></form>
                    </div>
                  </div>
                </p>
              </header>

%   begin match gene with
%   | None -> ()
%   | Some gene ->
      <p>
       Query gene <%s gene %> may be regulated by TFs, listed in the table below.
      </p>
%   end;
                          
%   begin match comments with
%   | None -> ()
%   | Some comments ->
      
%     comments |> List.iter (fun (tf, tissue, cell_type, cell_line) -> 
      <p><%s tf %>, <%s tissue %>, <%s cell_type %>, cell_line : <%s cell_line %></p><% ); %>
%   end;
            
                                                 
            </article>
          </div>
        </div>
      </section>
      <!-- Footer -->
      <div id="footer">
      <div class="container">
      <div class="row">
        <section class="3u 6u(narrower) 12u$(mobilep)">
        <h3>Links to Stuff</h3>
        <ul class="links">
          <li><a href="#">Mattis et quis rutrum</a></li>
          <li><a href="#">Suspendisse amet varius</a></li>
          <li><a href="#">Sed et dapibus quis</a></li>
          <li><a href="#">Rutrum accumsan dolor</a></li>
          <li><a href="#">Mattis rutrum accumsan</a></li>
          <li><a href="#">Suspendisse varius nibh</a></li>
          <li><a href="#">Sed et dapibus mattis</a></li>
        </ul>
       </section>
       <section class="3u 6u$(narrower) 12u$(mobilep)">
       <h3>More Links to Stuff</h3>
       <ul class="links">
         <li><a href="#">Duis neque nisi dapibus</a></li>
         <li><a href="#">Sed et dapibus quis</a></li>
         <li><a href="#">Rutrum accumsan sed</a></li>
         <li><a href="#">Mattis et sed accumsan</a></li>
         <li><a href="#">Duis neque nisi sed</a></li>
         <li><a href="#">Sed et dapibus quis</a></li>
         <li><a href="#">Rutrum amet varius</a></li>
       </ul>
       </section>
       <section class="6u 12u(narrower)">
       <h3>Get In Touch</h3>
       <form>
         <div class="row 50%">
           <div class="6u 12u(mobilep)">
             <input type="text" name="name" id="name" placeholder="Name" />
           </div>
           <div class="6u 12u(mobilep)">
             <input type="email" name="email" id="email" placeholder="Email" />
           </div>
         </div>
         <div class="row 50%">
           <div class="12u">
             <textarea name="message" id="message" placeholder="Message" rows="5"></textarea>
           </div>
         </div>
         <div class="row 50%">
           <div class="12u">
             <ul class="actions">
               <li><input type="submit" class="button alt" value="Send Message" /></li>
             </ul>
           </div>
         </div>
       </form>
       </section>
    </div>
    </div>
  <!-- Icons -->
  <ul class="icons">
   <li><a href="#" class="icon fa-twitter"><span class="label">Twitter</span></a></li>
  <li><a href="#" class="icon fa-facebook"><span class="label">Facebook</span></a></li>
  <li><a href="#" class="icon fa-github"><span class="label">GitHub</span></a></li>
  <li><a href="#" class="icon fa-linkedin"><span class="label">LinkedIn</span></a></li>
  <li><a href="#" class="icon fa-google-plus"><span class="label">Google+</span></a></li>
  </ul>
  <!-- Copyright -->
  <div class="copyright">
  <ul class="menu">
    <li>&copy; Nobias</li><li>Terapeutics</li>
  </ul>
  </div>
      </div>
    </div>
    <!-- Scripts -->
    <script src="assets/js/jquery.min.js"></script>
    <script src="assets/js/jquery.dropotron.min.js"></script>
    <script src="assets/js/skel.min.js"></script>
    <script src="assets/js/util.js"></script>
    <!--[if lte IE 8]><script src="assets/js/ie/respond.min.js"></script><![endif]-->
    <script src="assets/js/main.js"></script>
  </body>
  </html>

let () =
  Dream.run
  @@ Dream.logger
  @@ Dream.sql_pool "postgresql://natalie:natalie@localhost:5432"          
  @@ Dream.memory_sessions
  @@ Dream.router [

    Dream.get  "/"
      (fun request ->
        Dream.html (show_form request));

    Dream.post "/"
      (fun request ->
        match%lwt Dream.form request with
        | `Ok ["gene", gene] ->
          let%lwt comments = Dream.sql request (list_comments gene) in
          Dream.html (show_form ~gene ~comments request)
        | _ ->
          Dream.empty `Bad_Request);

    Dream.get "/assets/**" (Dream.static "assets");
    
    Dream.get "/images/**" (Dream.static "images")
  ]
