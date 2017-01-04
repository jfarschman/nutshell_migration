SELECT 
   '' as cid,
   SUBSTRING_INDEX(SUBSTRING_INDEX(contacts.name, ' ', 1), ' ', -1) AS first_name,
   TRIM( SUBSTR(contacts.name, LOCATE(' ', contacts.name)) ) AS last_name,
   IF(
    LOCATE(',', contacts.email),
    SUBSTR(contacts.email, 1, LOCATE(',', contacts.email)-1),
    contacts.email
   ) as email,
   IF(
    LOCATE(',', contacts.phone),
    # Grab everything after the first comma by counting the number of commas and subtracting 1 from it.
    TRIM(SUBSTRING_INDEX(contacts.phone, ',',-(CONVERT(char_length(contacts.phone) - char_length(replace(contacts.phone, ',', '')), SIGNED INTEGER)))),
    contacts.phone
    ) as primary_phone,
    '' as title,
   contacts.address_1 as address_1,
   contacts.address_2 as address_2,
   contacts.city as city,
   contacts.state as state,
   contacts.postalCode as zip,
   contacts.country as country,
   'MST' as timezone,
   contacts.fax as fax,
   "N" as primary_contact,
   SUBSTRING_INDEX(SUBSTRING_INDEX(contacts.accounts, '-', 1), '-', -1) AS xref,
   "N" as billing_contact,
   "N" as artwork_contact,
   '' as email_home,
   '' as email_other,
   '' as work_phone_ext,
   '' as primary_phone_ext,
   '' as alternate_phone,
   '' as prospect_name,
   '' as salutation,
   '' as user_name,
   '' as lead_status,
   '' as lead_source,
   SUBSTRING_INDEX(SUBSTRING_INDEX(contacts.accounts, '-', 1), '-', -1) AS contact_xref,
   '' as middle_name,
   '' as contact_owner,
   '' as suffix,
   '0' as update_flag,
   '' as contact_id,
   'Advertiser' as contact_type
FROM contacts