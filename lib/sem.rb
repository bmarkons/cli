require "sem/version"
require "dracula"
require "semaphore_client"
require "fileutils"
require "pmap"

module Sem
  require "sem/errors"
  require "sem/configuration"
  require "sem/srn"
  require "sem/cli"
  require "sem/api"
  require "sem/views"

  class << self

    # Returns exit status as a number.
    def start(args)
      Sem::CLI.start(args)

      0
    rescue Sem::Errors::ResourceNotFound => e
      on_resource_not_found(e)

      1
    rescue Sem::Errors::InvalidSRN => e
      on_invalid_srn(e)

      1
    rescue Sem::Errors::Auth::NoCredentials
      on_no_credentials

      1
    rescue Sem::Errors::Auth::InvalidCredentials
      on_invalid_credentials

      1
    rescue StandardError => e
      on_unhandled_error(e)

      1
    end

    private

    def on_resource_not_found(exception)
      puts "[ERROR] Resource not found."
      puts ""
      puts exception.message
    end

    def on_invalid_srn(exception)
      puts "[ERROR] Invalid parameter."
      puts ""
      puts exception.message
    end

    def on_no_credentials
      puts "[ERROR] You are not logged in."
      puts ""
      puts "Log in with '#{Sem::CLI.program_name} login --auth-token <token>'"
    end

    def on_invalid_credentials
      puts "[ERROR] Your credentials are invalid."
      puts ""
      puts "Log in with '#{Sem::CLI.program_name} login --auth-token <token>'"
    end

    def on_unhandled_error(exception)
      puts "[PANIC] Unhandled error."
      puts ""
      puts "Well, this is emberassing. An unknown error was detected."
      puts ""
      puts "Exception:"
      puts exception.message
      puts ""
      puts "Backtrace: "
      puts exception.backtrace
      puts ""
      puts "Please report this issue to https://semaphoreci.com/support."
    end
  end

end
