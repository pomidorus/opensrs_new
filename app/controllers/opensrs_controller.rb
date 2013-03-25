require 'nokogiri'

class OpensrsController < ApplicationController
  respond_to :xml, :only => :index

  def index
    puts request.headers["X-Username"]
    puts request.headers["X-Signature"]
    xml = Nokogiri::XML(params[:xml])
    puts xml
    # render "layouts/_get_order_info", :formats => [:xml], :header => {'sss' => 'ddd'}
    # render "layouts/_get_parse_csr", :formats => [:xml], :header => {'sss' => 'ddd'}
    # render "layouts/_get_trust_service_order", :formats => [:xml], :header => {'sss' => 'ddd'}

    # renew ssl templates
    # render "layouts/_get_renewal_order_for_a_quickssl_certificate", :formats => [:xml], :header => {'sss' => 'ddd'}
    # render "layouts/_get_an_order_to_upgrade_a_sitelock_ssl_certificate_to_sitelock_premium", :formats => [:xml], :header => {'sss' => 'ddd'}
    # render "layouts/_get_an_order_for_a_geotrust_web_site_anti_malware_scan_certificate", :formats => [:xml], :header => {'sss' => 'ddd'}
    # render "layouts/_get_an_order_for_a_30_day_free_trial_of_a_symantec_securesite_certificate", :formats => [:xml], :header => {'sss' => 'ddd'}
    # render "layouts/_get_a_new_order_for_a_quickssl_certificate_based_on_an_existing_order", :formats => [:xml], :header => {'sss' => 'ddd'}
    # render "layouts/_get_a_renewal_order_for_a_quickssl_certificate_that_was_submitted_by_using_the_order_id", :formats => [:xml], :header => {'sss' => 'ddd'}
    render "layouts/_get_a_renewal_order_for_a_quickssl_certificate_that_was_submitted_by_using_the_product_id", :formats => [:xml], :header => {'sss' => 'ddd'}

  end

end
