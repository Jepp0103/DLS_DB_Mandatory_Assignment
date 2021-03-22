# Database
This directory consists of several files, which are explained as:
- `roll_call_db.mwb` - this is the main entry file, which includes the Physical Model (EER Diagram), embedded script that populates test data, views. (Stored procedures, functions, and Triggers)
- `roll_call_db_forward_engineered.sql` - this is the manually exported script after forward engineering the EER Diagram from the `roll_call_db.mwb` file. It's purpose is to be used to create the database if there is no possibility to use MySQL Workbench to open the binary `.mwb` file.
- `populating_data.sql` - this script is a manual export of the embedded script into the `roll_call_db.mwb` file.
- `functions.sql` - this script is meant to be manual export from the `roll_call_db.mwb` file, but for now it is the only source of the implemented functions.
- `views.sql` - this script is a manual export of the embedded views into the `roll_call_db.mwb` file.
- `design` directory - consists of 3 self explanatory PNG files, which represent each of the models as exported overviews (exports from Draw.io and MySQL Workbench)


## Brief instruction on how to install and use this database
> Prerequisites:
- MySQL Community Server 8.0.21 or 8.0.23


> Installation:
- The easiest way to deploy the database is to use MySQL Workbench (8.0.21 or 8.0.23) to open the binary file `roll_call_db.mwb`. Once it is opened, using the menu navigation, choose "Database" and then "Forward Engineer...". From there follow the steps by clicking "Next" (making use on the first step a valid connection to the MySQL server is established - using a root account). There should be 15 Table objects and 2 View objects selected, continue by pressing "Next" again, review the script that will be executed (can skip this step) and then click "Next" again. The server should now successfully have the schema created and it should be automatically populated with test data, as there is an embedded script inside the binary `.mwb` file, that runs automatically once the shema was created.

- The "manual" way to deploy it is to use the scripts inside the current (`database`) directory. First execute the `roll_call_db_forward_engineered.sql` script, wich will create the schema, but will not have preloaded test data or the View objects. They needed to be executed manually as well. First run the `views.sql` script and then the `populating_data.sql` file to fill up the database with test data.

```
N.B. For now the two Views are not returning any data. There are no other Stored Objects that can be used to query the data. All queries for now are via manual scripting.
```
