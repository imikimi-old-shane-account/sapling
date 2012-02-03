Sapling Gem
===========

Sapling lets you seed your new features to just a few users at a time. You can change which and how many users are
seeded for a feature dynamically by updating the database via the Sapling API. Core features are the ability to
seed a feature for specific users and/or a percentage of users.

Heritage
--------

This is a port of the [rollout gem](https://github.com/jamesgolick/rollout) for
use with ActiveRecord instead of Redis. We dropped the groups functionality, but otherwise we mirrored the API.

Setup
-----

Add a route to your routes file. Feel free to change the 'sapling/stylesheet.css' to whatever you want.

    map.sapling_script 'sapling/script.js', :controller => 'sapling', :action => 'script'

After including your javascript library, add this:

    <%= javascript_include_tag sapling_script_path, :id => 'sapling_script' %>

Run the `db/create.sql` file to create the sapling_settings table on your DB

Ensure you have a current_user method to your application controller, which returns a user object, or nil if no active user.

    class ApplicationController < ActionController::Base
      ...
      def current_user
        # Return your current user
        # This is already done for you in Devise, RestfulAuthentication, and other authentication lib
      end
      ...
    end



For a given feature `space_chat`,

Server-side Usage
-----------------

To check if a feature is enabled for a user in rails controllers or views: use

    sapling.active?(:space_chat [, :user => the current user])


  *Note*: sapling will automatically populate the user argument by calling `current_user`

To get the css classes the javascript adds to the HTML element for a feature:

    sapling.css_class(:space_chat)
    sapling.css_toggle_class(:space_chat)

To enable a feature for a specific user, in the rails console:

    Sapling::ActiveRecord.new.activate_user(:space_chat, space_admin)

To disable a feature for a specific user, in the rails console:

    Sapling::ActiveRecord.new.deactivate_user(:space_chat, space_admin)

To enable a feature for 50% of the users, in the rails console:

    Sapling::ActiveRecord.new.activate_percentage(:space_chat, 50)`

To disable a feature activated for anyone but individually-activated users, in the rails console:

    Sapling::ActiveRecord.new.deactivate_percentage(:space_chat)

*Note*: Individually-activated users are always activated, regardless of the percentage setting.  A deactivated user
may still have access to a feature if they fall within an active percentage.

Custom Feature-Active Tests
---------------------------

You can optionally inject your own code for testing if a feature is active. In rails, just added methods of the following form to your ApplicationController:

    # Example: override feature-active? for feature :new_homepage
    #
    # options:
    #   :feature => object of type Sapling::Feature
    #       (current settings for the feature from the database)
    #   :active => true if the feature would be active without the override
    #
    # remaining options are those passed to 'sapling.active?'
    #   :user => user to test for feature-active
    #   :context_id => Integer
    #
    # return true if the feature is active.
    def new_homepage_active?(options={})
      # your test here
    end

*Note* If you are using Sapling manually, when you create a Sapling instance, you can pass in an any object which responds to "current_user" and implements zero or more of your feature-active overrides.

Client-side Usage
-----------------

Sapling include a javascript helper which adds and removes classes on the HTML element for a given user, based upon the
features available to that user.

Given the feature `space_chat`, if it is enabled for the given user, the html root will get the class `sapling_feature_space_chat_on`.  If disabled for the given user, the class will be `sapling_feature_space_chat_off`.

To retrieve the class name for a given feature, you can use `sapling.css_class(feature)` and `sapling.css_toggle_class(feature, on? (boolean) )` in your ERB files.

Using the client-side tools, you can define CSS classes which will be visible/invisible when a feature is enabled/disabled.  For example:

CSS:

    /* Chat Defaults to being hidden for everyone */
    .sapling_feature_chat.enabled {
      display: none;
    }
    .sapling_feature_chat.disabled {
      display: block;
    }

    /* When chat is enabled, we hide the disabled container, and show the enabled container */
    html.sapling_feature_chat_on .sapling_feature_chat.enabled {
      display: block;
    }
    html.sapling_feature_chat_on .sapling_feature_chat.disabled {
      display: none;
    }


ERB:

    <div class="<%= sapling.css_class(:chat) %> enabled">
      REJOICE - SPIFF CHAT ENABLED FOR YOU
    </div>

    <div class="<%= sapling.css_class(:chat) %> disabled">
      DESPAIR - SPIFF CHAT NOT ENABLED FOR YOU
    </div>


*Note* Currently, the javascript generated depends on MooTools being loaded first.

TODO
----

* Rails 3 compatibility
* Remove mootools dependency
* Database migration generator
