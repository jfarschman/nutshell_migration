SELECT
   accounts.name as company_name,
   'Denver Metro Media' as publisher,
   IF(
    LOCATE('Ad Agency', accounts.tags),
    'Agency',
    'Advertiser'
   ) as company_type,
   'Denver' as market,
   'General' as category,
   'jill@denvermetromedia.com' as primary_rep,
   '' as primary_contact,
   '' as other_contacts,
   '1' as credit_status,          # 1 = pending, 2 = approved
   'Net 15' as payment_terms,
   '2' as payment_method,
   '0' as special_billing,
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
   'MST' as timezone,
   SUBSTRING_INDEX(SUBSTRING_INDEX(accounts.id, '-', 1), '-', -1) AS xref,
   #IF(
   # LOCATE(',', accounts.tags),
   # # Grab everything after the first comma by counting the number of commas and subtracting 1 from it.
   # TRIM(SUBSTRING_INDEX(accounts.tags, ',',-(CONVERT(char_length(accounts.tags) - char_length(replace(accounts.tags, ',', '')), SIGNED INTEGER)))),
   # accounts.tags
   #) as secondary_category,
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
   accounts.url as reference_url
FROM accounts
