---
layout: page
title: HTML 5 Solutions
permalink: /teaching/solutions/html/html5/
crumbtitle: HTML5
---

# HTML Exercises Solutions

## Online Newspaper

```html
<!DOCTYPE html>
<html>
  <head>
    <title>Online Newspaper</title>
    <meta charset="utf-8">
  </head>
  <body>
    <header>
      <h1>Online Newspaper</h1>
      <h2>The best online newspaper in the world</h2>
      <img src="logo.png" alt="Newspaper Logo">
      <nav>
        <ul>
          <li><a href="#">Politics</a></li>
          <li><a href="#">World</a></li>
          <li><a href="#">Sports</a></li>
          <li><a href="#">Local</a></li>
        </ul>
      </nav>
    </header>

    <section id="news">
      <h2>News</h2>
      <article>
        <h3>Ut sed dolor vel odio</h3>
        <p class="introduction">Donec sit amet bibendum dui. In suscipit accumsan dolor, vitae consequat nulla aliquam in. Sed vulputate, lorem sit amet ullamcorper hendrerit, magna nunc semper neque, in ornare orci nisi ac nibh. Maecenas in lacus odio. Curabitur eget nibh nec libero sodales sodales rutrum at eros. Fusce in lacus vitae nisl lacinia scelerisque. In tellus purus, tempus vulputate lacinia a, vestibulum et lacus. Sed fermentum egestas massa nec malesuada.</p>
        <img src="http://lorempixel.com/400/200/sports" alt="Some random photo">
        <footer><span class="author">John Doe</span> <span class="date">May 5</span></footer>
      </article>

      <article>
        <h3>Mauris ac nulla faucibus turpis</h3>
        <p class="introduction">Fusce faucibus leo sit amet ante tristique convallis. Praesent odio odio, tincidunt lacinia luctus eget, feugiat vel nibh. Quisque eu dolor dignissim, congue orci a, lacinia erat. Pellentesque ultrices aliquet dui, a pretium lacus condimentum sed. Suspendisse potenti. Sed massa massa, interdum quis iaculis sed, rutrum eget sapien. Fusce metus risus, accumsan vitae sem et, bibendum dictum erat. Suspendisse porta, leo eget sodales mattis, orci magna feugiat velit, eu blandit tellus arcu vel nibh.</p>
        <img src="http://lorempixel.com/400/200/business" alt="Some random photo">
        <footer><span class="author">John Doe</span> <span class="date">May 5</span></footer>
      </article>

      <article>
        <h3>Sed dictum pulvinar tincidunt</h3>
        <p class="introduction">Duis sit amet varius ligula, eget vestibulum erat. Morbi placerat tincidunt ultrices. Proin sed elit vitae erat pulvinar imperdiet. Vivamus at tristique lorem, non imperdiet arcu. Praesent augue purus, rutrum ut dolor sit amet, dictum molestie libero. Aenean vitae lorem vel tortor tincidunt tincidunt. Praesent at arcu a est venenatis luctus. Nunc velit nisi, interdum id fringilla ac, cursus at urna. Vivamus a erat ante.</p>
        <img src="http://lorempixel.com/400/200/food" alt="Some random photo">
        <footer><span class="author">John Doe</span> <span class="date">May 5</span></footer>
      </article>
    </section>
  </body>
</html>
```

## Table

```html
<!DOCTYPE html>
<html>
  <head>
    <title>Table</title>
    <meta charset="utf-8">
  </head>
  <body>
    <table border="1">
      <tr>
        <th colspan="2" rowspan="2">Student</th>
        <th colspan="4">Exam</th>
        <th colspan="4">2nd Exam</th>
        <th colspan="2" rowspan="2">Final Grade</th>
      </tr>
      <tr>
        <th>Q1</th>
        <th>Q2</th>
        <th>Q3</th>
        <th rowspan="2">Grade</th>
        <th>Q1</th>
        <th>Q2</th>
        <th>Q3</th>
        <th rowspan="2">Grade</th>
      <tr>
        <th>Code</th>
        <th>Name</th>
        <td>8</td>
        <td>7</td>
        <td>5</td>
        <td>6</td>
        <td>7</td>
        <td>7</td>
        <th>s/ A.</th>
        <th>c/ A.</th>
      </tr>
      <tr>
        <td>80549061</td>
        <td>John</td>
        <td>70%</td>
        <td>100%</td>
        <td>100%</td>
        <td>17.6</td>
        <td colspan="4">&nbsp;</td>
        <td>17.6</td>
        <td>18</td>
      </tr>
      <tr>
        <td>80549062</td>
        <td>Mary</td>
        <td>10%</td>
        <td>50%</td>
        <td>50%</td>
        <td>6.8</td>
        <td>100%</td>
        <td>100%</td>
        <td>50%</td>
        <td>16.5</td>
        <td>16.5</td>
        <td>17</td>
      </tr>
      <tr>
        <td>80549063</td>
        <td>Claire</td>
        <td colspan="4">&nbsp;</td>
        <td>50%</td>
        <td>50%</td>
        <td>50%</td>
        <td>10.0</td>
        <td>10.0</td>
        <td>10</td>
      </tr>
    </table>
    <img src="http://www.w3c.it/events/2013/css3html5/img/html5-logo.png"
         alt="Valid HTML5 Icon">
  </body>
</html>
```

## Form

```html
<!DOCTYPE html>
<html>
  <head>
    <title>New User</title>
    <meta charset="utf-8">
  </head>
  <body>
    <form action="save.php" method="get">
      <label>Name:
        <input type="text" name="name">
      </label>
      <fieldset>
        <legend>Age</legend>
        <label>
          <input type="radio" name="age" value="-18">&lt;18
        </label>
        <label>
          <input type="radio" name="age" value="19-35">19-35
        </label>
        <label>
          <input type="radio" name="age" value="36-48">36-48
        </label>
        <label>
          <input type="radio" name="age" value="49+">&gt;49
        </label>
      </fieldset>
      <label>Profession:
        <input type="text" name="profession">
      </label>
      <label>Country:
        <select name="country">
          <option value="portugal">Portugal</option>
          <option value="spain">Spain</option>
          <option value="france">France</option>
          <option value="italy">Italy</option>
          <option value="greece">Greece</option>
        </select>
      </label>
      <fieldset>
        <legend>Interests</legend>
        <label>
          <input type="checkbox" name="interest" value="photography">Photography
        </label>
        <label>
          <input type="checkbox" name="interest" value="music">Music
        </label>
        <label>
          <input type="checkbox" name="interest" value="cinema">Cinema
        </label>
        <label>
          <input type="checkbox" name="interest" value="computers">Computers
        </label>
      </fieldset>
      <label>
        How did you find about us:
        <textarea name="how" cols="40" rows="5"></textarea>
      </label>
    </form>
  </body>
</html>
```

## Use HTML to create your profile in a social network

```html
<!DOCTYPE html>
<html>
  <head>
    <title>New User</title>
    <meta charset="utf-8">
  </head>
  <body>
    <header>
      <h1>Friends Ahoy!</h1>
      <img src="logo.png" alt="Site Logo">
      <nav id="menu">
        <ul>
          <li><a href="register.php">Register</a></li>
          <li><a href="messages.php">Messages</a></li>
          <li><a href="about.php">About</a></li>
        </ul>
      </nav>
      <form action="login.php" method="post">
        <label>Username:<input type="text" name="username"></label>
        <label>Password:<input type="password" name="password"></label>
      </form>
    </header>
    <aside id="friends">
      <h2>Friends</h2>
      <ul>
         <li>
           <a href="friend.php?id=jane">
            <img src="photo.php?id=jane" alt="Jane Doe">Jane Doe
           </a>
         </li>
         <li>
           <a href="friend.php?id=louie">
            <img src="photo.php?id=louie" alt="Louie Doe">Louie Doe
           </a>
         </li>
         <li>
           <a href="friend.php?id=mary">
            <img src="photo.php?id=mary" alt="Mary Doe">Mary Doe
           </a>
         </li>
      </ul>
    </aside>
    <section id="personal">
      <h2>Who am I?</h2>
      <ul>
        <li>Name: John Doe</li>
        <li>Age: 29</li>
        <li>Country: Portugal</li>
      </ul>
    </section>
    <section id="posts">
      <h2>Posts</h2>
      <article>
        <h3>Something about life</h3>
        <img src="image.php?id=24345" alt="Image for post 24345">
        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum in ultricies mi. Sed fermentum vitae sapien sed aliquam. Maecenas a.</p>
        <p>Quisque porttitor mollis tellus, ac sollicitudin ipsum tempus quis. Phasellus sit amet.</p>
        <footer>
          <a href="comments.php?id=24345">Comments (54)</a> <span class="date">@May 5th 2014</span>
        </footer>
      </article>  
      <article>
        <h3>Something about something else</h3>
        <img src="image.php?id=23562" alt="Image for post 23562">
        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum in ultricies mi. Sed fermentum vitae sapien sed aliquam. Maecenas a.</p>
        <p>Quisque porttitor mollis tellus, ac sollicitudin ipsum tempus quis. Phasellus sit amet.</p>
        <footer>
          <a href="comments.php?id=23562">Comments (12)</a> <span class="date">@May 1st 20014</span>
        </footer>
      </article>  
    </section>
  </body>
</html>
```

## Acknowledgement

Exercises by [André Restivo](https://web.fe.up.pt/~arestivo/).
