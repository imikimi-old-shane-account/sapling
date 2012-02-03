API changes in 0.3.0
====================

When using Sapling in rails, there are some api changes:

  old: feature_active?(feature_name)
  new: sapling.active?(feature_name,options={})

  old: feature_class(feature_name)
  new: sapling.css_class(feature_name)
