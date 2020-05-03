---
layout: post
title:  "Logging out a session properly in PHP"
date:   2018-12-06 12:06:56 +0100
tags: php programming session
---

Logging out a user in PHP, the right way.

## The code, explained

```PHP
<?php
    // Recover the user's session from the server
    session_start();

    // Free all session variables:
    // Do NOT unset the whole $_SESSION with unset($_SESSION) as this will disable the registering
    // of session variables through the $_SESSION superglobal. (http://php.net/manual/en/function.session-unset.php)
    session_unset();

    // Destroy all 
    session_destroy();
    session_write_close();
    setcookie(session_name(),'',0,'/');
    session_regenerate_id(true);
?>

```
