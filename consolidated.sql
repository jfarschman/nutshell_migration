SELECT
   accounts.name as company_name,
   'Denver Metro Media' as publisher,
   'Advertiser' as company_type,
   'Denver' as market,
   'General' as category,
   '2' as credit_status,
   'Net 30' as payment_terms,
   '2' as payment_method,
   '0' as special_billing,
   SUBSTRING_INDEX(SUBSTRING_INDEX(contacts.name, ' ', 1), ' ', -1) AS first_name,
   CASE WHEN TRIM(SUBSTR(contacts.name, LOCATE(' ', contacts.name))) IS NULL or TRIM(SUBSTR(contacts.name, LOCATE(' ', contacts.name))) = ''
     THEN 'unknown'
     else TRIM(SUBSTR(contacts.name, LOCATE(' ', contacts.name)))
   END as last_name,
   IF(
    LOCATE(',', contacts.email),
    SUBSTR(contacts.email, 1, LOCATE(',', contacts.email)-1),
    CASE WHEN contacts.email IS NULL or contacts.email = ''
      THEN 'no-email@denvermetromedia.com'
      ELSE contacts.email
    END
   ) as email,
   IF(
    LOCATE(',', contacts.phone),
    SUBSTR(SUBSTR(contacts.phone, 1, LOCATE(',', contacts.phone)-1),4),
    CASE WHEN contacts.phone IS NULL or contacts.phone = ''
      THEN '1234567890'
      ELSE SUBSTR(contacts.phone, 4)
    END
   ) as phone_complete,
   '' as phone,
   '' as phone_extension,
   accounts.address_1 as address_1,
   accounts.address_3 as address_2,
   accounts.city as city,
   accounts.state as state,
   accounts.postalCode as zip,
   accounts.country as country,
   'MST' as timezone,
   IF(
    LOCATE(',', accounts.url),
    SUBSTR(accounts.url, 1, LOCATE(',', accounts.url)-1),
    accounts.url
   ) as url,
   '' as contact_title,
   '' as middle_name,
   '' as contact_owner,
   accounts.fax as fax_number,
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
   contacts.tags
FROM accounts, contacts
WHERE accounts.contacts = contacts.id
