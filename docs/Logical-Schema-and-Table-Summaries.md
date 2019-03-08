The below is a the logical schema with the associated table summaries

## Logical Schema

User ( UID, First Name*, Last Name*, Email Address )

Arc ( UID, AID, Title*, Description, Parent Arc )  
_UID references User.UID_  
_Parent Arc references Arc.AID_

Task ( AID, TID, Title*, Description, Due Date, Location )  
_AID references Arc.AID_

## **Table User** 
This table stores the details of users. The table and its attributes have a one-to-one correspondence with concepts of the same name in the ER schema.

|||
| --- | --- |
| **Table** | User |
| **ER Origin** | Entity User |
| **Primary Key** | UID |
| **Foreign Keys** | None |
| **Uniqueness Constraint** | Email |

| **Name** | **Type** | **Constraint** | **Required /Optional** | **Default** | **Derived/Stored** | **Origin Entity** | **Origin Rel.** | **Origin Attr.** |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| UID | VARCHAR(60) | Length = 60 | Required |   | Stored | User |   | UID |
| First Name | VARCHAR(60) | Not Empty | Required |   | Stored | User |   | First Name |
| Last Name | VARCHAR(60) | Not Empty | Required |   | Stored | User |   | Last Name |
| Email | VARCHAR(319) | TRIM(Email) LIKE &#39;\_%@\_%.\_%&#39; | Optional |   | Stored | User |   | Email |


## **Table Arc** 
This table stores the details of Arcs. The table and its attributes have a one-to-one correspondence with concepts of the same name in the ER schema.

| |  |
| --- | --- |
| **Table** | Arc |
| **ER Origin** | Entity Arc |
| **Primary Key** | UID, AID |
| **Foreign Keys** | Parent Arc |
| **Uniqueness Constraint** | None |

| **Name** | **Type** | **Constraint** | **Required /Optional** | **Default** | **Derived/Stored** | **Origin Entity** | **Origin Rel.** | **Origin Attr.** |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| UID | VARCHAR(60) | Length = 60 | Required |   | Stored | User |   | UID |
| AID | VARCHAR(60) | Length = 60 | Required |   | Stored | Arc |   | AID |
| Title | VARCHAR(60) | Not Empty | Required |   | Stored | Arc |   | Title |
| Description | TEXT |   | Optional |   | Stored | Arc |   | Description |
| Parent Arc | VARCHAR(63) |   | Optional |   | Stored | Arc |   | AID |

## **Table Task** 
This table stores the details of tasks. The table and its attributes have a one-to-one correspondence with concepts of the same name in the ER schema.

| |  |
| --- | --- |
| **Table** | Task |
| **ER Origin** | Entity Task |
| **Primary Key** | AID, TID |
| **Foreign Keys** | None |
| **Uniqueness Constraint** | None |

| **Name** | **Type** | **Constraint** | **Required /Optional** | **Default** | **Derived/Stored** | **Origin Entity** | **Origin Rel.** | **Origin Attr.** |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| AID | VARCHAR(60) | Length = 60 | Required |   | Stored | Arc |   | AID |
| TID | VARCHAR(60) | Length = 60 | Required |   | Stored | Task |   | TID |
| Title | VARCHAR(60) | Not Empty | Required |   | Stored | Task |   | Title |
| Description | TEXT |   | Optional |   | Stored | Task |   | Description |
| Due Date | TIMESTAMP |   | Optional |   | Stored | Task |   | Due Date |
| Location | VARCHAR(256) |   | Optional |   | Stored | Task |   | Location |