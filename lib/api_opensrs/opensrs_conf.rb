module ApiOpenSRS

  CONTACT_TYPES = %w{ owner admin tech billing }
  CONTACT_SET = [
 		'first_name', 'last_name', 'title', 'org_name', 'address1', 'address2',
 		'city', 'region', 'country', 'country_id', 'postal_code', 'phone', 'fax', 'email'
 		]

  COMMAND_MAP = {
    :getOrderInfo => 'GetOrderInfo',
    :getProductInfo => 'GetProductInfo',
    :queryApproverList => 'QueryApproverList',
    :resendApproveEmail => 'ResendApproveEmail',
    :resendCertEmail => 'ResendCertEmail',
    :cancelOrder => 'CancelOrder',
    :parseCSR => 'ParseCSR',
    :SWRegister => 'SWRegister'
  }

  #START: Заглушки ответов для функций заказчика

  CANCEL_ORDER_HASH = {
     domain_name: "example.ru",
     order_id: "5555",
     state: "declined"
   }.freeze

  CLIENT_CONTACT = {
    first_name: "Andrey",
    last_name: "Seleznov",
    org_name: "Example Inc.",
    address1: "32 Oak St.",
    address2: "Suite 500",
    city: "Santa Clara",
    region: "Donbass",
    country: "RU",
    postal_code: "90210",
    phone: "+1.4165550123x1902",
    fax: "+1.4165550124",
    email: "owner@example.com",
    title: "mr",
    country_id: "1"
  }.freeze

  GET_ORDER_INFO_HASH = {
   owner: CLIENT_CONTACT,
   admin: CLIENT_CONTACT,
   billing: CLIENT_CONTACT,
   tech: CLIENT_CONTACT,
   comments: "",
   reg_domain: "",
   domain: "",
   transfer_notes: [{timestamp: "05-OCT-2007 17:07:42", note: "Transfer Request message sent to owner@example.com"}],
   affiliate_id: "",
   order_date: "1083590189",
   status: "completed",
   f_lock_domain: "0",
   forwarding_email: "",
   flag_saved_ns_fields: "1",
   processed_date: "",
   id: "3515690",
   encoding_type: "undef",
   flag_saved_tech_fields: "1",
   completed_date: "1083590192",
   f_auto_renew: "Y",
   fqdn1: "ns1.systemdns.com",
   fqdn2: "ns2.systemdns.com",
   fqdn3: "",
   fqdn4: "",
   fqdn5: "",
   fqdn6: "",
   reg_type: "new",
   notes: [{note: "RSP Note: testing first note", timestamp: "27-OCT-2007 11:15:03"},{note: "RSP Note: testing first note", timestamp: "27-OCT-2007 11:15:03"}],
   master_order_id: "0",
   period: "1",
   cost: "15"
  }.freeze

  GET_PRODUCT_INFO_HASH = {
    product_type: "truebizid_wildcard",
    issue_date: "2010-09-14-04:00",
    domain: "www.mail.ru",
    product_id: "23",
    contact_email: "qafive@example.com",
    start_date: "2010-09-13-04:00",
    expiry_date: "2010-09-22-04:00",
    is_renewable: "0",
    state: "expired"
  }.freeze

  GET_PRODUCT_INFO_ALL_HASH = {
    csr_data: {
      country: "Ukraina",
      organization_unit: "QA Dept",
      valid_true_domain: "1",
      state: "CA",
      locality: "Santa Clara",
      email: "qafive@example.com",
      domain: "abc123.example.org",
      valid_quick_domain: "1",
      has_bad_extensions: "0",
      organization: "Example Co."
    },
    notes_list: [
      {date: "2012-04-12T10:05:08.000-05:00", type: "product_active", note: "The product with the id [2071] has been created."}
    ],
    expiry_date: "2013-04-12T18:59:59.000-05:00",
    state: "active",
    product_type: "sitelock_premium",
    domain: "trust.example.org",
    issue_date: "2012-04-12T10:02:01.000-05:00",
    product_id: "2071",
    is_renewable: "0",
    contact_email: "qafive@example.com",
    contact_set: {
      admin: CLIENT_CONTACT,
      tech: CLIENT_CONTACT,
      organization: CLIENT_CONTACT,
      billing: CLIENT_CONTACT
    },
    csr: "-----BEGIN CERTIFICATE REQUEST----- MIIC2TCCAcECAQAwgZMxIDAeBgNVBAMTF3NzbDEyMy5xYXJlZ3Jlc3Npb24ub3Jn MQswCQYDVQQGEwJDQTELMAkGA1UECBMCT04xEDAOBgNVBAcTB1Rvcm9udG8xDzAN BgNVBAoTBlR1Y293czEQMA4GA1UECxMHUUEgRGVwdDEgMB4GCSqGSIb3DQEJARYR cWFmaXZlQHR1Y293cy5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIB AQDpKz48gJG4ImyJi76kH3AdDZoGNZCC8xgWBUDk4yNXPqe3NxJvZooZIoctP2o8 CX6+xoK8p6jMb9iIz7ZVC9LuoUmoYZZWdoatMUwaz3xIa4Fq7HeLtCE3misKMcZq +QomhLFv2yMSgyzWWitHdW5oVDuT83Xs8FTZG33rI8gut1J9+5fhJV4WKuncfLwM xMrj+5iWm+KwoE86dTarGAPwYhC2FepcblszVbz87Dp1clTJLaN4potMES83RHo1 teHHmJAilNzy2PfRoylbzlQ38x1n10wbhqjMcoDYk6CSB40PlduqbsMjpkOClwu4 H92c2Hmo3bqRGWM2K5SXkj29AgMBAAGgADANBgkqhkiG9w0BAQQFAAOCAQEAKUh6 WH4WtC/LtlJhj+p5i3sLEG/L//8DQh30eOxwMxrSGGZUGTfLBT4RaeDA5JEIF5pK v4MxvDw1+NExMQW3h/9eVWXpGGjvC2EoLgya3ri3OJlQNOyqSzOvNunk0EPaWoO+ v9o2yKdH88e7NQZp8Pw5jhE9RV9u3+mNw2sztqpzcXYDXW3kKI2UiIP3eur2/iiH nSAIRl5NfUPgAzCem/zpM1lc3s+EVKysn2wF4bwOkNyYPo4DmgHCb7ggSQyhh5vN UAoDkyqu2ZScDZTyDG7YOdobMqwbsCT5er5Bq+NWOZyUE+3zO/1VQpznJehaGLrQ N7UAJliUAO+SFFGdxQ== -----END CERTIFICATE REQUEST-----",
    upgrade_options: "sitelock_enterprise",
    start_date: "2012-04-11T19:00:00.000-05:00"
  }.freeze

  PARSE_CSR_HASH = {
    :country => 'RU',
    :organization_unit => 'IT',
    :valid_true_domain => true,
    :state => 'Moscow',
    :locality => 'Moscow locality',
    :email => 'info@example.ru',
    :domain_name => 'example.ru',
    :valid_quick_domain => true,
    :has_bad_extensions => false,
    :organization => 'ZAO Example',
  }.freeze

  QUERY_APPROVER_LIST_HASH = {
    approver_list: [
      {email: "qafive@example.com", domain: "example.com", type: "MANUAL"},
      {email: "ottway@example.com", domain: "example.com", type: "MANUAL"},
      {email: "qafive@example.com", domain: "example.com", type: "MANUAL"},
      {email: "admin@example.com", domain: "example.com", type: "MANUAL"},
      {email: "qafive@example.com", domain: "example.com", type: "MANUAL"}
    ]
  }.freeze

  RESEND_APPROVE_EMAIL_HASH = {
    order_id: "1111"
  }.freeze

  RESEND_CERT_EMAIL_HASH = {
    order_id: "1111"
  }.freeze

  SWREGISTER_NEW_DOMAIN_HASH = {
    admin_email: "jsmith@example.com",
    whois_privacy_state: "enabled",
    registration_text: "Domain registration successfully completed. WHOIS Privacy successfully enabled. Domain successfully locked.",
    registration_code: "200",
    id: "3735281",
    cancelled_orders: ["3764860","3764861"]
  }

  SWREGISTER_NEW_SERVICE_HASH = {
    domain: "google.com",
    order_id: "5555",
    state: "awaiting-approval"
  }

end