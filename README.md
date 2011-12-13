Sapling Gem
===========

Sapling lets you seed your new features to just a few users at a time. You can change which and how many users are
seeded for a feature dynamically by updating the database via the Sapling API. Core features are the ability to
seed a feature for specific users and/or a percentage of users.

Heritage
--------

This is a port of the [rollout gem](https://github.com/jamesgolick/rollout) for
use with ActiveRecord instead of Redis. We dropped the groups functionality, but otherwise we mirrored the API.

Instructions
------------

Add a route to your routes file. Feel free to change the 'sapling/stylesheet.css' to whatever you want.

    map.sapling_stylesheet 'sapling/stylesheet.css', :controller => 'sapling', :action => 'stylesheet'

In your application layout header, add:

    <%= stylesheet_link_tag sapling_stylesheet_path %>