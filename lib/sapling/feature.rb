module Sapling
  class Feature
    attr_accessor :name,:users,:percentage

    protected
    def normalize_users
      return unless users.kind_of?(Array)
      users = @users
      @users = {}
      users.each {|user_id| @users[user_id]=true}
    end
    public

    # options
    #   :users => array or hash
    #       users can be an array of user-ids or hash of user_ids mapped to true
    #   :percentage =>
    def initialize(name=nil,options={})
      @name = name
      @users = options[:users] || {}
      normalize_users
      self.percentage = options[:percentage]
    end

    # see Sapling::API::Client
    def active?(options={})
      options = Util.normalized_options(options)
      individually_active?(options[:user]) || percentage_active?(options)
    end

    def percentage_active?(options={})
      percentage && (Util.modded_context_id(options)) < percentage
    end

    def individually_active?(user)
      user && users[user.id]
    end

    def activate_user(user)
      users[user.id]=true
    end

    def deactivate_user(user)
      users.delete(user.id)
    end

    def activate_percentage(percentage)
      @percentage=percentage
    end

    def deactivate_percentage
      @percentage=0
    end
  end
end
