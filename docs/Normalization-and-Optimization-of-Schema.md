## Arc

| UID | AID | Title | Description | Parent Arc |
| --- | --- | --- | --- | --- |

**Candidate Keys:** UID is the only candidate key because AID is a FK and the remaining attributes or any combination of AID with the remaining attributes do not guarantee uniqueness.

### Functional Dependencies:

(UID, AID) -> Tile

(UID, AID) -> Description

(UID, AID) -> Parent Arc

**1NF:** Arc is already in first normal form because there are no composite attributes in this table and all non-key attributes depend on a key-attribute.

**2NF:** There are no partial dependencies because there are no partial candidate keys. Therefore, Arc is already in second normal form.

**3NF:** Arc is in third normal form because there are no non-key attributes that depend on something other than a candidate key.

**BCNF:** There are no key-attribute dependencies because the is only one key attribute, therefore the Arc table is in Boyce-Codd normal form.

## Task

| AID | TID | Title | Description | Due Date | Location |
| --- | --- | --- | --- | --- | --- |

**Candidate Keys:** The combination of AID and TID is the only candidate key.

### Functional Dependencies:

(AID, TID) -> Title

(AID, TID) -> Description

(AID, TID) -> Due Date

(AID, TID) -> Location

**1NF:** Task is in first normal form because there are no composite attributes in this table and all non-key attributes depend on a key-attribute.

**2NF:** There are no partial dependencies because all non-key attributes depend on whole candidate-keys, therefore the Task table is in second normal form.

**3NF:** There are no transitive dependencies because there are no non-key attributes that depend on something other than a candidate key. Title, Description, DueDate, and Location all depend upon the combination of the AID and TID. Therefore, the Task table is in third normal form.

**BCNF:** There are no key-attribute dependencies because all key attributes do not depend on anything other than a candidate key. Therefore, the Task table is in Boyce-Codd normal form.

## User

| UID | First Name | Last Name | Email Address |
| --- | --- | --- | --- |

**Candidate Keys:** The only candidate key is UID.

### Functional Dependencies:

UID -> First Name

UID -> Last Name

UID -> Email Address

**1NF:** User is in first normal form because there are no composite attributes in this table and all non-key attributes depend on a key-attribute.

**2NF:** There are no partial dependencies because all non-key attributes depend on whole candidate-keys, therefore the User table is in second normal form.

**3NF:** There are no transitive dependencies because there are no non-key attributes that depend on something other than a candidate key, so the User table is in third normal form.

**BCNF:** There are no key-attribute dependencies because all key attributes do not depend on anything other than a candidate key. Therefore, the User table is in Boyce-Codd normal form.

# Optimization

## Normalize Lookup Data

Every table contains an ID attribute. Normalization is not needed for any tables.

## De-Normalization

No changes were made during normalization.

## Optimizations for Physical Design

Physical design has not yet been implemented, but this will be considered in future planning.