# Stolen from lib/devise/test_helpers.rb. Ripped out devise specific stuff.
module WardenControllerTestHelpers
  def self.included(base)
    base.class_eval do
      if respond_to?(:setup)
        setup :setup_controller_for_warden, :warden
      end
    end
  end

  # Override process to consider warden.
  def process(*)
    # Make sure we always return @response, a la ActionController::TestCase::Behavior#process, even if warden interrupts
    _catch_warden { super } || @response
  end

  # We need to setup the environment variables and the response in the controller
  def setup_controller_for_warden
    @request.env['action_controller.instance'] = @controller
  end

  # Quick access to Warden::Proxy.
  def warden
    @warden ||= begin
      warden_manager_block = Rails.application.config.middleware.detect{ |m|
        m.name == 'Warden::Manager'
      }.block
      manager = Warden::Manager.new(nil, &warden_manager_block)
      @request.env['warden'] = Warden::Proxy.new(@request.env, manager)
    end
  end

  def sign_in(*args)
    warden.set_user *args
  end

  def sign_out(*args)
    warden.logout *args
  end

  protected

  # Catch warden continuations and handle like the middleware would.
  # Returns nil when interrupted, otherwise the normal result of the block.
  def _catch_warden(&block)
    result = catch(:warden, &block)

    env = @controller.request.env

    result ||= {}

    # Set the response. In production, the rack result is returned
    # from Warden::Manager#call, which the following is modelled on.
    case result
    when Array
      if result.first == 401 && intercept_401?(env) # does this happen during testing?
        _process_unauthenticated(env)
      else
        result
      end
    when Hash
      _process_unauthenticated(env, result)
    else
      result
    end
  end

  def _process_unauthenticated(env, options = {})
    options[:action] ||= :unauthenticated
    proxy = env['warden']
    result = options[:result] || proxy.result

    ret = case result
    when :redirect
      body = proxy.message || "You are being redirected to #{proxy.headers['Location']}"
      [proxy.status, proxy.headers, [body]]
    when :custom
      proxy.custom_response
    else
      env["PATH_INFO"] = "/#{options[:action]}"
      env["warden.options"] = options
      Warden::Manager._run_callbacks(:before_failure, env, options)

      status, headers, response = warden.config[:failure_app].call(env).to_a

      @controller.send :render, {
        :status => status,
        :text => response.body,
        :content_type => headers["Content-Type"],
        :location => headers["Location"],
      }

      nil # causes process return @response
    end

    # ensure that the controller response is set up. In production, this is
    # not necessary since warden returns the results to rack. However, at
    # testing time, we want the response to be available to the testing
    # framework to verify what would be returned to rack.
    if ret.is_a?(Array)
      # ensure the controller response is set to our response.
      @controller.response ||= @response
      @response.status = ret.first
      @response.headers = ret.second
      @response.body = ret.third
    end

    ret
  end
end
