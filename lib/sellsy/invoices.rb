require 'multi_json'

module Sellsy
  class Invoice
    attr_accessor :id
    attr_accessor :corp_name
    attr_accessor :owner_full_name
    attr_accessor :status
    attr_accessor :identity
    attr_accessor :contact_name

    attr_accessor  :total_amount_taxes_free
    attr_accessor  :taxes_amount_sum
    attr_accessor  :total_amount

    attr_accessor :client_id
    attr_accessor :packaging_name
    attr_accessor :shipping_name
    attr_accessor :amount
    attr_accessor :unit_amount
    attr_accessor :tax_rate

    # {"status":"ok","filename":"","fileid":"0","nbpages":"1","thirdident":"","thirdname":"Alain","thirdid":"2655","thirdvatnum":"","contactId":"0","contactName":"","displayedDate":"0000-00-00","currencysymbol":"\u20ac","subject":"","docspeakerText":"Votre contact","corpaddressid":"36047","thirdaddressid":"36048","shipaddressid":"36049","rowsAmount":"0.000000000","discountPercent":"0.000000000","discountAmount":"0.000000000","rowsAmountDiscounted":"0.000000000","offerAmount":"0.000000000","rowsAmountAllInc":"0.000000000","packagingsAmount":"49.900000000","shippingsAmount":"60.000000000","totalAmountTaxesFree":"109.900000000","taxesAmountSum":"21.540400000","taxesAmountDetails":"a:1:{s:12:\"19.600000000\";s:12:\"21.540400000\";}","totalAmount":"131.440400000","payDateText":"","payDateCustom":"0000-00-00","payMediumsText":"a:1:{i:0;s:7:\"ch\u00e8que\";}","payCheckOrderText":"","payBankAccountText":"","shippingNbParcels":"0","shippingWeight":"0.000000000","shippingWeightUnit":"g","shippingVolume":"0.000000000","shippingTrackingNumber":"","shippingTrackingUrl":"","saveThirdPrefs":"N","displayShipAddress":"N","corpid":"2","ownerid":"2","linkedtype":"invoice","linkedid":"9512","created":"2012-03-21 14:30:32","prefsid":"14679","parentid":"0","docmapid":"11599","hasVat":"Y","doctypeid":"9512","step":"draft","isDeposit":"N","dueAmount":"131.440400000","currencyid":"1","currencyposition":"right","numberformat":"fr","numberdecimals":",","numberthousands":"","numberprecision":"2","formatted_dueAmount":"131,44 \u20ac","step_color":"pink","step_hex":"#C033DA","step_label":"Non envoy\u00e9e","step_css":"colorDraft","step_banner":"draft_f","step_id":"draft","displayed_payMediumsText":"ch\u00e8que","formatted_totalAmount":"131,44 \u20ac","formatted_totalAmountTaxesFree":"109,90 \u20ac","formatted_displayedDate":"04\/04\/2012","formatted_payDateCustom":"04\/04\/2012","noedit":"N"}

    def create(invoice)
      command = {
          'method' => 'Document.create',
          'params' => {
              'document' => {
                  'doctype' => 'invoice',
                  # 'parentId' => 'parentId',
                  'thirdid' => invoice.client_id,
                  #'contactName' => invoice.contact_name
                  # 'displayedDate' => 'displayedDate',
                  # 'subject' => 'document_subject',
                  # 'notes' => 'document_notes',
                  # 'tags' => 'document_tags',
                  # 'displayShipAddress' => 'displayshippaddress_enum',
                  # 'rateCategory' => 'rateCategory',
                  # 'globalDiscount' => 'globalDiscount',
                  # 'globalDiscountUnit' => 'globalDiscountUnit',
                  # 'hasDoubleVat' => 'hasDoubleVat',
                  # 'currency' => 'currency',
                  # 'doclayout' => 'doclayout',
                  # 'payMediums' => 'payMediums'
              },
              # 'paydate' => {
              # 'id' => 'paydate_id',
              # 'xdays' => 'paydate_xdays',
              # 'endmonth' => 'paydate_endmonth',
              # 'scaledDetails' => 'paydate_scaledDetails',
              # 'custom' => 'paydate_custom'
              # },
              # 'thirdaddress' => {
              #     'id' => 'thirdaddress_id'
              # },
              # 'shipaddress' => {
              #     'id' => 'shipaddress_id'
              # },
              'row' => {
                  '1' => {
                      'row_type' => 'once',
                      'row_name' => 'promo code',
                      'row_qt' => 1,
                      'row_purchaseAmount' => 50,
                      'row_unitAmount' => 1,
                      # 'row_tax' => invoice.tax_rate
                      'row_taxid' => getTaxId,
                      # 'row_tax2id' => 'row_tax2id',
                      # 'row_qt' => 'row_quantity',
                      # 'row_isOption' => 'row_option',
                      # 'row_discount' => 'row_discount',
                      # 'row_discountUnit' => 'row_discountUnit'
                  },

                  # '3' => {
                  # 'row_type' => 'item',
                  # 'row_linkedid' => 'catalogue_id_link',
                  # 'row_declid' => 'catalogue_declid_link',
                  # 'row_name' => 'row_name',
                  # 'row_notes' => 'row_notes',
                  # 'row_unit' => 'row_unit',
                  # 'row_unitAmount' => 'row_unit_amount',
                  # 'row_tax' => 'row_taxrate',
                  # 'row_taxid' => 'row_taxid',
                  # 'row_tax2id' => 'row_tax2id',
                  # 'row_qt' => 'row_quantity',
                  # 'row_isOption' => 'row_option',
                  # 'row_purchaseAmount' => 'row_purchaseAmount',
                  # 'row_discount' => 'row_discount',
                  # 'row_discountUnit' => 'row_discountUnit'
                  # },
                  # '4' => {
                  # 'row_type' => 'once',
                  # 'row_name' => 'row_name',
                  # 'row_notes' => 'row_notes',
                  # 'row_unit' => 'row_unit',
                  # 'row_unitAmount' => 'row_unit_amount',
                  # 'row_tax' => 'row_taxrate',
                  # 'row_taxid' => 'row_taxid',
                  # 'row_tax2id' => 'row_tax2id',
                  # 'row_qt' => 'row_quantity',
                  # 'row_isOption' => 'row_option',
                  # 'row_discount' => 'row_discount',
                  # 'row_discountUnit' => 'row_discountUnit'
                  # }
              }
          }
      }

      response = MultiJson.load(Sellsy::Api.request command)

      @response = response['response']

      @response
    end

    def getTaxId
      command = {
          'method' =>  'Accountdatas.getTaxes',
          'params' => {}
      }

      response = MultiJson.load(Sellsy::Api.request command)

      @response = response['response']

      @response['defaultTaxId']
    end

    def update

    end
  end

  class Invoices
    def self.all
      command = {
          'method' => 'Document.getList',
          'params' => {
              'doctype' => 'invoice'
          }
      }

      response = MultiJson.load(Sellsy::Api.request command)

      invoices = []

      response['response']['result'].each do |key, value|
        invoice = Invoice.new
        invoice.id = value['id']
        invoice.corp_name = value['corpname']
        invoice.owner_full_name = value['ownerFullName']
        invoice.status = value['status']
        invoice.identity = value['ident']
        invoice.total_amount_taxes_free = value['totalAmountTaxesFree']
        invoice.taxes_amount_sum = value['taxesAmountSum']
        invoice.total_amount = value['totalAmount']
        invoice.amount = value['rowsAmount']
        invoices << invoice
      end

      return invoices
    end
  end
end
