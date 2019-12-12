---
layout: page
title: PHP FAQ / Tips/ Common Mistakes
permalink: /teaching/2020/ESIN_SIBD/tips_faq
crumbtitle: PHP FAQ / Tips/ Common Mistakes
---

Here are answers to some common problems faced by students working on the PHP practical work. Please send me your questions and tips and I will add them to this list.

## Debugging: printing the contents of a variable

The functions that you will use the most are these:

```php
<?php
	echo $variable; // print the contents of a variable (not so good for complex variables such as Arrays)
?>

```

```php
<?php
	print_r($variable); // prints the contents of an array or other variables in human-readable format
?>
```

## Common mistakes

### Not inspecting and validating values at the start of the script

Variable names can often be wrong (`$_GET['variable]` / `$_POST['variable']` do not have what you expect)... Check the `name` attribute of your inputs at the beginning of the php script (using lots of `isset()`'s) before doing anything else.

For example, if you have a form like this:


```html
<form action="action_login.php" method="POST">

	<label for="username_textbox"></label>
	<input type="text" name="username" id="username_textbox">

	<label for="password_textbox"></label>
	<input type="password" name="password" id="password_textbox">

<button type="submit">Login</button>
</form>
````

Then your username and password will be retrieved as shown below. 

Watch the `name` attribute of your `input` HTML elements, that is what dictates the key that you use to get the value back in the server, via the `$_POST` or `$_GET` arrays.


```php
<?php

//getting values of inputs submitted via POST. Validate the presence of the values in the beginning, and extract them from the $_GET or $_POST superglobals into your own variables!

if(isset($_POST['username']))
	$username = $_POST['username']; // because we had an HTML input element with 'username' in the name attribute
else
	die("no username");

if(isset($_POST['password']))
	$password = $_POST['password'];	// because we had an HTML input element with 'password' in the name attribute
else
	die("no password");

//using print_r to see the attributes of your users
$users = getAllUsers();
print_r($users);
print_r($users[0]);

?>
```

### Not checking what your queries actually return

Another example of not checking the contents of your variables.

Say you want to count the number of products in your database. You write a function `countProducts()` in your `database/products.php` file:

```php
<?php 
function countProducts()

{

//....some more code to access the database...

$stmt = $dbh->prepareStatement('SELECT COUNT(*) FROM Products');

$stmt->execute();

$result = $dbh->fetch(); //only one row anyway because this is a simple COUNT, so no need to call fetchAll();

return $count;

}

//in your main php file, you then call the function...

$num_products = countProducts();

Number of products: <?=$num_products ?>
?>
```

And you get an error, something like `'Integer expected, Array provided'`, or whatever. Or even worse, you may use it in a comparison...

```php
<?php
if($num_products > 0)
{
///.....
}
?>
```

...which can give some hard to decipher results!


#### The problem


When you run your statement, PDO returns you not an integer with the number of products, but an Array, with this structure:
```php
<?php
Array([COUNT(*)] => 12); // if we have 12 products in the database
?>
```

To get the value you are looking for, you need to access the array by providing the key.


```php
<?php
function countProductsFixed()

{

//....some more code to access the database...

$stmt = $dbh->prepareStatement('SELECT COUNT(*) FROM Products');

$stmt->execute();

$result = $dbh->fetch(); //only one row anyway because this is a simple COUNT, so no need to call fetchAll();

return $count['COUNT(*)'];

}

?>
```

Of course this `'COUNT(?*)'` key looks nasty, so we should give the column an alias:


```php
<?php
function countProductsFixed()
{

//....some more code to access the database...

$stmt = $dbh->prepareStatement('SELECT COUNT(*) as num_products FROM Products');

$stmt->execute();

$result = $dbh->fetch(); //only one row anyway because this is a simple COUNT, so no need to call fetchAll();

return $count['num_products'];
}
?>
```


#### A pattern emerges


This type of errors can all be avoided if you follow a simple rule: run `print_r($result)` before returning `$result` in your functions that access the database, until you get the return type right. Then, comment the line, because it should be used only for development.

This way, you can see what is the actual structure of the `$return` variable and avoid these surprises. In this case, we would immediately see that it is an `Array` and that if we want the integer value, we need to access it via its key.


#### Why this can mess up your code in a sneaky way


If you use the return value in a comparison, you will waste a lot of time. If you build a function called `clientExists($username)`, which given the username of a client returns if the client exists or not (common in registration forms):


```php
<?php
function clientExists($username)

{

//code to access database connection

$stmt = $dbh->prepareStatement(SELECT * FROM clients where username = ?)

$stmt->execute(array($username));

$result = $stmt->fetch();

return $result; 

)

//back in the main file...

/** WATCH OUT **/
// the result will be false even if the client does not exist. 
// This is because the result of the function will be 
// an empty array, 
// which is not null, therefore it is a "truthy" value. 
// !true = false, so the body of the if will never execute.
if(! clientExists($id) ) 
	//this is never run, and you will curse your existence.
	// "why cant I register the client, i KNOW there is no one with that
	// username!"
    registerClient(...)  
?>
```

### Other issues for those using local deployment environments

#### Turning on error reporting / debugging parameters

For those of you using local HTTP servers: You should turn on error printing, otherwise your scripts crash without any errors being shown in the page.

Quoted from a student from another course (Thanks [Bruno Mauricio](https://sigarra.up.pt/feup/pt/fest_geral.cursos_list?pv_num_unico=201604107))

> Greetings fellow humans.
> 
> From time to time, PHP throws an error, and if the server is not configured for such, a simple empty page will appear, with no error whatsoever (this is most true for local, non properly configured, servers).
>
> So to fix this, you can either configure the server, or add the following lines to all scripts (through a global include or something of the sort).
> These will help you force PHPs' runtime environment to spit out the error log.
>
> ```php 
>    <?php 
>    ini_set('display_errors', 1);
>    ini_set('display_startup_errors', 1);
>    error_reporting(E_ALL);
>    ?>
> ```
>
> Farewell,
> Bruno Maurício










