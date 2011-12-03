module Sapling::API
  module Client
    # options.kind_of? Hash
    #   :user => user
    #   :context_id => Integer
    # options.kind_of? Integer
    #   {:context_id => options}
    # else
    #   {:user => options}
    def active?(feature, options={}) {}
  end
end
