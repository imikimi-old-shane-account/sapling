API changes in 0.3.0
====================

When using Sapling in rails, there are some api changes:

  old: feature_active?(feature_name)
  new: sapling.active?(feature_name,options={})

  old: feature_class(feature_name)
  new: sapling.css_class(feature_name)

0.4.0
=====

Added option value for overrides. The hash value :active is now passed into every override method called. This indicates if the feature would be active without the override.

Fixed fatal bug in the Sapling+Rails controller javascript generation.
