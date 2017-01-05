SELECT
   accounts.name as cid,
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
   #IF(
   # LOCATE(',', contacts.phone),
   # # Grab everything after the first comma by counting the number of commas and subtracting 1 from it.
   # TRIM(SUBSTRING_INDEX(contacts.phone, ',',-(CONVERT(char_length(contacts.phone) - char_length(replace(contacts.phone, ',', '')), SIGNED INTEGER)))),
   # contacts.phone
   # ) as primary_phone,
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
   '' as title,
   contacts.address_1 as address_1,
   contacts.address_2 as address_2,
   contacts.city as city,
   contacts.state as state,
   contacts.postalCode as zip,
   contacts.country as country,
   'MST' as timezone,
   SUBSTR(contacts.fax, 4) as fax,
   '0' as update_flag,
   '' as contact_id,
   'Advertiser' as contact_type
FROM accounts, contacts
WHERE accounts.contacts = contacts.id
