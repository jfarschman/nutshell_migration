SELECT
  company_name, publisher, company_type, market, category, credit_status, payment_terms, special_billing,
  first_name, last_name, email,
  TRIM(SUBSTRING_INDEX(phone_complete, ' ',1)) as phone,
  IF(
    LOCATE('ext', phone_complete),
    # Grab everything after the first comma by counting the number of commas and subtracting 1 from it.
    TRIM(SUBSTRING_INDEX(phone_complete, ' ',-1)),
    ''
  ) as extension,
  address_1, address_2, city, state, zip, country, timezone, url, 
  SUBSTR(fax_number, 4) as fax, 
  twitter, facebook, linkedin, reference_url
FROM consolidated_import
