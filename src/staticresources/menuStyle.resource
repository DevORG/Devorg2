/* General */
        ul.headlink,ul.headlink ul { list-style: none; }
        ul.headlink, ul.headlink * { padding: 0; margin: 0; }

        /* Head links */
        ul.headlink li { width: 220px; float: left; margin-left: -1px; border: 1px black solid; background-color: #e9e9e9; text-align: center; }
        ul.headlink li a { display: block; padding: 15px; }

        /* Child lists and links */
        ul.headlink li ul { display: none; border-top: 1px black solid; text-align: left; }
        ul.headlink li:hover ul { display: block; }
        ul.headlink li ul li a { padding: 5px; height: 17px; }
        ul.headlink li ul li a:hover { background-color: #333; }
          
        /* Pretty styling */
        body { font-family: verdana, arial, sans-serif; font-size: 0.8em;  }
        ul.headlink a { color: white; } 
        ul.headlink ul li a:hover { text-decoration: none; }
        ul.headlink li { background-color: white; background-image: url(bg.gif); }
        ul.headlink li ul { background-image: url(bg.gif); background-position: bottom; padding-bottom: 0px; }

