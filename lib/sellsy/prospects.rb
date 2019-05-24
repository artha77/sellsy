require 'multi_json'

module Sellsy
  class Prospects
    attr_accessor :name
    attr_accessor :type
    attr_accessor :email
    attr_accessor :tel
    attr_accessor :mobile
    attr_accessor :siret
    attr_accessor :siren
    attr_accessor :rcs
    attr_accessor :corp_type
    attr_accessor :first_name
    attr_accessor :last_name

    def create
      command = {
          'method' => 'Prospects.create',
          'params' => {
              'third' => {
                  'name'			=> @name,
                  'type'			=> @type,
                  'email'			=> @email,
                  'tel'			  => @tel,
                  'mobile'		=> @mobile,
                  'siret'		  => @siret,
                  'siren'		  => @siren,
                  'rcs'		    => @rcs,
                  'corpType' => @corp_type,
              },
             'contact' => {
                 'name' => "#{@first_name} #{@last_name}",
                 'email' => @email,
                 'tel' => @tel
             }
          }
      }

      response = MultiJson.load(Sellsy::Api.request command)

      @id = response['response']['client_id']

      return response['status'] == 'success'
    end

  end

end
