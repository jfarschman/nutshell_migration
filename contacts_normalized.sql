SELECT
  cid,
  first_name, last_name, email, 
  TRIM(SUBSTRING_INDEX(phone_complete, ' ',1)) as phone,
  IF(
     LOCATE('ext', phone_complete),
    # Grab everything after the first comma by counting the number of commas and subtracting 1 from it.
    TRIM(SUBSTRING_INDEX(phone_complete, ' ',-1)),
    ''
  ) as extension,
  title, address_1, address_2, city, state, zip, country, timezone, fax, update_flag, contact_id, contact_type
FROM contacts_import
