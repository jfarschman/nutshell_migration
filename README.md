# nutshell_migration

#### Table of Contents

1. [Overview](#overview)
2. [Usage - How to Start](#usage)
3. [Limitations - OS compatibility, etc.](#limitations)
4. [Contributors](#contributors)

## Overview
This task sprang out of my need to migrate data out of Nutshell, a generic
CRM into a CRM designed for publishing. This walks through the process in
simple terms.

## Usage

### Assumptions

* MySQL - you have a MySQL/MariaDB server available

### Export the Nutshell data
As a Nutshell Administrator, Under "Settings," choose "Export" and 
"Create a full export". When you download this export you will find
a collection of .csv files, one per table.

### Create a DB
I used "Sequel Pro" to create the database because it lets you simply
"Import" tables one at a time.  The important tables you will need are
accounts and contacts.

### Queries
These queries solve a few problems, mostly dealing with violations of
first normal form. For instance:

* Nutshell keeps firstname and lastname in a fullname field
* Nutshell keeps multile phone numbers in a single row.
* etc...

```SELECT 
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
   TRIM( SUBSTR(contacts.name, LOCATE(' ', contacts.name)) ) AS last_name,
   IF(
    LOCATE(',', contacts.email),
    SUBSTR(contacts.email, 1, LOCATE(',', contacts.email)-1),
    contacts.email
   ) as email,
   IF(
    LOCATE(',', contacts.phone),
    SUBSTR(contacts.phone, 1, LOCATE(',', contacts.phone)-1),
    contacts.phone
   ) as phone,
   '' as phone_extension,
   accounts.address_1 as address_1,
   accounts.address_3 as address_2,
   accounts.city as city,
   accounts.state as state,
   accounts.postalCode as zip,
   accounts.country as country,
   'MST' as timezone,
   '' as salutation,
   '' as username,
   '' as lead_status,
   '' as lead_source,
   IF(
    LOCATE(',', accounts.url),
    SUBSTR(accounts.url, 1, LOCATE(',', accounts.url)-1),
    accounts.url
   ) as url,
   '' as contact_title,
   '' as middle_name,
   '' as contact_owner,
   accounts.fax as fax_number,
   contacts.tags
FROM accounts, contacts
WHERE accounts.contacts = contacts.id LIMIT 100```
 


## Limitations


## Contributors
* Jay Farschman - jay@denvermetromedia.com
