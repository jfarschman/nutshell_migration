SELECT 
   accounts.name as company_name,
   'Denver Metro Media' as publisher,
   'Advertiser' as company_type,
   'Denver' as market,
   IF(
    LOCATE(',', accounts.tags),
    SUBSTR(accounts.tags, 1, LOCATE(',', accounts.tags)-1),
    accounts.tags
   ) as category,
   'jill@denvermetromedia.com' as primary_rep,
   '' as primary_contact,
   '' as other_contacts,
   '2' as credit_status,
   'Net 30' as payment_terms,
   '2' as payment_method,
   '0' as special_billing,
   '' as billing_notes,
   '' as write_off_flag,
   '' as require_backup_payment_flag,
   '' as in_collections,
   IF(
    LOCATE(',', accounts.url),
    SUBSTR(accounts.url, 1, LOCATE(',', accounts.url)-1),
    accounts.url
   ) as url,
   accounts.address_1 as address_1,
   accounts.address_2 as address_2,
   accounts.city as city,
   accounts.state as state,
   accounts.postalCode as zip,
   accounts.country as country,
   '1' as currency,
   '' as barter_type,
   '' as additional_reps,
   'MST' as timezone,
   '' as billing_contact,
   '' as artwork_contact,
   SUBSTRING_INDEX(SUBSTRING_INDEX(accounts.id, '-', 1), '-', -1) AS xref,
  IF(
    LOCATE(',', accounts.tags),
    # Grab everything after the first comma by counting the number of commas and subtracting 1 from it.
    TRIM(SUBSTRING_INDEX(accounts.tags, ',',-(CONVERT(char_length(accounts.tags) - char_length(replace(accounts.tags, ',', '')), SIGNED INTEGER)))),
    accounts.tags
   ) as secondary_category,
   '' as agency,
   IF(
    # Twitter starts with @ Let's just mark it and fix it with AWK... maybe
    LOCATE('@', accounts.url),
    '1',
    ''
   ) as twitter,
   IF(
    LOCATE('facebook', accounts.url),
    '1',
    ''
   ) as facebook,
   IF(
    LOCATE('linkedin', accounts.url),
    '1',
    ''
   ) as linkedin,
   accounts.url as reference_url,
   '' as parent_cid,
   '' as parent_xref
FROM accounts
# LIMIT 1000

