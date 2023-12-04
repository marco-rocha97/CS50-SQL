-- write a sequence of SQL statements to achieve the following:

-- Alter the password of the website’s administrative account, admin, to instead be “oops!”.
-- Erase any logs of the above password change recorded by the database.
-- Add false data to throw others off your trail. In particular, to frame emily33, make it only appear—in the user_logs table—as if the admin account has had its password changed to emily33’s password.
-- When your SQL statements in hack.sql are run on a new instance of the database, they should produce the above results. 
-- Just know the order in which these objectives are presented might not be the order in which they’re best accomplished!

-- Also keep in mind that passwords are usually not stored “in the clear”—that is, as the plain characters that make up the password. Instead they’re “hashed,” or scrambled, to preserve privacy. 
-- Given this reality, you’ll need to ensure the password to which you change the administrative password is also hashed. 
-- Thankfully, you know that the passwords in the users table are already stored as MD5 hashes. 
-- You can generate quickly generate such hashes from plaintext at md5hashgenerator.com.
UPDATE "users"
   SET password = (SELECT "new_password" FROM "user_logs" WHERE "new_username" = 'emily33')
 WHERE "username" = 'admin';

UPDATE users
   SET password = '982c0381c279d139fd221fce974916e7'
 WHERE "username" = 'admin';

DELETE FROM user_logs
 WHERE "new_password" = '982c0381c279d139fd221fce974916e7';
