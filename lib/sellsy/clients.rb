require 'multi_json'

module Sellsy
  class Clients
    attr_accessor :name
    attr_accessor :type
    attr_accessor :email
    attr_accessor :phone_number
    attr_accessor :siret
    attr_accessor :siren
    attr_accessor :rcs
    attr_accessor :corp_type
    attr_accessor :first_name
    attr_accessor :last_name
    attr_accessor :client_id
    attr_accessor :tags
    attr_accessor :response


    def initialize(opts = {})
      @name = opts[:name]
      @type = opts[:type]
      @email = opts[:email]
      @phone_number = opts[:phone_number]
      @siret = opts[:siret]
      @siren = opts[:siren]
      @rcs = opts[:rcs]
      @corp_type = opts[:corp_type]
      @tags = opts[:tags]
      @first_name = opts[:first_name]
      @last_name = opts[:last_name]
      @client_id = opts[:client_id]
      @response = nil
    end


    def create
      command = {
          'method' => 'Client.create',
          'params' => {
              'third' => {
                  'name' => @name,
                  'type' => @type,
                  'email' => @email,
                  'tel' => @phone_number,
                  'siret' => @siret,
                  'siren' => @siren,
                  'rcs' => @rcs,
                  'corpType' => @corp_type,
                  'tags' => @tags,
              },
              'contact' => {
                  'name' => "#{@first_name} #{@last_name}",
                  'email' => @email,
                  'tel' => @phone_number
              }
          }
      }

      response = MultiJson.load(Sellsy::Api.request command)

      @client_id = response['response']
      return response['status'] == 'success'
    end

    def update_custom_fields(custom_fields)
      command = {
          'method' => 'CustomFields.recordValues',
          'params' => {
              'linkedtype' => 'client',
              'linkedid' => @client_id,
              #'values' => [{'cfid' => custom_field[:id], 'value' => custom_field[:value]}]
              'values' => custom_fields
          }
      }

      response = MultiJson.load(Sellsy::Api.request command)
      puts "================================="
      puts response
      puts "================================="

      @response = response

      return response['status'] == 'success'
    end

    def add_contact
      command = {
          'method' => 'Client.addContact',
          'params' => {
              'clientid' => @client_id,
              'third' => {
                  'name' => "#{@first_name} #{@last_name}",
                  'email' => @email,
                  'tel' => @phone_number
              }
          }
      }

      response = MultiJson.load(Sellsy::Api.request command)

      @id = response['response']['contact_id']

      return response['status'] == 'success'
    end

    def get_client
      command = {
          'method' => 'Client.getOne',
          'params' => {
              'id' => @client_id,
          }
      }

      response = MultiJson.load(Sellsy::Api.request command)

      @response = response['response']

      @response
    end

  end

end
