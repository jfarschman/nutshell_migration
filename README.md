# nutshell_migration

#### Table of Contents

1. [Overview](#overview)
2. [Usage - How to Start](#usage)
    * [Assumptions](#assumptions)
    * [Exort the Data](#export-the-nutshell-data)
    * [Create a DB](#create-a-db)
    * [Normalizing](#normalizing)
    * [Data Cleaning](#data-cleaning)
    * [Test Import](#test-import)
    * [Import it](#import-it)
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

### Normalizing
These queries solve a few problems, mostly dealing with violations of
first normal form. I'm not sure if Nutshell uses these internal data structures
or if it's only on export that they fly in the face of rational data For instance:

* firstname and lastname in a single field, fullname.
* Multile phone numbers in a single row.
* Extensions in with the phone number (123-456-7890 ext. 123)
* Multiple URLs (twitter, facebook, linkedIn, website) in one entry
* Phone numbers include +1 in front of all numbers

Mostly, the problems were about multiple entries in a single column seperate by 
commas. If you search around for help with this it's kinda fun because purists 
are horrified that I built a database in violation of the first and more sacred
rule. Others are more relaxed and realize we are simply fixing data we inherited
from some other source.

### Data Cleaning
This next bit is simply looking for lame data in your resulting, normalized data.
The best place to start if to run a test import. In my case, the destination 
offers a test import which can rip through thousands of records and expose any
widespread problems. In my case, I had omitted a required field and simply added
it another query.

Then I did the following in Sequel Pro:

# Sort by email address and check any duplicates. Some of there were nearly identical
# Sort by each individual field and scroll around and look for irregularities.
# Sort by company_name and make sure you dont have dupes.

### Test Import
By this I mean, take a small (5 record) subset of your data and import it to see
what the results look like.

### Import it.
Just do it.

## Limitations


## Contributors
* Jay Farschman - jay@denvermetromedia.com
